import 'package:flutter/cupertino.dart';

import 'AppPreferences.dart';

class DayOperations with ChangeNotifier {
  bool _addDay = true;
  bool _subDay = false;

  DayOperations() {
    _loadValues();
  }

  bool get addDay => _addDay;
  bool get subDay => _subDay;

  Future<void> _loadValues() async {
    final values = await AppPreferences.getDayValues();
    _addDay = values['addDay']!;
    _subDay = values['subDay']!;
    notifyListeners();
  }

  void setAddDay(bool value) {
    _addDay = value;
    AppPreferences.saveDayValues(_addDay, _subDay);
    notifyListeners();
  }

  void setSubDay(bool value) {
    _subDay = value;
    AppPreferences.saveDayValues(_addDay, _subDay);
    notifyListeners();
  }
}