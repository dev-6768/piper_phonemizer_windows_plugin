
import 'piper_phonemizer_windows_plugin_platform_interface.dart';
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:piper_phonemizer_windows_plugin/utils/unzip_espeak_data.dart';

class PiperPhonemizerWindowsPlugin {
  /// Singleton instance
  static PiperPhonemizerWindowsPlugin? _instance;

  factory PiperPhonemizerWindowsPlugin() {
    return _instance ??= PiperPhonemizerWindowsPlugin._internal();
  }

  late final DynamicLibrary _lib;

  PiperPhonemizerWindowsPlugin._internal() {
    _lib = _openLibrary();
  }

  /// Opens the correct `.so` file for Android
  DynamicLibrary _openLibrary() {
    if (Platform.isAndroid) {
      return DynamicLibrary.open("espeakbridge.so");
    }

    else if(Platform.isWindows) {
      return DynamicLibrary.open("espeakbridge_win.dll");
    }
    
    throw UnsupportedError("ESpeakBridge is only supported on Android.");
  }

  // FFI Struct matching the native PhonemeResult  

  // Native functions
  late final int Function(Pointer<Utf8> dataDir) _initialize = 
      _lib.lookupFunction<Int32 Function(Pointer<Utf8>), int Function(Pointer<Utf8>)>("initialize");

  late final int Function(Pointer<Utf8> voice) _setVoice =
      _lib.lookupFunction<Int32 Function(Pointer<Utf8>), int Function(Pointer<Utf8>)>("set_voice");

  late final Pointer<_PhonemeResult> Function(Pointer<Utf8> text, Pointer<Int32> count) _getPhonemes =
      _lib.lookupFunction<Pointer<_PhonemeResult> Function(Pointer<Utf8>, Pointer<Int32>),
                         Pointer<_PhonemeResult> Function(Pointer<Utf8>, Pointer<Int32>)>("get_phonemes");

  late final void Function(Pointer<_PhonemeResult>, int) _freePhonemes =
      _lib.lookupFunction<Void Function(Pointer<_PhonemeResult>, Int32),
                         void Function(Pointer<_PhonemeResult>, int)>("free_phonemes");

  /// Initialize espeakbridge with optional data directory
  Future<int> initialize() async {
    try {
      final dataDir = await unzipEspeakData();
      print(dataDir);
      final dirPtr = dataDir.toNativeUtf8();
      final result = _initialize(dirPtr);
      malloc.free(dirPtr);
      return result;
    }

    catch(err) {
      throw Exception("PiperPhonemizerPlugin : Some error occured while initializing phonemizer : $err");
    }
    
  }

  /// Set voice by name
  int setVoice(String voice) {
    try {
      final ptr = voice.toNativeUtf8();
      final result = _setVoice(ptr);
      malloc.free(ptr);
      return result;
    }

    catch(err) {
      throw Exception("PiperPhonemizerPlugin : Some error occured while setting voice : $err");
    } 
  }

  /// Get phonemes string from text
  String getPhonemesString(String text) {
    try {
      final textPtr = text.toNativeUtf8();
      final countPtr = malloc<Int32>();
      countPtr.value = 0;

      final results = _getPhonemes(textPtr, countPtr);

      final count = countPtr.value;
      malloc.free(countPtr);
      malloc.free(textPtr);

      if (results.address == 0 || count == 0) return "";

      final buffer = StringBuffer();
      for (var i = 0; i < count; i++) {
        final phonemePtr = results[i].phonemes;
        final termPtr = results[i].terminator;

        if (phonemePtr.address != 0) {
          buffer.write(phonemePtr.toDartString());
        }
        if (termPtr.address != 0) {
          buffer.write(termPtr.toDartString());
        }
      }

      _freePhonemes(results, count);

      return buffer.toString();
    }


    catch(err) {
      throw Exception("PiperPhonemizerPlugin : Some error occured while generating phoneme string : $err");
    }
    
  }

  Future<String?> getPlatformVersion() {
    return PiperPhonemizerWindowsPluginPlatform.instance.getPlatformVersion();
  }
}


final class _PhonemeResult extends Struct {
  external Pointer<Utf8> phonemes;
  external Pointer<Utf8> terminator;
  @Int32()
  external int isSentence;
}

