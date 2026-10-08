# Building LiveClearMic

LiveClearMic 2.0 currently uses a small Python-based build toolchain around the checked-in Smali sources.

## Requirements

- Python 3
- Packages from `requirements.txt`

Install the Python dependency:

```bash
python3 -m pip install -r requirements.txt
```

Build an APK:

```bash
python3 build.py
```

The APK is written to `out/LiveClearMic-v2.0.apk`.

## Signing

The official LiveClearMic private signing key is intentionally **not** part of this repository.

If `.signing/test-signing-key.pem` and `.signing/test-signing-cert.der` are absent, the build tool creates a local test key in `.signing/`. That local key can be used for your own test builds, but it does not produce an APK that can update an official LiveClearMic installation.

Never commit `.signing/` or any private signing key.

## Type check

A static Smali register/control-flow check can be run with:

```bash
python3 tools/check_types.py smali
```

This custom check is useful during development but is not a replacement for Android Runtime verification on a real device.
