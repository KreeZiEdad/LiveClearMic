from __future__ import annotations
import struct

P=lambda fmt,*x: struct.pack('<'+fmt,*x)

def _string_pool(strings):
    data=bytearray(); offsets=[]
    for s in strings:
        offsets.append(len(data))
        b=s.encode('utf-16-le'); ln=len(b)//2
        if ln>=0x8000: raise ValueError('string too long')
        data += P('H',ln)+b+b'\0\0'
    data += b'\0' * ((-len(data))%4)
    header_size=28
    strings_start=header_size+4*len(strings)
    size=strings_start+len(data)
    return (P('HHI',0x0001,header_size,size)
            +P('IIIII',len(strings),0,0,strings_start,0)
            +(P('I'*len(offsets),*offsets) if offsets else b'')
            +data)

def single_drawable_table(package_name:str, key_name:str, file_path:str, package_id:int=0x7f, type_id:int=1):
    """Build a tiny resources.arsc containing one drawable file resource.
    Resource ID is package_id:type_id:0 -> normally 0x7f010000.
    """
    global_pool=_string_pool([file_path])
    type_pool=_string_pool(['drawable'])
    key_pool=_string_pool([key_name])

    # One type spec entry, no configuration-difference flags.
    type_spec=P('HHI',0x0202,16,20)+P('BBHI',type_id,0,0,1)+P('I',0)

    # Default configuration. Modern ResTable_config is 64 bytes; size field + zeroes.
    config=P('I',64)+b'\0'*60
    type_header_size=8+1+1+2+4+4+len(config)  # 84 bytes
    entries_start=type_header_size+4  # one uint32 entry offset
    entry=P('HHI',8,0,0)  # ResTable_entry: size, flags, key-string index
    value=P('HBBI',8,0,0x03,0)  # Res_value TYPE_STRING -> global pool index 0
    type_size=entries_start+len(entry)+len(value)
    type_chunk=(P('HHI',0x0201,type_header_size,type_size)
                +P('BBHII',type_id,0,0,1,entries_start)
                +config
                +P('I',0)
                +entry+value)
    assert len(type_chunk)==type_size

    pkg_header_size=288
    type_strings_off=pkg_header_size
    key_strings_off=pkg_header_size+len(type_pool)
    body=type_pool+key_pool+type_spec+type_chunk
    pkg_size=pkg_header_size+len(body)
    name_utf16=package_name.encode('utf-16-le')
    if len(name_utf16)>254: raise ValueError('package name too long')
    name_field=name_utf16+b'\0\0'+b'\0'*(256-len(name_utf16)-2)
    pkg=(P('HHI',0x0200,pkg_header_size,pkg_size)
         +P('I',package_id)
         +name_field
         +P('IIIII',type_strings_off,0,key_strings_off,0,0)
         +body)
    assert len(pkg)==pkg_size

    total_size=12+len(global_pool)+len(pkg)
    table=P('HHII',0x0002,12,total_size,1)+global_pool+pkg
    assert len(table)==total_size
    return table
