import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TTSSettings {
 static  bool play=false;
 static
 Future<void> speak(String text) async {
   final FlutterTts flutterTts = FlutterTts();

   if (text.isEmpty) return;
   SharedPreferences prefs = await SharedPreferences.getInstance();
play=!play;
   String? lang = prefs.getString('lang'); // قراءة القيمة
   if(play) {
     await flutterTts.setLanguage(lang.toString()); // تحديد اللغة العربية
     await flutterTts.setPitch(1.0); // درجة الصوت
     await flutterTts.setSpeechRate(0.5); // سرعة التحدث

     await flutterTts.speak(text);
   }

   else{
     flutterTts.stop();
   }
 }
  static const platform = MethodChannel('tts_channel');
  static Future<void> configureTTS() async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setEngine("com.google.android.tts");
    await flutterTts.setLanguage("ar");
  }
  static Future<void> openTTSSettings() async {
    try {
      await platform.invokeMethod('openTTS');
    } on PlatformException catch (e) {
      print("خطأ: ${e.message}");
    }
  }
}
