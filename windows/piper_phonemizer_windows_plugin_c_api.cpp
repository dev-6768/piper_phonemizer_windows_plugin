#include "include/piper_phonemizer_windows_plugin/piper_phonemizer_windows_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "piper_phonemizer_windows_plugin.h"

void PiperPhonemizerWindowsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  piper_phonemizer_windows_plugin::PiperPhonemizerWindowsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
