import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DayService extends GetxController {
  static DayService get to => Get.find();

  final addDay = true.obs; // ملاحظة: تم تغييرها لتصبح public
  final subDay = false.obs; // ملاحظة: تم تغييرها لتصبح public

  @override
  void onInit() {
    super.onInit();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      addDay.value = prefs.getBool('addDay') ?? true;
      subDay.value = prefs.getBool('subDay') ?? false;
    } catch (e) {
      print('Error loading preferences: $e');
    }
  }

  Future<void> _savePreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('addDay', addDay.value);
      await prefs.setBool('subDay', subDay.value);
    } catch (e) {
      print('Error saving preferences: $e');
    }
  }

  void toggleAddDay() {
    addDay.toggle();
    _savePreferences();
  }

  void toggleSubDay() {
    subDay.toggle();
    _savePreferences();
  }
}