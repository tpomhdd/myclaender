import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
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
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // تحقق من تمكين خدمة الموقع
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('خدمة الموقع معطلة.');
    }

    // تحقق من الأذونات
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('لم يتم منح إذن الوصول إلى الموقع.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('إذن الوصول إلى الموقع مرفوض بشكل دائم.');
    }

    // الحصول على الموقع الحالي
    return await Geolocator.getCurrentPosition();
  }

  Future<void> fetchPrayerTimes() async {
    try {
      // جلب الموقع الحالي
      Position position = await getCurrentPosition();

      // إعداد الإحداثيات
      final coordinates = Coordinates(position.latitude, position.longitude);

      // إعداد طريقة الحساب
      final params = CalculationMethod.muslim_world_league.getParameters();
      params.madhab = Madhab.hanafi;

      // حساب مواقيت الصلاة
      final prayerTimes = PrayerTimes.today(coordinates, params);

      print("الفجر: ${prayerTimes.fajr}");
      print("الشروق: ${prayerTimes.sunrise}");
      print("الظهر: ${prayerTimes.dhuhr}");
      print("العصر: ${prayerTimes.asr}");
      print("المغرب: ${prayerTimes.maghrib}");
      print("العشاء: ${prayerTimes.isha}");
    } catch (e) {
      print("حدث خطأ: $e");
    }
  }

}
