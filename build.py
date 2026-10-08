#!/usr/bin/env python3
from pathlib import Path
import sys, json, hashlib, argparse
BASE=Path(__file__).resolve().parent
sys.path.insert(0,str(BASE/'tools'))
from dexbuild import Assembler
from apkbuild import axml, make_zip, load_key, sign_v2
from resbuild import single_drawable_table

def main():
    p=argparse.ArgumentParser()
    p.add_argument('--output',type=Path,default=BASE/'out'/'LiveClearMic-v2.0.apk')
    p.add_argument('--keys',type=Path,default=BASE/'.signing')
    a=p.parse_args()
    ass=Assembler()
    for f in sorted((BASE/'smali').glob('*.smali')): ass.load(f)
    dex,report=ass.build()
    files={'AndroidManifest.xml':axml(BASE/'AndroidManifest.xml'),'classes.dex':dex}
    files['resources.arsc']=single_drawable_table('app.liveclearmic','liveclearmic_icon','res/drawable/liveclearmic_icon.png')
    files['res/drawable/liveclearmic_icon.png']=(BASE/'res/drawable/liveclearmic_icon.png').read_bytes()
    files['assets/liveclearmic_logo.png']=(BASE/'assets/liveclearmic_logo.png').read_bytes()
    files['assets/liveclearmic_status.png']=(BASE/'assets/liveclearmic_status.png').read_bytes()
    files['assets/LEESMIJ.txt']=(
        'LiveClearMic 2.0 - public beta build 80.\n'
        'First-run language follows Android: Dutch locale -> NL, every other locale -> EN. A manual NL/EN choice is stored and respected.\n'
        'Startmute uses System mute only. Slider range 250-750 ms in 25 ms steps; default/reset 500 ms.\n'
        'During phone and supported VoIP calls LiveClearMic pauses its routing logic and leaves call routing to Android.\n'
        'Five taps on Gemaakt door / Made by KreeZiE copy the compact support diagnosis; the Toast confirms Diagnose gekopieerd / Diagnosis copied.\n'
        'The version-number 5-tap easter egg remains and shows 80 builds later...\n'
        'LiveClearMic does not capture or store microphone audio and does not request RECORD_AUDIO.\n'
    ).encode()
    key,cert=load_key(a.keys)
    apk=sign_v2(make_zip(files),key,cert)
    a.output.parent.mkdir(parents=True,exist_ok=True); a.output.write_bytes(apk)
    (a.output.parent/(a.output.name+'.sha256')).write_text(hashlib.sha256(apk).hexdigest()+'  '+a.output.name+'\n')
    (BASE/'build-methods.json').write_text(json.dumps(report,indent=2))
    print(str(a.output)); print(f'{len(apk)} bytes; {len(report)} methods; APK signature scheme v2')
if __name__=='__main__': main()
