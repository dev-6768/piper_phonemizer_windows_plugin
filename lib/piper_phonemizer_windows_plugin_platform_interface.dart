import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'piper_phonemizer_windows_plugin_method_channel.dart';

abstract class PiperPhonemizerWindowsPluginPlatform extends PlatformInterface {
  /// Constructs a PiperPhonemizerWindowsPluginPlatform.
  PiperPhonemizerWindowsPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static PiperPhonemizerWindowsPluginPlatform _instance = MethodChannelPiperPhonemizerWindowsPlugin();

  /// The default instance of [PiperPhonemizerWindowsPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelPiperPhonemizerWindowsPlugin].
  static PiperPhonemizerWindowsPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PiperPhonemizerWindowsPluginPlatform] when
  /// they register themselves.
  static set instance(PiperPhonemizerWindowsPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
