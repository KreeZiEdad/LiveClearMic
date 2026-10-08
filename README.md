# LiveClearMic

LiveClearMic improves Bluetooth headset microphone recordings on Android by automatically switching to the HFP audio route when microphone use is detected.

**No root required.**

## Why LiveClearMic?

Some Android devices do not automatically use the optimal Bluetooth audio route for microphone recordings. This can result in poor microphone quality or ineffective voice-focused noise reduction.

LiveClearMic automatically activates the Bluetooth HFP route when a supported recording starts.

During regular phone calls and supported VoIP calls, LiveClearMic pauses its own routing logic and leaves call audio handling to Android, since the system already manages the Bluetooth call route itself.

## Current status

LiveClearMic is currently available as a public beta.

Tested primarily on:

- Samsung Galaxy S24
- Android 16
- OnePlus Buds 4

Support for other devices and Bluetooth headsets may vary.

## Installation

1. Open the latest release on the GitHub **Releases** page.
2. Download the latest LiveClearMic `.apk` file.
3. Open the downloaded APK on your Android device.
4. If Android asks for permission to install apps from your browser or file manager, allow it temporarily.
5. Install LiveClearMic.
6. Open the app and select your Bluetooth headset.

Android may show a warning because the app is installed outside the Google Play Store. This is expected for the GitHub release.

Future updates can be installed by downloading the newer APK and installing it over the existing version. Your LiveClearMic settings should remain preserved.

## Features

- Automatic Bluetooth HFP routing for recordings
- No root required
- Pauses during phone and supported VoIP calls
- Optional Startmute to hide Bluetooth route startup noise
- English and Dutch interface
- Automatic language selection on first launch
- Local-only settings
- No microphone audio recording or storage
- No analytics
- No advertisements

## Startmute

When a Bluetooth HFP connection is established, a short burst of noise may be audible at the beginning of a recording on some devices or headsets.

Startmute temporarily mutes the beginning of the recording while the Bluetooth connection is being established.

Startmute is enabled by default at **500 ms**.

To adjust it:

1. Open the **⋮** menu.
2. Select **Startmute**.
3. Enable or disable Startmute, or adjust the duration between **250 and 750 ms**.

The duration can be adjusted in **25 ms steps**.

The default setting of **500 ms** is recommended for most devices. If your recordings start cleanly, there is usually no need to change it.

## Phone and VoIP calls

LiveClearMic is designed for microphone recordings.

During regular phone calls and supported VoIP calls, LiveClearMic automatically pauses its own HFP routing logic.

Android is allowed to manage the Bluetooth call route normally, and LiveClearMic becomes active again when the call has ended.

## Diagnosis

If you experience a problem, LiveClearMic can copy a technical diagnosis that may help with troubleshooting.

Tap **Made by KreeZiE** five times to copy the diagnosis to the clipboard.

You can then paste the diagnosis into a GitHub Issue together with your phone model, Android version and Bluetooth headset.

The diagnosis contains technical status and routing information. It does not contain recorded microphone audio.

## Privacy

LiveClearMic does not collect, store or transmit personal data.

The app does not record or store microphone audio.

Settings such as the selected Bluetooth headset and Startmute configuration are stored locally on the device.

LiveClearMic does not use analytics, tracking or advertising services.

See [PRIVACY.md](PRIVACY.md) for more information.

## Support LiveClearMic

LiveClearMic is free to use.

If you find LiveClearMic useful and would like to support its development, you can buy me a coffee:

☕ [Donate via DonoLink](https://donolink.nl/u/kreezie)

Donations are completely optional.

## License

Source code is available under the **PolyForm Shield License 1.0.0**.

The LiveClearMic name, KreeZiE name and associated branding are not licensed for use in derivative products.

See [LICENSE](LICENSE) for the full license terms.

## Contact

Created by **KreeZiE**.

For bugs and technical issues, please use GitHub Issues.
