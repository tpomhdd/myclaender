import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends GetxService {
  static SettingsService get to => Get.find();

  final RxBool addDay = true.obs;
  final RxBool subDay = false.obs;

  Future<void> initSettings() async {
    await loadSettings();
  }

  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      addDay.value = prefs.getBool('addDay') ?? true;
      subDay.value = prefs.getBool('subDay') ?? false;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load settings');
    }
  }

  Future<void> saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('addDay', addDay.value);
      await prefs.setBool('subDay', subDay.value);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save settings');
    }
  }
}