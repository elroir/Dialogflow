
import 'package:flutter_tts/flutter_tts.dart';

class TtsProvider {

  final FlutterTts _tts = FlutterTts();


  Future hablar(String text) async {
    await _tts.setVolume(1.0);
    await _tts.setLanguage("es-US");
    await _tts.setPitch(1);
    print(text);
    await _tts.speak(text);
  }

}