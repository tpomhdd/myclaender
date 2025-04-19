import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _addDayKey = 'addDay';
  static const String _subDayKey = 'subDay';

  static Future<void> saveDayValues(bool addDay, bool subDay) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_addDayKey, addDay);
    await prefs.setBool(_subDayKey, subDay);
  }

  static Future<Map<String, bool>> getDayValues() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'addDay': prefs.getBool(_addDayKey) ?? true, // القيمة الافتراضية true
      'subDay': prefs.getBool(_subDayKey) ?? false, // القيمة الافتراضية false
    };
  }
}