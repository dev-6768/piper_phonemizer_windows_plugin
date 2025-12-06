import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:piper_phonemizer_windows_plugin/piper_phonemizer_windows_plugin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tester();
  runApp(const MyApp());
}

void tester() async {
  final piperPhonemizer = PiperPhonemizerWindowsPlugin();
  await piperPhonemizer.initialize();
  piperPhonemizer.setVoice("en");
  final result = piperPhonemizer.getPhonemesString("hello world");
  print("Phonemes : $result");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _piperPhonemizerPlugin = PiperPhonemizerWindowsPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _piperPhonemizerPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Plugin example app'),
      //   ),
      //   body: Center(
      //     child: Text('Running on: $_platformVersion\n'),
      //   ),
      // ),

      home: PhonemeWidget(platformVersion: _platformVersion),
    );
  }
}


class PhonemeWidget extends StatefulWidget {
  final String platformVersion;
  const PhonemeWidget({super.key, required this.platformVersion});

  @override
  State<PhonemeWidget> createState() => _PhonemeWidgetState();
}

class _PhonemeWidgetState extends State<PhonemeWidget> {
  final TextEditingController _textController = TextEditingController();
  String _phonemeOutput = '';
  bool _loading = false;
  PiperPhonemizerWindowsPlugin piperPhonemizer = PiperPhonemizerWindowsPlugin();

  @override
  void initState() {
    super.initState();
    _initializePhonemizer();
  }

  Future<void> _initializePhonemizer() async {
    try {
      await piperPhonemizer.initialize();
    } catch (e) {
      debugPrint("Error initializing Phonemizer: $e");
    }
  }



  Future<void> _convertToPhonemes() async {
    setState(() => _loading = true);
    try {
      final inputText = _textController.text;
      if (inputText.isEmpty) return;

      piperPhonemizer.setVoice("en"); //set voice according to the convenience.

      final phonemes = piperPhonemizer.getPhonemesString(inputText);

      setState(() => _phonemeOutput = phonemes); // join if a list
    } 
    
    catch (e) {
      setState(() => _phonemeOutput = 'Error: $e');
    } 
    
    finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Piper compatible phonemizer"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Platform Version : ${widget.platformVersion}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _convertToPhonemes,
              child: _loading ? const CircularProgressIndicator() : const Text('Convert to Phonemes'),
            ),
            const SizedBox(height: 16),
            Text(
              _phonemeOutput.isNotEmpty ? 'Phonemes: $_phonemeOutput' : 'Enter text above to get phonemes.',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
