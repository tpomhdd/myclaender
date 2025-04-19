import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:untitled/core/Speek.dart';
import 'package:untitled/Theme/color.dart';
import 'package:untitled/core/Services/pickimage.dart';
import 'package:untitled/core/app_color.dart';
import 'package:untitled/core/man_widget/textfiled.dart';
import 'package:untitled/core/mydata.dart';

import 'package:untitled/widgets/man_widget/mytext.dart';
import 'l10n/app_localizations.dart';

class DailyPlannerScreen2 extends StatefulWidget {
  final DateTime dateTime;
  final String txt;
  final String img;

  const DailyPlannerScreen2({
    Key? key,
    required this.dateTime,
    required this.txt,
    required this.img,
  }) : super(key: key);

  @override
  _DailyPlannerScreen2State createState() => _DailyPlannerScreen2State();
}

class _DailyPlannerScreen2State extends State<DailyPlannerScreen2> {
  late TextEditingController textEditingController;
  late String displayedImg;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.txt);
    displayedImg = widget.img;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = widget.dateTime;
    String dayName = DateFormat('EEEE', 'en').format(now);
    String dayNameArabic = DateFormat('EEEE', 'ar').format(now);
    String formattedDate = DateFormat('dd / MM').format(now);
    String formattedYear = DateFormat('yyyy').format(now);
    final localizations = AppLocalizations.of(context)!;

    final List<String> months = [
      localizations.month_1,
      localizations.month_2,
      localizations.month_3,
      localizations.month_4,
      localizations.month_5,
      localizations.month_6,
      localizations.month_7,
      localizations.month_8,
      localizations.month_9,
      localizations.month_10,
      localizations.month_11,
      localizations.month_12,
    ];

    String hijriDate = JHijri(fDate: now).toString();
    JHijri hijri = JHijri(fDate: now);

    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 26,
        child: IconButton(
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
              "${hijri.dayName} ${now.day} ${months[now.month - 1]} ${now.year} "
                  "${hijri.day} ${hijri.monthName} ${hijri.year} ${widget.txt}",
            );
          },
        ),
        backgroundColor: Color(0xff9da0ff),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff9da0ff),
        title: Text("مفكرة", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$dayName ($dayNameArabic)",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hijriDate,
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                      Text(
                        formattedYear,
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      itemCount: 24,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: MyText(
                            color: Colors.black,
                            text: textEditingController.text,
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: displayedImg.isNotEmpty
                              ? Container(
                            width: 200,
                            height: 200,
                            child: Image.file(
                              File(displayedImg),
                              fit: BoxFit.cover,
                            ),
                          )
                              : SizedBox(),
                        ),
                      ],
                    ),
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
