import 'package:untitled/Theme/color.dart' as mycolor;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:untitled/core/app_color.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class PrayerTimesScreen4 extends StatefulWidget {
  @override
  _PrayerTimesScreen4State createState() => _PrayerTimesScreen4State();
}

class _PrayerTimesScreen4State extends State<PrayerTimesScreen4> {
  Map<String, dynamic>? prayerTimes;
  bool isLoading = true;
  String? nextPrayerName;
  Duration remainingTime = Duration.zero;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    getLocationAndFetchPrayerTimes();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  Future<void> getLocationAndFetchPrayerTimes() async {
    try {
      // طلب إذن الوصول إلى الموقع
      var status = await Permission.location.request();
      if (status.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        fetchPrayerTimes(position.latitude, position.longitude);
      } else {
        print("إذن الموقع مرفوض!");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("خطأ في تحديد الموقع: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchPrayerTimes(double latitude, double longitude) async {
    final String apiUrl =
        "http://api.aladhan.com/v1/timings?latitude=$latitude&longitude=$longitude&method=2";
    print(apiUrl);
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          prayerTimes = data['data']['timings'];
          updateTimeToNextPrayer();
          isLoading = false;
        });
      } else {
        throw Exception("فشل في جلب البيانات");
      }
    } catch (e) {
      print("خطأ: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateTimeToNextPrayer() {
    final now = DateTime.now();
    final dateFormat = DateFormat("HH:mm");

    for (var entry in prayerTimes!.entries) {
      final prayerTime = dateFormat.parse(entry.value);
      final prayerDateTime = DateTime(now.year, now.month, now.day, prayerTime.hour, prayerTime.minute);

      if (prayerDateTime.isAfter(now)) {
        setState(() {
          nextPrayerName = entry.key;
          remainingTime = prayerDateTime.difference(now);
        });
        startCountdown();
        return;
      }
    }
    setState(() {
      nextPrayerName = null;
      remainingTime = Duration.zero;
    });
  }

  void startCountdown() {
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime -= Duration(seconds: 1);
        });
      } else {
        timer.cancel();
        getLocationAndFetchPrayerTimes();
      }
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : prayerTimes != null
          ? Column(
        children: [
          // عرض أوقات الصلاة بشكل أفقي
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                prayerTile("الفجر", prayerTimes!['Fajr']),
                prayerTile("الظهر", prayerTimes!['Dhuhr']),
                prayerTile("العصر", prayerTimes!['Asr']),
                prayerTile("المغرب", prayerTimes!['Maghrib']),
                prayerTile("العشاء", prayerTimes!['Isha']),
              ],
            ),
          ),
          // عرض العداد التنازلي للصلاة المقبلة
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  "الوقت المتبقي للصلاة المقبلة",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  nextPrayerName != null
                      ? "$nextPrayerName: ${formatDuration(remainingTime)}"
                      : "لا توجد صلاة قادمة",
                  style: TextStyle(fontSize: 22, color: Colors.teal),
                ),
              ],
            ),
          ),
        ],
      )
          : Center(child: Text("فشل في تحميل البيانات")),
    );
  }

  Widget prayerTile(String prayerName, String time) {
    // تحقق مما إذا كانت هذه الصلاة هي الصلاة المقبلة
    bool isNextPrayer = nextPrayerName == prayerName;

    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isNextPrayer ? Colors.white : Color(0xffe2e2fc), // لون مختلف للصلاة المقبلة
        border: Border.all(
          color: isNextPrayer ? Colors.white : Color(0xffe2e2fc), // لون الحدود للصلاة المقبلة
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            prayerName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isNextPrayer ? Colors.white : Colors.black, // لون النص للصلاة المقبلة
            ),
          ),
          SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(
              fontSize: 16,
              color: isNextPrayer ? Colors.white : Colors.black, // لون النص للصلاة المقبلة
            ),
          ),
        ],
      ),
    );
  }
}