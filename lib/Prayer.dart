import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Theme/color.dart';
import 'package:untitled/widgets/man_widget/mytext.dart';
import 'DatabaseHelper.dart';
import 'core/EditPrayerTimesScreen.dart';
import 'core/Speek.dart';
import 'l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerTimesScreen2 extends StatefulWidget {
  @override
  _PrayerTimesScreen2State createState() => _PrayerTimesScreen2State();
}

class _PrayerTimesScreen2State extends State<PrayerTimesScreen2> {
  Map<String, DateTime> prayerTimes = {};
  bool isLoading = true;
  String? nextPrayerName;
  Duration remainingTime = Duration.zero;
  Timer? countdownTimer;
  DatabaseHelper dbHelper = DatabaseHelper();
  bool speek = false;

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
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
        fetchPrayerTimes();
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

  String formatDurationForSpeech(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);

    if (hours > 0 && minutes > 0) {
      return "$hours ساعة و $minutes دقيقة";
    } else if (hours > 0) {
      return "$hours ساعة";
    } else {
      return "$minutes دقيقة";
    }
  }

  Future<void> fetchPrayerTimes() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.muslim_world_league.getParameters();
      params.madhab = Madhab.hanafi;
      final prayerTimesData = PrayerTimes.today(coordinates, params);
      print(prayerTimesData.toString());
      setState(() async {
        prayerTimes = {
          "Fajr": await _getStoredTime("Fajr", prayerTimesData.fajr),
          "Sunrise": await _getStoredTime("Sunrise", prayerTimesData.sunrise),
          "Dhuhr": await _getStoredTime("Dhuhr", prayerTimesData.dhuhr),
          "Asr": await _getStoredTime("Asr", prayerTimesData.asr),
          "Maghrib": await _getStoredTime("Maghrib", prayerTimesData.maghrib),
          "Isha": await _getStoredTime("Isha", prayerTimesData.isha),
        };
        updateTimeToNextPrayer();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        prayerTimes = {};
        isLoading = false;
      });
    }
  }

  Future<DateTime> _getStoredTime(String prayer, DateTime defaultTime) async {
    String? storedTime = await dbHelper.getPrayerTime(prayer);
    if (storedTime != null) {
      return DateFormat.Hm().parse(storedTime);
    }
    return defaultTime;
  }

  Future<void> _editPrayerTime(String prayer) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(prayerTimes[prayer]!),
    );

    if (pickedTime != null) {
      DateTime newTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );

      await dbHelper.insertPrayerTime(prayer, DateFormat.Hm().format(newTime));

      setState(() {
        prayerTimes[prayer] = newTime;
        updateTimeToNextPrayer(); // تحديث الوقت المتبقي بعد التعديل
      });
    }
  }

  Duration _timeToDuration(DateTime time) {
    return Duration(hours: time.hour, minutes: time.minute);
  }

  void updateTimeToNextPrayer() {
    final now = DateTime.now();
    DateTime? nextPrayerTime;
    String? nextPrayer;

    for (var entry in prayerTimes.entries) {
      if (entry.value.isAfter(now)) {
        if (nextPrayerTime == null || entry.value.isBefore(nextPrayerTime!)) {
          nextPrayerTime = entry.value;
          nextPrayer = entry.key;
        }
      }
    }

    if (nextPrayerTime != null) {
      setState(() {
        nextPrayerName = nextPrayer;
        remainingTime = nextPrayerTime!.difference(now);
      });
      startCountdown();
    } else {
      setState(() {
        nextPrayerName = null;
        remainingTime = Duration.zero;
      });
    }

    // Debug prints
    print("Next Prayer: $nextPrayer");
    print("Next Prayer Time: $nextPrayerTime");
    print("Remaining Time: $remainingTime");
  }

  @override
  Widget build(BuildContext context) {
    String translatePrayer(String key, AppLocalizations loc) {
      switch (key) {
        case "Fajr":
          return loc.prayer_fajr;
        case "Sunrise":
          return loc.prayer_sunrise;
        case "Dhuhr":
          return loc.prayer_dhuhr;
        case "Asr":
          return loc.prayer_asr;
        case "Maghrib":
          return loc.prayer_maghrib;
        case "Isha":
          return loc.prayer_isha;
        default:
          return key;
      }
    }

    final localizations = AppLocalizations.of(context)!;

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: prayerTimes.entries.map((entry) {
                        bool isNextPrayer = entry.key == nextPrayerName;
                        return InkWell(
                          onTap: () {
                            Get.defaultDialog(
                              title: '',
                              content: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      onTap: () {
                                        Speek.play = !Speek.play;
                                        Speek().speak("توقيت صلاة" +
                                            translatePrayer(
                                                entry.key, localizations) +
                                            formatDuration(
                                                _timeToDuration(entry.value)));

// تحويل الوقت إلى Duration
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.spatial_audio_sharp,
                                                color: AppColor.primaryColor,
                                                size: 24),
                                            SizedBox(width: 15),
                                            Text(
                                              localizations.time_speech,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isNextPrayer
                                  ? AppColor.thirdColor
                                  : Colors.white,
                              border: Border.all(
                                color: isNextPrayer
                                    ? AppColor.primaryColor
                                    : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  translatePrayer(entry.key, localizations),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  DateFormat.Hm().format(entry.value),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                width: 350,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.thirdColor,
                  border: Border.all(color: AppColor.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: MyText(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        text: nextPrayerName != null
                            ? "${localizations.time_remaining}  ${translatePrayer(nextPrayerName!, localizations)} ${formatDuration(remainingTime)}"
                            : localizations.no_upcoming_prayer,
                        size: 15,
                      ),
                    ),
                    SizedBox(width: 22),
                    InkWell(
                      onTap: () async {
                        final FlutterTts flutterTts = FlutterTts();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String lang = prefs.getString('lang') ?? 'ar';
                        setState(() {
                          speek = !speek;
                        });
                        if (speek) {
                          await flutterTts.setLanguage(lang);
                          await flutterTts.setPitch(1.0);
                          await flutterTts.setSpeechRate(0.5);

                          if (nextPrayerName != null) {
                            String prayerTimeText =
                                translatePrayer(nextPrayerName!, localizations);
                            String remainingText =
                                formatDurationForSpeech(remainingTime);
                            await flutterTts.speak(
                                "${localizations.time_remaining} $prayerTimeText $remainingText");
                          } else {
                            await flutterTts
                                .speak(localizations.no_upcoming_prayer);
                          }
                        } else {
                          flutterTts.stop();
                        }
                      },
                      child:
                          Icon(!speek ? Icons.volume_up : Icons.stop, size: 32),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
