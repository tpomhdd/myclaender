import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Speek{
 static bool play=false;


  Future<void> speak(String text) async {
    final FlutterTts flutterTts = FlutterTts();

    if (text.isEmpty) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('lang'); // قراءة القيمة
if(play) {
      await flutterTts.setLanguage(lang.toString()); // تحديد اللغة العربية
      await flutterTts.setPitch(1.0); // درجة الصوت
      await flutterTts.setSpeechRate(0.5); // سرعة التحدث
      await flutterTts.speak(text);
      play=false;
    }
else
  {
    flutterTts.stop();

  }
  }


}