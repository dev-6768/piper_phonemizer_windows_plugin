#ifndef FLUTTER_PLUGIN_PIPER_PHONEMIZER_WINDOWS_PLUGIN_H_
#define FLUTTER_PLUGIN_PIPER_PHONEMIZER_WINDOWS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace piper_phonemizer_windows_plugin {

class PiperPhonemizerWindowsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  PiperPhonemizerWindowsPlugin();

  virtual ~PiperPhonemizerWindowsPlugin();

  // Disallow copy and assign.
  PiperPhonemizerWindowsPlugin(const PiperPhonemizerWindowsPlugin&) = delete;
  PiperPhonemizerWindowsPlugin& operator=(const PiperPhonemizerWindowsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace piper_phonemizer_windows_plugin

#endif  // FLUTTER_PLUGIN_PIPER_PHONEMIZER_WINDOWS_PLUGIN_H_
