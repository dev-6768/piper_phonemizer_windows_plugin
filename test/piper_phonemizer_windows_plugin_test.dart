import 'package:flutter_test/flutter_test.dart';
import 'package:piper_phonemizer_windows_plugin/piper_phonemizer_windows_plugin.dart';
import 'package:piper_phonemizer_windows_plugin/piper_phonemizer_windows_plugin_platform_interface.dart';
import 'package:piper_phonemizer_windows_plugin/piper_phonemizer_windows_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPiperPhonemizerWindowsPluginPlatform
    with MockPlatformInterfaceMixin
    implements PiperPhonemizerWindowsPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PiperPhonemizerWindowsPluginPlatform initialPlatform = PiperPhonemizerWindowsPluginPlatform.instance;

  test('$MethodChannelPiperPhonemizerWindowsPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPiperPhonemizerWindowsPlugin>());
  });

  test('getPlatformVersion', () async {
    PiperPhonemizerWindowsPlugin piperPhonemizerWindowsPlugin = PiperPhonemizerWindowsPlugin();
    MockPiperPhonemizerWindowsPluginPlatform fakePlatform = MockPiperPhonemizerWindowsPluginPlatform();
    PiperPhonemizerWindowsPluginPlatform.instance = fakePlatform;

    expect(await piperPhonemizerWindowsPlugin.getPlatformVersion(), '42');
  });
}
