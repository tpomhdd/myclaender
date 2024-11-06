import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:http/http.dart' as http;

import 'add_location_weather.dart';
class MyClient {
  String? country;
  String? city;

  MyClient({this.country, this.city});

  Future<Map<String, dynamic>> getTimings() async {
    WeatherModel weatherModel = WeatherModel();

    // جلب بيانات الطقس
    var weatherData = await weatherModel.getLocationWeather();

    // إذا كانت القيم فارغة، استخدم البيانات من WeatherModel
    // if ((country == null || country!.isEmpty) && (city == null || city!.isEmpty)) {
    //   country = weatherData['sys']['country'].toString();
    //   city = weatherData['name'];
    // }
    //

    // بناء URI للتوقيتات
    Uri uri = Uri.parse("http://api.aladhan.com/v1/timingsByCity?city=${city}&country=${country}&method=8");
    print(uri.toString());

    // إرسال الطلب
    http.Response response = await http.get(uri);
    String jsonDataString = response.body.toString();

    var data = jsonDecode(jsonDataString);
    print(data);
    return data['data']['timings'];
  }
}
