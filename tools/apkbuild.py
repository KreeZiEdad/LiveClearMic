"""Minimal AXML compiler and APK v2 signer for an offline prototype.
Formats: AOSP ResourceTypes.h and APK Signature Scheme v2 specification.
The independent verifier in verify.py re-parses the produced APK.
"""
from __future__ import annotations
import struct, hashlib, io, zipfile, datetime, xml.etree.ElementTree as ET
from pathlib import Path
from cryptography import x509
from cryptography.x509.oid import NameOID
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import rsa, padding

P=lambda fmt,*x: struct.pack('<'+fmt,*x)
NS='http://schemas.android.com/apk/res/android'
ATTRS={'label':0x01010001,'icon':0x01010002,'name':0x01010003,'permission':0x01010006,'debuggable':0x0101000f,
       'exported':0x01010010,'authorities':0x01010018,'grantUriPermissions':0x0101001b,'value':0x01010024,'minSdkVersion':0x0101020c,
       'versionCode':0x0101021b,'versionName':0x0101021c,'targetSdkVersion':0x01010270,
       'allowBackup':0x01010280,'stopWithTask':0x0101036a,'supportsRtl':0x010103af,
       'foregroundServiceType':0x01010599,'launchMode':0x0101001d}

def axml(path:Path)->bytes:
    tree=ET.parse(path).getroot()
    used={k.split('}',1)[1] for n in tree.iter() for k in n.attrib if k.startswith('{'+NS+'}')}
    assert used<=ATTRS.keys(),used-ATTRS.keys()
    names=sorted(used,key=ATTRS.get)
    strings=list(names); idx={s:i for i,s in enumerate(strings)}
    def si(s):
        if s not in idx: idx[s]=len(strings); strings.append(s)
        return idx[s]
    si('android'); si(NS)
    for n in tree.iter():
        si(n.tag)
        for k,v in n.attrib.items(): si(k.split('}',1)[-1]); si(v)
    data=bytearray(); so=[]
    for s in strings:
        so.append(len(data)); b=s.encode('utf-16-le'); ln=len(b)//2
        assert ln<32768
        data.extend(P('H',ln)+b+b'\0\0')
    data.extend(b'\0'*((-len(data))%4))
    pool=P('HHIIIIII',1,28,28+4*len(strings)+len(data),len(strings),0,0,28+4*len(strings),0)+P('I'*len(so),*so)+data
    rmap=P('HHI',0x180,8,8+4*len(names))+P('I'*len(names),*(ATTRS[s] for s in names))
    def node(kind,ext): return P('HHIII',kind,16,16+len(ext),1,0xffffffff)+ext
    out=bytearray(pool+rmap+node(0x100,P('II',si('android'),si(NS))))
    def walk(n):
        aa=[]
        for key,value in n.attrib.items():
            ns=NS if key.startswith('{'+NS+'}') else None
            name=key.split('}',1)[-1]; typ=3; val=si(value); raw=si(value)
            if ns:
                if name in ('versionCode','minSdkVersion','targetSdkVersion'): typ=0x10; val=int(value); raw=0xffffffff
                elif value in ('true','false'): typ=0x12; val=0xffffffff if value=='true' else 0; raw=0xffffffff
                elif name=='foregroundServiceType':
                    bits={'mediaPlayback':0x2, 'connectedDevice':0x10, 'microphone':0x80, 'shortService':0x800}
                    val=0
                    for flag in value.split('|'): val |= bits[flag]
                    typ=0x11; raw=0xffffffff
                elif name=='launchMode':
                    modes={'standard':0, 'singleTop':1, 'singleTask':2, 'singleInstance':3, 'singleInstancePerTask':4}
                    val=modes[value]; typ=0x10; raw=0xffffffff
                elif name=='icon' and value=='@android:drawable/ic_btn_speak_now':
                    typ=0x01; val=0x010800a4
                elif name=='icon' and value=='@drawable/liveclearmic_icon':
                    typ=0x01; val=0x7f010000
            aa.append((ATTRS[name] if ns else 0, P('IIIHBBI',si(ns) if ns else 0xffffffff,si(name),raw,8,0,typ,val)))
        aa.sort(key=lambda a:a[0])
        ext=P('IIHHHHHH',0xffffffff,si(n.tag),20,20,len(aa),0,0,0)+b''.join(a[1] for a in aa)
        out.extend(node(0x102,ext))
        for child in n: walk(child)
        out.extend(node(0x103,P('II',0xffffffff,si(n.tag))))
    walk(tree)
    out.extend(node(0x101,P('II',si('android'),si(NS))))
    return P('HHI',3,8,len(out)+8)+out

def make_zip(files:dict[str,bytes])->bytes:
    buf=io.BytesIO()
    with zipfile.ZipFile(buf,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9) as z:
        for name,b in files.items():
            info=zipfile.ZipInfo(name,date_time=(2026,9,17,0,0,0))
            if name == 'resources.arsc':
                # Android 11+ refuses APKs whose resources.arsc is compressed or
                # whose file data is not aligned on a 4-byte boundary.
                info.compress_type=zipfile.ZIP_STORED
                base=z.fp.tell()+30+len(name.encode('utf-8'))
                payload_len=(-base-4) % 4
                info.extra=P('HH',0xD935,payload_len)+b'\0'*payload_len
            else:
                info.compress_type=zipfile.ZIP_DEFLATED
            z.writestr(info,b)
    return buf.getvalue()

def lp(b:bytes)->bytes: return P('I',len(b))+b

def content_digest(parts:list[bytes])->bytes:
    chunks=[]
    for b in parts:
        for i in range(0,len(b),1048576):
            c=b[i:i+1048576]
            chunks.append(hashlib.sha256(b'\xa5'+P('I',len(c))+c).digest())
    return hashlib.sha256(b'\x5a'+P('I',len(chunks))+b''.join(chunks)).digest()

def load_key(folder:Path):
    folder.mkdir(parents=True,exist_ok=True)
    keypath=folder/'test-signing-key.pem'; certpath=folder/'test-signing-cert.der'
    if keypath.exists():
        key=serialization.load_pem_private_key(keypath.read_bytes(),password=None)
        cert=x509.load_der_x509_certificate(certpath.read_bytes())
        return key,cert
    key=rsa.generate_private_key(public_exponent=65537,key_size=3072)
    name=x509.Name([x509.NameAttribute(NameOID.COMMON_NAME,'LiveClearMic personal test build')])
    cert=(x509.CertificateBuilder().subject_name(name).issuer_name(name).public_key(key.public_key())
          .serial_number(x509.random_serial_number())
          .not_valid_before(datetime.datetime(2026,1,1,tzinfo=datetime.timezone.utc))
          .not_valid_after(datetime.datetime(2051,1,1,tzinfo=datetime.timezone.utc))
          .sign(key,hashes.SHA256()))
    keypath.write_bytes(key.private_bytes(serialization.Encoding.PEM,serialization.PrivateFormat.PKCS8,serialization.NoEncryption()))
    keypath.chmod(0o600)
    certpath.write_bytes(cert.public_bytes(serialization.Encoding.DER))
    return key,cert

def sign_v2(unsigned:bytes,key,cert)->bytes:
    eo=unsigned.rfind(b'PK\x05\x06'); assert eo>=0 and eo+22==len(unsigned)
    cd=struct.unpack_from('<I',unsigned,eo+16)[0]
    assert unsigned[cd:cd+4]==b'PK\x01\x02'
    digest=content_digest([unsigned[:cd],unsigned[cd:eo],unsigned[eo:]])
    alg=0x0103
    signed_data=lp(lp(P('I',alg)+lp(digest)))+lp(lp(cert.public_bytes(serialization.Encoding.DER)))+lp(b'')
    sig=key.sign(signed_data,padding.PKCS1v15(),hashes.SHA256())
    pub=key.public_key().public_bytes(serialization.Encoding.DER,serialization.PublicFormat.SubjectPublicKeyInfo)
    signer=lp(signed_data)+lp(lp(P('I',alg)+lp(sig)))+lp(pub)
    v2=lp(lp(signer))
    pair=P('Q',4+len(v2))+P('I',0x7109871a)+v2
    sz=len(pair)+24
    block=P('Q',sz)+pair+P('Q',sz)+b'APK Sig Block 42'
    eocd=bytearray(unsigned[eo:]); struct.pack_into('<I',eocd,16,cd+len(block))
    return unsigned[:cd]+block+unsigned[cd:eo]+eocd
