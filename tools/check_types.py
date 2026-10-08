#!/usr/bin/env python3
"""Additional, deliberately limited register-type/control-flow checks on Smali.
Not the ART verifier; does not resolve framework binaries or enforce Android access rules.
"""
from pathlib import Path
import sys,json
from collections import deque
sys.path.insert(0,str(Path(__file__).resolve().parent))
from dexbuild import Assembler, meth, fld
BASE=Path(__file__).resolve().parents[1]
ass=Assembler()
for f in sorted((BASE/'smali').glob('*.smali')):ass.load(f)
parents={
'Landroid/app/Activity;':['Landroid/view/ContextThemeWrapper;'],
'Landroid/view/ContextThemeWrapper;':['Landroid/content/ContextWrapper;'],
'Landroid/app/Service;':['Landroid/content/ContextWrapper;'],
'Landroid/service/quicksettings/TileService;':['Landroid/app/Service;'],
'Landroid/companion/CompanionDeviceService;':['Landroid/app/Service;'],
'Landroid/companion/CompanionDeviceManager$Callback;':['Ljava/lang/Object;'],
'Landroid/companion/BluetoothDeviceFilter;':['Landroid/companion/DeviceFilter;'],
'Landroid/content/ContextWrapper;':['Landroid/content/Context;'],
'Landroid/widget/LinearLayout;':['Landroid/view/ViewGroup;'],
'Landroid/widget/ScrollView;':['Landroid/widget/FrameLayout;'],
'Landroid/widget/FrameLayout;':['Landroid/view/ViewGroup;'],
'Landroid/view/ViewGroup;':['Landroid/view/View;'],
'Landroid/widget/Switch;':['Landroid/widget/CompoundButton;'],
'Landroid/widget/CheckBox;':['Landroid/widget/CompoundButton;'],
'Landroid/widget/CompoundButton;':['Landroid/widget/Button;'],
'Landroid/widget/Button;':['Landroid/widget/TextView;'],
'Landroid/widget/TextView;':['Landroid/view/View;'],
'Landroid/widget/ImageView;':['Landroid/view/View;'],
'Landroid/widget/LinearLayout$LayoutParams;':['Landroid/view/ViewGroup$MarginLayoutParams;'],
'Landroid/view/ViewGroup$MarginLayoutParams;':['Landroid/view/ViewGroup$LayoutParams;'],
'Landroid/media/audiofx/NoiseSuppressor;':['Landroid/media/audiofx/AudioEffect;'],
'Ljava/lang/String;':['Ljava/lang/CharSequence;'],
'Ljava/lang/IllegalStateException;':['Ljava/lang/RuntimeException;'],
'Ljava/lang/RuntimeException;':['Ljava/lang/Exception;'],
'Ljava/lang/Exception;':['Ljava/lang/Throwable;']}
for c in ass.classes:parents[c.name]=[c.super,*c.interfaces]

def ref(t):return t.startswith(('L','['))
def supers(t):
    out={t}
    for p in parents.get(t,[]):out|=supers(p)
    if ref(t):out.add('Ljava/lang/Object;')
    return out

def compatible(t,want):
    if t==want:return True
    if t=='zero':return ref(want) or want in 'ZBSCIF'
    if t.startswith('const:'):return want in 'ZBSCIF'
    if want=='I' and t in ('Z','B','S','C'):return True
    return ref(t) and ref(want) and want in supers(t)

def join(a,b):
    if a==b:return a
    def booleanish(t):
        return t in ('zero','Z') or (t.startswith('const:') and int(t[6:],0) in (0,1))
    if booleanish(a) and booleanish(b):return 'Z'
    if '?' in (a,b):return '?'
    if a=='zero' and ref(b):return b
    if b=='zero' and ref(a):return a
    if ref(a) and ref(b):
        for p in (a,b,*parents.get(a,[]),*parents.get(b,[]),'Ljava/lang/Object;'):
            if p in supers(a) and p in supers(b):return p
    if (a.startswith('const:') or a=='zero') and (b.startswith('const:') or b=='zero'):return 'I'
    if compatible(a,b):return b
    if compatible(b,a):return a
    return '!'

def check(m):
    labels={a:i for i,(op,a,_) in enumerate(m.lines) if op=='label'}
    init=['?']*m.regs+['?'];i=m.local
    for t in ((m.key[0],) if not m.flags&8 else ())+m.key[3]:
        init[i]=t
        if t in ('J','D'):init[i+1]='hi-'+t;i+=1
        i+=1
    states={0:tuple(init)};todo=deque([0]);seen=0
    def push(i,s):
        if i>=len(m.lines):raise AssertionError(('fallthrough',m.key))
        old=states.get(i)
        new=tuple(s) if old is None else tuple(join(a,b) for a,b in zip(old,s))
        if old!=new:states[i]=new;todo.append(i)
    while todo:
        at=todo.popleft();s=list(states[at]);op,a,line=m.lines[at];p=[x.strip() for x in a.split(',')];seen+=1
        def get(r):return s[m.reg(r)]
        def need(r,t):assert compatible(get(r),t),(m.key,line,op,a,r,get(r),'expected',t)
        def put(r,t):
            j=m.reg(r);s[j]=t
            if t in ('J','D'):assert j+1<m.regs;s[j+1]='hi-'+t
        nexts=[at+1]
        if op=='label':pass
        elif op=='const-string':put(p[0],'Ljava/lang/String;')
        elif op=='const-class':put(p[0],'Ljava/lang/Class;')
        elif op.startswith('const-wide'):put(p[0],'J')
        elif op.startswith('const'):put(p[0],'zero' if int(p[1],0)==0 else 'const:'+p[1])
        elif op.startswith('move-result'):
            t=s[-1];assert t not in ('?','!','V'),(m.key,line,'invalid result',t);put(p[0],t)
        elif op=='move-exception':put(p[0],'Ljava/lang/Throwable;')
        elif op in ('move','move-object','move-wide'):put(p[0],get(p[1]))
        elif op=='new-instance':put(p[0],p[1])
        elif op=='new-array':need(p[1],'I');put(p[0],p[2])
        elif op=='check-cast':assert ref(get(p[0])) or get(p[0])=='zero';put(p[0],p[1])
        elif op=='array-length':assert get(p[1]).startswith('[');put(p[0],'I')
        elif op=='aget-object':
            arr=get(p[1]);assert arr.startswith('[');need(p[2],'I');put(p[0],arr[1:])
        elif op=='aput-object':
            arr=get(p[1]);assert arr.startswith('[');need(p[0],arr[1:]);need(p[2],'I')
        elif op.startswith(('iget','iput','sget','sput')):
            c,n,t=fld(p[-1])
            if op.startswith(('iget','iput')):need(p[1],c)
            if op.startswith(('iget','sget')):put(p[0],t)
            else:need(p[0],t)
        elif op=='int-to-float':need(p[1],'I');put(p[0],'F')
        elif op=='int-to-long':need(p[1],'I');put(p[0],'J')
        elif op=='float-to-int':need(p[1],'F');put(p[0],'I')
        elif op in ('add-long','sub-long','add-int','sub-int','mul-float'):
            t='J' if 'long' in op else ('F' if 'float' in op else 'I')
            need(p[1],t);need(p[2],t);put(p[0],t)
        elif op in ('add-int/2addr','sub-int/2addr'):
            need(p[0],'I');need(p[1],'I');put(p[0],'I')
        elif op=='add-int/lit8':need(p[1],'I');put(p[0],'I')
        elif op=='cmp-long':need(p[1],'J');need(p[2],'J');put(p[0],'I')
        elif op.startswith('invoke-'):
            rs,r=a.split('},',1); raw=rs.lstrip('{').strip()
            if '..' in raw:
                aa,bb=[x.strip() for x in raw.split('..',1)]
                ia,ib=m.reg(aa),m.reg(bb); rr=[]
                for j in range(ia,ib+1):
                    rr.append(('v'+str(j)) if j<m.local else ('p'+str(j-m.local)))
            else:
                rr=[x.strip() for x in raw.split(',') if x.strip()]
            c,n,ret,args=meth(r.strip());ts=((c,) if op not in ('invoke-static','invoke-static/range') else ())+args;i=0
            for t in ts:
                need(rr[i],t)
                if t in ('J','D'):
                    assert m.reg(rr[i+1])==m.reg(rr[i])+1
                    assert get(rr[i+1])=='hi-'+t,(m.key,line,rr[i+1],get(rr[i+1]))
                    i+=1
                i+=1
            s[-1]=ret
        elif op.startswith('if-'):
            for r in p[:-1]:assert get(r) not in ('?','!'),(m.key,line,r,get(r))
            nexts.append(labels[p[-1]])
        elif op.startswith('goto'):nexts=[labels[a]]
        elif op=='throw':need(p[0],'Ljava/lang/Throwable;');nexts=[]
        elif op=='return-void':assert m.key[2]=='V';nexts=[]
        elif op in ('return','return-object','return-wide'):need(p[0],m.key[2]);nexts=[]
        else:raise AssertionError(('unsupported check',op))
        if op.startswith(('invoke','new-','iget','iput','aget','aput')) or op in ('check-cast','array-length','throw'):
            for lo,hi,t,h in m.catches:
                if labels[lo]<=at<labels[hi]:
                    caught=list(states[at]);caught[-1]='?';push(labels[h],caught)
        for n in nexts:push(n,s)
    return len(states),seen

if __name__=='__main__':
    total=0
    for c in ass.classes:
        for m in c.methods:
            n,_=check(m);total+=n
    print(f'PASS: {sum(len(c.methods) for c in ass.classes)} methods, {total} reachable Smali instructions/labels checked.')
    print('Checks: register types, receiver/argument compatibility, wide argument pairs, branches, exception joins.')
    print('LIMITATION: custom static checker, not ART verification; framework method existence is not resolved here.')
