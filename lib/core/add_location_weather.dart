


import 'package:untitled/core/get_loaction.dart';



import 'NetworkData.dart';

const weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getLocationWeather() async {
    /// await for methods that return future
    Location location = Location();
    await location.getCurrentLocation();
    String apiKey="af2d2bdcdbdd2faf0e70022a6cb9ebcf";

    /// Get location data
    ///&units=metric change the temperature metric
    NetworkData networkHelper = NetworkData(
        '$weatherApiUrl?lat=${location.latitude}&lon=${location.longitide}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

}