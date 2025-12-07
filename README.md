# Piper Phonemizer Plugin

**Piper Phonemizer Flutter Plugin** is a lightweight and efficient text-to-phoneme converter powered by the open-source [Piper TTS engine](https://github.com/rhasspy/piper). This package allows you to convert raw text into phoneme sequences—ideal for speech synthesis, linguistic analysis, pronunciation training, and more.

---

## ✨ Features

- ⚡ **Fast and Lightweight**: Designed for performance and minimal resource usage.
- 🔤 **Text to Phoneme Conversion**: Converts plain text into language-specific phonemes.
- 📦 **FFI-based**: Built in C for speed but easily usable from Dart (Flutter).
- 🌍 **Multi-language Support**: Works with different voices and phoneme schemes.
- 📱 **Mobile Ready**: Optimized for mobile use cases (like Flutter android apps).

---

## 💡 Inspiration

While Piper is a fantastic lightweight TTS engine, there was no simple and reliable way to convert raw text into phonemes that could be directly consumed by Piper for tasks like voice cloning, custom TTS, or linguistic analysis—especially in mobile and Windows desktop environments.

Existing solutions were often:
- Tightly coupled to heavyweight systems,
- Buried inside larger TTS pipelines, or
- Not cross-platform or easy to use with Dart, Flutter, or FFI-based setups.

To bridge this gap, **Piper Phonemizer** was created — a clean, minimal, and efficient way to:
- Generate phonemes with Piper’s models,
- Enable phoneme-level analysis,
- And unlock lower-level control in your TTS workflows.

If you’ve ever wished for a drop-in phonemizer that just works with Piper, especially in a Flutter app or lightweight deployment, this package is for you.

Currently, this package focuses specifically on Android (we have only arm64-v8a and x86_64 support for now. Support for other ABIs will be planned in later versions) and Windows Platform (this repo pertains to MS Windows distribution.), where such a solution was most critical for mobile developers. However, support for other platforms—such as Linux, macOS, and iOS is planned for future versions.


## 🧪 Minimal Reproducible Example

Here’s how to get started in Dart:

add this in dependencies block of pubspec.yaml-

```bash
dependencies:
  flutter:
    sdk: flutter

  #this is where the phonemization magic happens
  piper_phonemizer_windows_plugin:
    git:
      url: https://github.com/dev-6768/piper_phonemizer_windows_plugin.git
      ref: main # or a specific branch, tag, or commit

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
```

how to use it ?
```dart
import 'package:piper_phonemizer_windows_plugin/piper_phonemizer_windows_plugin.dart';

void main() async {
  final phonemizer = PiperPhonemizerWindowsPlugin();

  await phonemizer.initialize();

  // Optional: Set a voice according to your requirement.
  // For more voice options, check: https://github.com/OHF-Voice/piper1-gpl/blob/main/docs/VOICES.md
  phonemizer.setVoice("en"); // Default English voice

  final phonemes = phonemizer.getPhonemesString('Hello world');
  print('Phonemes: $phonemes');
}
```

