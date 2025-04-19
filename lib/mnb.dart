import 'package:flutter_tts/flutter_tts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Theme/color.dart';
import 'package:untitled/widgets/man_widget/mytext.dart';
import 'l10n/app_localizations.dart';

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
  Database? _database;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'prayer_times.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE prayers(name TEXT PRIMARY KEY, time TEXT)",
        );
      },
      version: 1,
    );
    fetchPrayerTimes();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    _database?.close();
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

  Future<void> fetchPrayerTimes() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.muslim_world_league.getParameters();
      params.madhab = Madhab.hanafi;
      final prayerTimesData = PrayerTimes.today(coordinates, params);

      Map<String, DateTime> tempPrayerTimes = {
        "Fajr": prayerTimesData.fajr,
        "Sunrise": prayerTimesData.sunrise,
        "Dhuhr": prayerTimesData.dhuhr,
        "Asr": prayerTimesData.asr,
        "Maghrib": prayerTimesData.maghrib,
        "Isha": prayerTimesData.isha,
      };

      final db = _database;
      if (db != null) {
        for (var entry in tempPrayerTimes.entries) {
          final List<Map<String, dynamic>> result = await db.query(
            'prayers',
            where: 'name = ?',
            whereArgs: [entry.key],
          );
          if (result.isNotEmpty) {
            tempPrayerTimes[entry.key] = DateFormat.Hm().parse(result.first['time']);
          } else {
            await db.insert(
              'prayers',
              {'name': entry.key, 'time': DateFormat.Hm().format(entry.value)},
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        }
      }

      setState(() {
        prayerTimes = tempPrayerTimes;
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

  Future<void> _editPrayerTime(String prayer,BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(prayerTimes[prayer]!));

    if (pickedTime != null) {
      DateTime newTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );
      await _database?.update(
        'prayers',
        {'time': DateFormat.Hm().format(newTime)},
        where: 'name = ?',
        whereArgs: [prayer],
      );
      setState(() {
        prayerTimes[prayer] = newTime;
        updateTimeToNextPrayer();
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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: prayerTimes.entries.map((entry) {
            return InkWell(
              onTap: () => _editPrayerTime(entry.key,context),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: entry.key == nextPrayerName ? AppColor.thirdColor : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(children: [
                  Text(entry.key, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(DateFormat.Hm().format(entry.value), style: TextStyle(fontSize: 16)),
                ]),
              ),
            );
          }).toList(),
        ),
      ),
      SizedBox(height: 10),
      ElevatedButton(
        onPressed: () async {
          final FlutterTts flutterTts = FlutterTts();
          await flutterTts.speak("${localizations.time_remaining} ${nextPrayerName ?? localizations.no_upcoming_prayer}");
        },
        child: Icon(Icons.volume_up, size: 32),
      ),
    ]);
  }
}
