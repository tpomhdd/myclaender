

import '../core/get_loaction.dart';
import 'NetworkData.dart';

const weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    /// انتظار الحصول على الموقع
    Location location = Location();
    await location.getCurrentLocation();

    // التأكد من أن الإحداثيات ليست null قبل استخدامها
    if (location.latitude == null || location.longitide == null) {
      throw Exception("لم يتم تحديد الموقع بعد، حاول مرة أخرى.");
    }

    String apiKey = "af2d2bdcdbdd2faf0e70022a6cb9ebcf";

    /// جلب بيانات الطقس
    NetworkData networkHelper = NetworkData(
      '$weatherApiUrl?lat=${location.latitude}&lon=${location.longitide}&appid=$apiKey&units=metric',
    );

    try {
      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      throw Exception("حدث خطأ أثناء جلب بيانات الطقس: $e");
    }
  }

}