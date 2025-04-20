import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Theme/color.dart';
import 'package:untitled/widgets/man_widget/mytext.dart';
import 'core/Speek.dart';
import 'l10n/app_localizations.dart';

class PrayerTimesScreen extends StatefulWidget {
  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  Map<String, DateTime> prayerTimes = {};
  bool isLoading = true;
  String? nextPrayerName;
  Duration remainingTime = Duration.zero;
  Timer? countdownTimer;

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

  Future<void> fetchPrayerTimes() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.muslim_world_league.getParameters();
      params.madhab = Madhab.hanafi;
      final prayerTimesData = PrayerTimes.today(coordinates, params);

      // تأخير صلاة العصر لمدة ساعة
      DateTime asrTime = prayerTimesData.asr.subtract(Duration(hours: 1));


      setState(() {
        prayerTimes = {
          "Fajr": prayerTimesData.fajr,
          "Sunrise": prayerTimesData.sunrise,
          "Dhuhr": prayerTimesData.dhuhr,
          "Asr": asrTime, // استخدام الوقت المعدل لصلاة العصر
          "Maghrib": prayerTimesData.maghrib,
          "Isha": prayerTimesData.isha,
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

  void updateTimeToNextPrayer() {
    final now = DateTime.now();
    for (var entry in prayerTimes.entries) {
      if (entry.value.isAfter(now)) {
        setState(() {
          nextPrayerName = entry.key;
          remainingTime = entry.value.difference(now);
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

  Duration _timeToDuration(DateTime time) {
    return Duration(hours: time.hour, minutes: time.minute);
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
  bool speek=false;
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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: prayerTimes.entries.map((entry) {
              bool isNextPrayer = entry.key == nextPrayerName;
              return Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isNextPrayer ? AppColor.thirdColor : Colors.white,
                  border: Border.all(
                    color: isNextPrayer ? AppColor.primaryColor : Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
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
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
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
                      ?
                  localizations.time_remaining('prayer', 'time')+' '+translatePrayer(nextPrayerName!, localizations)+' '+formatDuration(remainingTime)

                  //"${localizations.time_remaining}  ${translatePrayer(nextPrayerName!, localizations)} ${}"
                      : localizations.no_upcoming_prayer,
                  size: 15,
                ),
              ),
              SizedBox(width: 22),
              InkWell(
                onTap: () async {
                  speek=!speek;
                  final FlutterTts flutterTts = FlutterTts();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String lang = prefs.getString('lang') ?? 'ar';
                  if(speek) {
                    await flutterTts.setLanguage(lang);
                    await flutterTts.setPitch(1.0);
                    await flutterTts.setSpeechRate(0.5);

                    if (nextPrayerName != null) {
                      String prayerTimeText =
                      translatePrayer(nextPrayerName!, localizations);
                      String remainingText =
                      formatDurationForSpeech(remainingTime);
                      await flutterTts.speak(
                          "${   localizations.time_remaining('prayer', 'time')} $prayerTimeText $remainingText");
                    } else {
                      await flutterTts
                          .speak(localizations.no_upcoming_prayer);
                    }
                  }
                  else{
                    flutterTts.stop();
                  }
                },
                child: Icon(!speek?Icons.volume_up: Icons.stop, size: 32),
              ),
            ],
          ),
        ),
      ],
    );
  }
}