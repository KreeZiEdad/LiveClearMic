# LiveClearMic

Automatic Bluetooth HFP routing for cleaner headset microphone recordings on Android, without root.

LiveClearMic improves Bluetooth headset microphone recordings on Android by automatically switching to the HFP audio route when microphone use is detected.

## Why LiveClearMic?

Some Android devices do not automatically use the Bluetooth headset microphone for regular microphone recordings.

Instead, apps may continue using the phone's built-in microphone, even when a Bluetooth headset is connected.

LiveClearMic detects microphone use and temporarily activates the Bluetooth HFP audio route, allowing supported apps to use the headset microphone.

The routing is only applied when needed for microphone recordings.

During regular phone calls and supported VoIP calls, LiveClearMic pauses and lets Android handle the Bluetooth call route normally.

## Features

- Automatic Bluetooth HFP routing
- Works without root
- Automatic detection of microphone recordings
- Remembers selected Bluetooth headsets
- Automatically activates when a saved Bluetooth headset connects
- Quickly enable or disable LiveClearMic from the Android notification panel
- Startmute to reduce unwanted noise during HFP startup
- English and Dutch interface
- Automatically stays out of the way during phone and supported VoIP calls
- Runs locally on the device
- No account required

## Current status

LiveClearMic is currently under active development and testing.

Bluetooth audio behaviour can differ between Android devices, manufacturers and headsets, so compatibility may vary.

More testing and device support will follow as development continues.

## Privacy

LiveClearMic is designed to work locally on your Android device.

The app:

- does not upload or store your audio
- does not use analytics
- does not contain advertisements
- does not require an online account

For more information, see [PRIVACY.md](PRIVACY.md).

## License

LiveClearMic is released under the PolyForm Shield License.

See [LICENSE](LICENSE) for the full license text.

## Bugs and technical issues

Found a bug or experiencing a technical problem?

Please open an issue on the [LiveClearMic GitHub Issues page](https://github.com/KreeZiEdad/LiveClearMic/issues).