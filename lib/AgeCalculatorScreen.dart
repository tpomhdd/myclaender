import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'core/Speek.dart';

class AgeCalculatorScreen extends StatefulWidget {
  @override
  _AgeCalculatorScreenState createState() => _AgeCalculatorScreenState();
}

class _AgeCalculatorScreenState extends State<AgeCalculatorScreen> {
  DateTime? birthDate;
  String ageResult = "";
  String zodiacSign = "";
  final TextEditingController _dateController = TextEditingController();

  void _calculateAge() {
    if (birthDate == null) return;
    final currentDate = DateTime.now();
    int years = currentDate.year - birthDate!.year;
    int months = currentDate.month - birthDate!.month;
    int days = currentDate.day - birthDate!.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      months += 12;
    }

    if (days < 0) {
      final previousMonth = DateTime(currentDate.year, currentDate.month - 1, birthDate!.day);
      days += DateTime(currentDate.year, currentDate.month, 0).day;
    }

    setState(() {
      ageResult = "العمر:\n"
          "- $years سنة\n"
          "- $months شهر\n"
          "- $days يوم";
      zodiacSign = _getZodiacSign(birthDate!);
    });
  }

  String _getZodiacSign(DateTime date) {
    int day = date.day;
    int month = date.month;

    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return "الحمل ♈️";
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return "الثور ♉️";
    if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return "الجوزاء ♊️";
    if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return "السرطان ♋️";
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return "الأسد ♌️";
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return "العذراء ♍️";
    if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return "الميزان ♎️";
    if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) return "العقرب ♏️";
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return "القوس ♐️";
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return "الجدي ♑️";
    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return "الدلو ♒️";
    if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) return "الحوت ♓️";
    return "";
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        birthDate = picked;
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text('حاسبة العمر'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'تاريخ الولادة',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.date_range),
              ),
              onTap: _pickDate,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateAge,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('احسب'),
            ),
            SizedBox(height: 30),
            if (ageResult.isNotEmpty)
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.cake, size: 60, color: Colors.pink),
                    SizedBox(height: 10),
                    Text(
                      ageResult,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "برجك: $zodiacSign",
                      style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                    ),
                    IconButton(
                      icon: Icon(
                        Speek.play ? Icons.stop : Icons.volume_down_sharp,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () async {
                        setState(() {
                          Speek.play = !Speek.play;
                        });
                        Speek().speak(
                          ageResult+
                              "برجك: $zodiacSign",

                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
