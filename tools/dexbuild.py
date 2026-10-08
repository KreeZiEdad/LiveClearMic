"""Small, offline Smali subset assembler for this inspectable Android prototype.
Uses the published DEX 035 format. Not intended as a general Android toolchain.
"""
from __future__ import annotations
import struct, hashlib, zlib, re, json
from pathlib import Path
from dataclasses import dataclass, field
P=lambda fmt,*x: struct.pack('<'+fmt,*x)

def uleb(n):
    assert 0 <= n <= 0xffffffff
    out=bytearray()
    while n>127: out.append((n&127)|128); n>>=7
    out.append(n); return bytes(out)

def types(s):
    out=re.findall(r'\[*(?:L[^;]+;|[VZBSCIJFD])',s)
    assert ''.join(out)==s, s
    return tuple(out)

def meth(s):
    c,rest=s.split('->'); name,args=rest.split('(',1); a,r=args.split(')')
    return c,name,r,types(a)

def fld(s):
    c,x=s.split('->'); n,t=x.split(':'); return c,n,t

def words(ts): return sum(2 if t in ('J','D') else 1 for t in ts)

def mutf(s):
    out=bytearray()
    v=s.encode('utf-16-le','surrogatepass')
    for i in range(0,len(v),2):
        c=v[i]|v[i+1]<<8
        if 0<c<128: out.append(c)
        elif c<2048: out.extend((0xc0|(c>>6),0x80|(c&63)))
        else: out.extend((0xe0|(c>>12),0x80|((c>>6)&63),0x80|(c&63)))
    return uleb(len(v)//2)+out+b'\x00'

FLAGS={'public':1,'private':2,'protected':4,'static':8,'final':16,
       'volatile':64,'abstract':1024,'constructor':65536}
def flags(parts):
    v=0
    for p in parts: v|=FLAGS[p]
    return v

@dataclass
class Method:
    key:tuple
    flags:int
    local:int=0
    lines:list=field(default_factory=list)
    catches:list=field(default_factory=list)
    @property
    def ins(self): return words(self.key[3])+(0 if self.flags&8 else 1)
    @property
    def regs(self): return self.local+self.ins
    def reg(self,s):
        s=s.strip(); n=int(s[1:]); v=n+(self.local if s[0]=='p' else 0)
        assert 0<=v<self.regs, (self.key,s,v,self.regs)
        return v

@dataclass
class Cls:
    name:str
    flags:int
    super:str='Ljava/lang/Object;'
    interfaces:list=field(default_factory=list)
    fields:list=field(default_factory=list)
    methods:list=field(default_factory=list)

OP11={'move-result':0x0a,'move-result-wide':0x0b,'move-result-object':0x0c,
      'move-exception':0x0d,'return':0x0f,'return-wide':0x10,'return-object':0x11,'throw':0x27}
OP12={'move':0x01,'move-wide':0x04,'move-object':0x07,'array-length':0x21,
      'int-to-long':0x81,'int-to-float':0x82,'float-to-int':0x87,
      'add-int/2addr':0xb0,'sub-int/2addr':0xb1,'sub-long/2addr':0xbc,'mul-float/2addr':0xc8}
OP23={'cmp-long':0x31,'aget':0x44,'aget-object':0x46,'aput-object':0x4d,
      'add-int':0x90,'sub-int':0x91,'add-long':0x9b,'sub-long':0x9c,'mul-float':0xa8}
IFields={'iget':0x52,'iget-wide':0x53,'iget-object':0x54,'iget-boolean':0x55,
         'iput':0x59,'iput-wide':0x5a,'iput-object':0x5b,'iput-boolean':0x5c}
SFields={'sget':0x60,'sget-wide':0x61,'sget-object':0x62,'sget-boolean':0x63,
         'sput':0x67,'sput-wide':0x68,'sput-object':0x69,'sput-boolean':0x6a}
INVOKE={'invoke-virtual':0x6e,'invoke-super':0x6f,'invoke-direct':0x70,
        'invoke-static':0x71,'invoke-interface':0x72}
INVOKE_RANGE={'invoke-virtual/range':0x74,'invoke-super/range':0x75,'invoke-direct/range':0x76,
              'invoke-static/range':0x77,'invoke-interface/range':0x78}
IFZ={'if-eqz':0x38,'if-nez':0x39,'if-ltz':0x3a,'if-gez':0x3b,'if-gtz':0x3c,'if-lez':0x3d}
IF2={'if-eq':0x32,'if-ne':0x33,'if-lt':0x34,'if-ge':0x35,'if-gt':0x36,'if-le':0x37}

class Assembler:
    def __init__(self): self.classes=[]; self.strings=set(); self.ts=set(); self.ms=set(); self.fs=set(); self.ps=set(); self.sources={}
    def addtype(self,t): self.ts.add(t); self.strings.add(t)
    def addmethod(self,k):
        self.ms.add(k); self.strings.add(k[1]); self.addtype(k[0]); self.addtype(k[2])
        for t in k[3]: self.addtype(t)
        proto=(k[2],k[3]); self.ps.add(proto)
        self.strings.add(''.join('L' if t.startswith(('L','[')) else t for t in (k[2],)+k[3]))
    def addfield(self,k):
        self.fs.add(k); self.addtype(k[0]); self.addtype(k[2]); self.strings.add(k[1])
    def load(self,path):
        cl=None; m=None
        for ln,line in enumerate(Path(path).read_text().splitlines(),1):
            line=line.strip()
            if not line or line.startswith('#'): continue
            if line.startswith('.class '):
                p=line.split(); cl=Cls(p[-1],flags(p[1:-1])); self.classes.append(cl); self.addtype(cl.name)
                self.strings.add(Path(path).name); self.sources[cl.name]=Path(path).name
            elif line.startswith('.super '): cl.super=line.split()[1]; self.addtype(cl.super)
            elif line.startswith('.implements '):
                t=line.split()[1]; cl.interfaces.append(t); self.addtype(t)
            elif line.startswith('.field '):
                p=line.split(); k=fld(cl.name+'->'+p[-1]); fl=flags(p[1:-1]); cl.fields.append((k,fl)); self.addfield(k)
            elif line.startswith('.method '):
                p=line.split(); k=meth(cl.name+'->'+p[-1]); m=Method(k,flags(p[1:-1])); cl.methods.append(m); self.addmethod(k)
            elif line.startswith('.locals '): m.local=int(line.split()[1])
            elif line=='.end method': m=None
            elif line.startswith('.catch '):
                ma=re.fullmatch(r'.catch (\S+) \{(:\S+) \.\. (:\S+)\} (:\S+)',line); assert ma,line
                c,a,b,h=ma.groups(); self.addtype(c); m.catches.append((a,b,c,h))
            elif line.startswith(':'): m.lines.append(('label',line,ln))
            else:
                assert m,(path,ln,line)
                op,_,args=line.partition(' '); m.lines.append((op,args,ln))
                if op in INVOKE or op in INVOKE_RANGE: self.addmethod(meth(args.split('},',1)[1].strip()))
                elif op in IFields or op in SFields: self.addfield(fld(args.rsplit(',',1)[1].strip()))
                elif op in ('const-class','check-cast','new-instance','new-array'): self.addtype(args.rsplit(',',1)[1].strip())
                elif op=='const-string': self.strings.add(json.loads(args.split(',',1)[1].strip()))
    def size(self,op):
        if op=='label': return 0
        if op in OP11 or op in OP12 or op in ('return-void','const/4','nop'): return 1
        if op in ('const','const-wide/32') or op in INVOKE or op in INVOKE_RANGE: return 3
        if op in OP23 or op in IFields or op in SFields or op in IF2 or op in IFZ or op in ('const/16','const-wide/16','const-string','const-class','check-cast','new-instance','new-array','goto/16','add-int/lit8'): return 2
        raise ValueError(op)
    def code(self,m):
        labels={}; pc=0
        for op,a,ln in m.lines:
            if op=='label': assert a not in labels; labels[a]=pc
            pc+=self.size(op)
        units=[]; outs=0; boundaries=set(); invokes=0
        r=m.reg
        for op,a,ln in m.lines:
            if op=='label': continue
            pc=len(units); boundaries.add(pc); p=[x.strip() for x in a.split(',')]
            try:
                if op=='return-void': u=[0x0e]
                elif op=='nop': u=[0]
                elif op in OP11: u=[OP11[op]|r(p[0])<<8]
                elif op in OP12:
                    aa,bb=r(p[0]),r(p[1]); assert max(aa,bb)<16; u=[OP12[op]|aa<<8|bb<<12]
                elif op=='const/4':
                    aa=r(p[0]); n=int(p[1],0); assert aa<16 and -8<=n<=7; u=[0x12|aa<<8|(n&15)<<12]
                elif op in ('const/16','const-wide/16'):
                    n=int(p[1],0); assert -32768<=n<=32767; u=[(0x13 if op=='const/16' else 0x16)|r(p[0])<<8,n&65535]
                elif op in ('const','const-wide/32'):
                    n=int(p[1],0)&0xffffffff; u=[(0x14 if op=='const' else 0x17)|r(p[0])<<8,n&65535,n>>16]
                elif op=='const-string': u=[0x1a|r(p[0])<<8,self.si[json.loads(a.split(',',1)[1].strip())]]
                elif op in ('const-class','check-cast','new-instance'):
                    o={'const-class':0x1c,'check-cast':0x1f,'new-instance':0x22}[op]; u=[o|r(p[0])<<8,self.ti[p[1]]]
                elif op=='new-array':
                    aa,bb=r(p[0]),r(p[1]); assert max(aa,bb)<16; u=[0x23|aa<<8|bb<<12,self.ti[p[2]]]
                elif op in INVOKE:
                    rr,ref=a.split('},',1); regs=[r(x.strip()) for x in rr.lstrip('{').split(',') if x.strip()]
                    k=meth(ref.strip()); expected=words(k[3])+(op!='invoke-static')
                    assert expected==len(regs),(k,expected,regs)
                    assert len(regs)<=5 and all(x<16 for x in regs)
                    outs=max(outs,len(regs)); invokes+=1
                    zz=(regs+[0]*5)[:5]
                    u=[INVOKE[op]|len(regs)<<12|zz[4]<<8,self.mi[k],zz[0]|zz[1]<<4|zz[2]<<8|zz[3]<<12]
                elif op in INVOKE_RANGE:
                    rr,ref=a.split('},',1); rr=rr.lstrip('{').strip()
                    if '..' in rr:
                        aa,bb=[x.strip() for x in rr.split('..',1)]
                        first,last=r(aa),r(bb); regs=list(range(first,last+1))
                    else:
                        regs=[r(x.strip()) for x in rr.split(',') if x.strip()]
                        first=regs[0] if regs else 0
                        assert regs==list(range(first,first+len(regs)))
                    k=meth(ref.strip()); expected=words(k[3])+(op!='invoke-static/range')
                    assert expected==len(regs),(k,expected,regs)
                    assert len(regs)<=255 and first<=65535
                    outs=max(outs,len(regs)); invokes+=1
                    u=[INVOKE_RANGE[op]|len(regs)<<8,self.mi[k],first]
                elif op in IFields:
                    aa,bb=r(p[0]),r(p[1]); assert max(aa,bb)<16
                    u=[IFields[op]|aa<<8|bb<<12,self.fi[fld(p[2])]]
                elif op in SFields: u=[SFields[op]|r(p[0])<<8,self.fi[fld(p[1])]]
                elif op in IFZ:
                    delta=labels[p[1]]-pc; assert delta and -32768<=delta<=32767; u=[IFZ[op]|r(p[0])<<8,delta&65535]
                elif op in IF2:
                    aa,bb=r(p[0]),r(p[1]); delta=labels[p[2]]-pc; assert max(aa,bb)<16 and delta and -32768<=delta<=32767
                    u=[IF2[op]|aa<<8|bb<<12,delta&65535]
                elif op=='goto/16':
                    delta=labels[a]-pc; assert delta and -32768<=delta<=32767; u=[0x29,delta&65535]
                elif op in OP23: u=[OP23[op]|r(p[0])<<8,r(p[1])|r(p[2])<<8]
                elif op=='add-int/lit8':
                    n=int(p[2],0); assert -128<=n<=127; u=[0xd8|r(p[0])<<8,r(p[1])|(n&255)<<8]
                else: raise ValueError(op)
                assert len(u)==self.size(op)
                units.extend(u)
            except Exception as e: raise RuntimeError(f'{m.key[0]} {m.key[1]} line {ln}: {op} {a}: {e}') from e
        hs=bytearray(uleb(len(m.catches))) if m.catches else bytearray(); tries=[]
        for a,b,c,h in sorted(m.catches,key=lambda x:labels[x[0]]):
            assert labels[a]<labels[b]<=len(units) and labels[h] in boundaries
            hoff=len(hs); hs+=b'\x01'+uleb(self.ti[c])+uleb(labels[h])
            tries.append(P('IHH',labels[a],labels[b]-labels[a],hoff))
        for idx in range(1,len(tries)):
            prev=struct.unpack('<IHH',tries[idx-1]); cur=struct.unpack('<IHH',tries[idx]); assert prev[0]+prev[1]<=cur[0]
        data=P('HHHHII',m.regs,m.ins,outs,len(tries),0,len(units))+P('H'*len(units),*units)
        if tries:
            if len(units)%2: data+=b'\x00\x00'
            data+=b''.join(tries)+hs
        return data, {'method':f'{m.key[0]}->{m.key[1]}({"".join(m.key[3])}){m.key[2]}','registers':m.regs,'units':len(units),'invokes':invokes,'catches':len(tries)}
    def build(self):
        sl=sorted(self.strings,key=lambda s:s.encode('utf-16-be','surrogatepass')); self.si={x:i for i,x in enumerate(sl)}
        tl=sorted(self.ts,key=self.si.get); self.ti={x:i for i,x in enumerate(tl)}
        pl=sorted(self.ps,key=lambda x:(self.ti[x[0]],tuple(self.ti[t] for t in x[1]))); self.pi={x:i for i,x in enumerate(pl)}
        fl=sorted(self.fs,key=lambda x:(self.ti[x[0]],self.si[x[1]],self.ti[x[2]])); self.fi={x:i for i,x in enumerate(fl)}
        ml=sorted(self.ms,key=lambda x:(self.ti[x[0]],self.si[x[1]],self.pi[(x[2],x[3])])); self.mi={x:i for i,x in enumerate(ml)}
        cl=sorted(self.classes,key=lambda c:self.ti[c.name]); assert len({c.name for c in cl})==len(cl)
        offs={}; cur=112
        for tag,n,w in [('strings',len(sl),4),('types',len(tl),4),('protos',len(pl),12),('fields',len(fl),8),('methods',len(ml),8),('classes',len(cl),32)]: offs[tag]=cur; cur+=n*w
        dataoff=cur; b=bytearray(cur); maps=[(0,1,0)]
        for typ,tag,n in [(1,'strings',len(sl)),(2,'types',len(tl)),(3,'protos',len(pl)),(4,'fields',len(fl)),(5,'methods',len(ml)),(6,'classes',len(cl))]:
            if n: maps.append((typ,n,offs[tag]))
        def align(): b.extend(b'\0'*((-len(b))%4))
        sdo=[]; start=len(b)
        for s in sl: sdo.append(len(b)); b.extend(mutf(s))
        maps.append((0x2002,len(sl),start))
        lists={tuple(self.ti[x] for x in args) for _,args in pl if args}
        lists|={tuple(sorted(self.ti[x] for x in c.interfaces)) for c in cl if c.interfaces}
        lists=sorted(lists); lo={}
        if lists:
            align(); start=len(b)
            for li in lists:
                align(); lo[li]=len(b); b.extend(P('I',len(li))+P('H'*len(li),*li))
            maps.append((0x1001,len(lists),start))
        allmethods=[m for c in cl for m in c.methods]; co={}; report=[]
        if allmethods:
            align(); start=len(b)
            for m in allmethods:
                align(); co[m.key]=len(b); code,info=self.code(m); b.extend(code); report.append(info)
            maps.append((0x2001,len(allmethods),start))
        cdo={}; start=len(b)
        for c in cl:
            cdo[c.name]=len(b)
            sf=sorted((x for x in c.fields if x[1]&8),key=lambda x:self.fi[x[0]])
            inf=sorted((x for x in c.fields if not x[1]&8),key=lambda x:self.fi[x[0]])
            direct=sorted((m for m in c.methods if m.flags&(8|2|65536)),key=lambda m:self.mi[m.key])
            virt=sorted((m for m in c.methods if not m.flags&(8|2|65536)),key=lambda m:self.mi[m.key])
            for arr in (sf,inf,direct,virt): b.extend(uleb(len(arr)))
            for arr in (sf,inf):
                prev=0
                for k,f in arr: idx=self.fi[k]; b.extend(uleb(idx-prev)+uleb(f)); prev=idx
            for arr in (direct,virt):
                prev=0
                for m in arr: idx=self.mi[m.key]; b.extend(uleb(idx-prev)+uleb(m.flags)+uleb(co[m.key])); prev=idx
        maps.append((0x2000,len(cl),start)); align(); mapoff=len(b); maps.append((0x1000,1,mapoff))
        maps.sort(key=lambda x:x[2]); b.extend(P('I',len(maps)))
        for t,n,o in maps: b.extend(P('HHII',t,0,n,o))
        for i,x in enumerate(sdo): struct.pack_into('<I',b,offs['strings']+4*i,x)
        for i,t in enumerate(tl): struct.pack_into('<I',b,offs['types']+4*i,self.si[t])
        for i,(ret,args) in enumerate(pl):
            short=''.join('L' if t.startswith(('L','[')) else t for t in (ret,)+args)
            struct.pack_into('<III',b,offs['protos']+12*i,self.si[short],self.ti[ret],lo.get(tuple(self.ti[t] for t in args),0))
        for i,(c,n,t) in enumerate(fl): struct.pack_into('<HHI',b,offs['fields']+8*i,self.ti[c],self.ti[t],self.si[n])
        for i,(c,n,r,a) in enumerate(ml): struct.pack_into('<HHI',b,offs['methods']+8*i,self.ti[c],self.pi[(r,a)],self.si[n])
        for i,c in enumerate(cl):
            struct.pack_into('<IIIIIIII',b,offs['classes']+32*i,self.ti[c.name],c.flags,self.ti[c.super],lo.get(tuple(sorted(self.ti[t] for t in c.interfaces)),0),self.si[self.sources[c.name]],0,cdo[c.name],0)
        hdr=[len(b),112,0x12345678,0,0,mapoff,len(sl),offs['strings'],len(tl),offs['types'],len(pl),offs['protos'],len(fl),offs['fields'],len(ml),offs['methods'],len(cl),offs['classes'],len(b)-dataoff,dataoff]
        b[:8]=b'dex\n035\0'; struct.pack_into('<'+'I'*len(hdr),b,32,*hdr)
        b[12:32]=hashlib.sha1(b[32:]).digest(); struct.pack_into('<I',b,8,zlib.adler32(b[12:])&0xffffffff)
        return bytes(b),report
