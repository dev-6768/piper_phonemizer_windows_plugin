import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'piper_phonemizer_windows_plugin_platform_interface.dart';

/// An implementation of [PiperPhonemizerWindowsPluginPlatform] that uses method channels.
class MethodChannelPiperPhonemizerWindowsPlugin extends PiperPhonemizerWindowsPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('piper_phonemizer_windows_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
