import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DayOperations with ChangeNotifier {
  bool _addDay = true;
  bool _subDay = false;

  DayOperations() {
    _loadValues();
  }

  bool get addDay => _addDay;
  bool get subDay => _subDay;

  Future<void> _loadValues() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _addDay = prefs.getBool('addDay') ?? true;
      _subDay = prefs.getBool('subDay') ?? false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading preferences: $e');
      }
    }
  }

  Future<void> setAddDay(bool value) async {
    _addDay = value;
    notifyListeners();
    await _saveValues();
  }

  Future<void> setSubDay(bool value) async {
    _subDay = value;
    notifyListeners();
    await _saveValues();
  }

  Future<void> _saveValues() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('addDay', _addDay);
      await prefs.setBool('subDay', _subDay);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving preferences: $e');
      }
    }
  }
}