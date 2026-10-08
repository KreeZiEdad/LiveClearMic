# LiveClearMic

Automatic Bluetooth HFP routing for cleaner headset microphone recordings on Android, without root.

LiveClearMic improves Bluetooth headset microphone recordings on Android by automatically switching to the HFP audio route when microphone use is detected.

## Why LiveClearMic?

Some Android devices do not automatically use the Bluetooth headset microphone for regular microphone recordings.

Instead, apps may continue using the phone's built-in microphone, even when a Bluetooth headset is connected.

LiveClearMic detects microphone use and temporarily activates the Bluetooth HFP audio route, allowing supported apps to use the headset microphone.

During regular phone calls and supported VoIP calls, LiveClearMic pauses and lets Android handle the Bluetooth audio route normally.

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

## How it works

When a saved Bluetooth headset connects, LiveClearMic automatically becomes active in the background.

When microphone use is detected, LiveClearMic temporarily switches Android to the Bluetooth HFP communication route so supported apps can use the headset microphone.

When the recording ends, the temporary audio route is released again.

Startmute can briefly suppress unwanted noise that may occur while the Bluetooth HFP route is starting.

During regular phone calls and supported VoIP calls, LiveClearMic pauses and lets Android handle the Bluetooth audio route normally.

## Usage

1. Install LiveClearMic on your Android device.
2. Grant the requested permissions.
3. Connect your Bluetooth headset.
4. Select the headset you want LiveClearMic to remember.
5. Enable LiveClearMic.
6. Use your microphone normally in a supported app.

After setup, LiveClearMic automatically becomes active again when a saved Bluetooth headset reconnects.

You can quickly enable or disable LiveClearMic from the Android notification panel without opening the app.

## Startmute

Some Bluetooth headsets produce a short burst of noise while switching to the HFP audio route.

Startmute temporarily suppresses the beginning of the recording while the Bluetooth route is being established.

The Startmute duration can be adjusted in LiveClearMic.

## Requirements

- Android device
- Bluetooth headset with microphone
- Bluetooth headset paired with the Android device
- Required Android permissions granted to LiveClearMic

Bluetooth audio behaviour differs between Android devices, manufacturers and headsets, so compatibility may vary.

## Current status

LiveClearMic is currently under active development and testing.

The app is being tested with different recording scenarios, Bluetooth routing behaviour and headsets.

Additional compatibility improvements may be added as testing continues.

## Privacy

LiveClearMic is designed to work locally on your Android device.

The app:

- does not upload or store your audio
- does not use analytics
- does not contain advertisements
- does not require an online account

For more information, see [PRIVACY.md](PRIVACY.md).

## Support

Like LiveClearMic?

If you find it useful, you can support development with a coffee ☕

[☕ Donate](https://donolink.nl/u/kreezie)

## License

LiveClearMic is released under the PolyForm Shield License.

See [LICENSE](LICENSE) for the full license text.

## Bugs and technical issues

Found a bug or experiencing a technical problem?

Please open an issue on the [LiveClearMic GitHub Issues page](https://github.com/KreeZiEdad/LiveClearMic/issues).