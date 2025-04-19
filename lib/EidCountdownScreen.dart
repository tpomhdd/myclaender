import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/Theme/color.dart';


class EidCountdownScreen extends StatefulWidget {
  @override
  _EidCountdownScreenState createState() => _EidCountdownScreenState();
}

class _EidCountdownScreenState extends State<EidCountdownScreen> {
  late Timer _timer;
  Duration _remainingTime = Duration();

  @override
  void initState() {
    super.initState();
    // تاريخ العيد (10 أبريل 2025)
    DateTime eidDate = DateTime(2025, 4, 10);
    _remainingTime = eidDate.difference(DateTime.now());
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = _remainingTime - Duration(seconds: 1);
        if (_remainingTime.isNegative) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int days = _remainingTime.inDays;
    int hours = _remainingTime.inHours.remainder(24);
    int minutes = _remainingTime.inMinutes.remainder(60);
    int seconds = _remainingTime.inSeconds.remainder(60);

    return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'الوقت المتبقي حتى عيد الفطر',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 20),
          Container(
            height: 300,
            child: ListView(

              scrollDirection: Axis.horizontal,
              children: [
                _buildTimeCard(days, 'يوم'),
                _buildSeparator(),
                _buildTimeCard(hours, 'ساعة'),
                _buildSeparator(),
                _buildTimeCard(minutes, 'دقيقة'),
                _buildSeparator(),
                _buildTimeCard(seconds, 'ثانية'),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            '🎉 عيد مبارك مقدمًا! 🎉',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      );
  }

  Widget _buildTimeCard(int value, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value.toString().padLeft(2, '0'),
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        ':',
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColor.thirdColor),
      ),
    );
  }
}
