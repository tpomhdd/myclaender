
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tpo_weather/Screen/Location.dart';


import '../Services/add_location_weather.dart';

class Weather extends StatefulWidget {


  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  void initState() {
    super.initState();
    getLocationData();
  }

  getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Locations(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.red,
          size: 100.0,
        ),
      ),
    );
  }
}