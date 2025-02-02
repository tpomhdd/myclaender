
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Services/add_location_weather.dart';



class Weather extends StatefulWidget {


  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  int temperature=0;
  String condition='';
  int humidity=0;
  String country='';
  String city='';
  WeatherModel weatherModel = WeatherModel();

  void initState() {
    super.initState();
    getLocationData();
  }
  /// variable weatherData contain response from the API
  /// to fetch data check the response to get the way the data structured
  getLocationData() async {
    var weatherData = await weatherModel.getLocationWeather();
    setState(() {
      condition = weatherData['weather'][0]['main'];
      humidity = weatherData['main']['humidity'];
      country = weatherData['sys']['country'];
      city = weatherData['name'];
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Temperature: $temperature°  ',
              style: TextStyle(
                fontFamily: 'Spartan MB',
                fontSize: 40.0,
              ),
            ),
            Text(
              'condition: $condition  ',
              style: TextStyle(
                fontFamily: 'Spartan MB',
                fontSize: 40.0,
              ),
            ),
            Text(
              'humidity: $humidity  ',
              style: TextStyle(
                fontFamily: 'Spartan MB',
                fontSize: 40.0,
              ),
            ),
            Text(
              'Country: $country  ',
              style: TextStyle(
                fontFamily: 'Spartan MB',
                fontSize: 40.0,
              ),
            ),
            Text(
              'City: $city  ',
              style: TextStyle(
                fontFamily: 'Spartan MB',
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
