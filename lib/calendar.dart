import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:myclaender/Theme/color.dart';
import 'package:myclaender/core/Services/pickimage.dart';

import 'package:myclaender/List_note.dart';

import 'package:myclaender/widgets/calender_widget.dart';
import 'package:myclaender/widgets/man_widget/mytext.dart';
import 'package:myclaender/widgets/myWidget/bottombar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/man_widget/Btn.dart';
import '../core/man_widget/textfiled.dart';
import '../core/mydata.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  var now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    mydata mydataa = new mydata();
    TextEditingController textEditingController = new TextEditingController();
    var jh3 = JHijri(fDate: DateTime.parse("${now}"));
    DateTime jh2 = now;

    List<String> months = [
      'كانون الثاني',
      'شباط',
      'آذار',
      'نيسان',
      'أيار',
      'حزيران',
      'تموز',
      'آب',
      'أيلول',
      'تشرين الأول',
      'تشرين الثاني',
      'كانون الأول',
    ];
    onTapFunction({required BuildContext context}) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        lastDate: DateTime.now(),
        firstDate: DateTime(2015),
        initialDate: DateTime.now(),
      );
      if (pickedDate == null) return;

      jh3 = JHijri(
          fDate:
              DateTime.parse("${DateFormat('yyyy-MM-dd').format(pickedDate)}"));
      jh2 = DateFormat('yyyy-MM-dd').format(pickedDate) as DateTime;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: MyText(color: Colors.white, text: 'الروزنامة', size: 20),
        ),
        body: calender_widget(
          hijriyear: jh3.hijri.year.toString(),
          hijridayName: jh3.hijri.dayName,
          year: jh2.year.toString(),
          hijrimonthName: jh3.hijri.monthName,
          monthName: months[jh2.month - 1],
          month: jh2.month.toString(),
          hijriday: jh3.hijri.day.toString(),
          day: jh2.day.toString(),
          viewer: '0',
          onPressed4: () {
            setState(() {
              DateTime bkday = now.subtract(Duration(days: 1));
              print(bkday);
              now = bkday;
            });
          },
          onPressed3: () {
            setState(() {
              DateTime bkday = now.add(Duration(days: 1));
              print(bkday);
              now = bkday;
            });
          },
          onPressed2: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              lastDate: DateTime.now(),
              firstDate: DateTime(2015),
              initialDate: DateTime.now(),
            );
            if (pickedDate == null) return;

            setState(() {
              jh3 = JHijri(fDate: DateTime.parse("${pickedDate}"));
              jh2 = pickedDate;
              Navigator.of(context);
            });
          },
          onPressed1: () {
            showAnimatedDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyTextField(
                        text: 'موضوع التذكرة',
                        mycolor: Colors.white,
                        controller: textEditingController,
                      ),
                      upuimg(),
                      MyButton(
                        text: 'حفظ',
                        mycolor: Colors.red,
                        onPressed: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();

                          String img = sharedPreferences.get("img").toString();

                          mydataa.addnote(
                              textEditingController.text,
                              jh3.toString(),
                              jh2.toString(),
                              'TEXT',
                              img,
                              'state');

                          mydata.snakbar();
                          setState(() {});
                        },
                      )
                    ],
                  ),
                );
              },
              animationType: DialogTransitionType.fade,
              curve: Curves.fastOutSlowIn,
              duration: Duration(seconds: 1),
            );
          },
        ));
  }
}

class dorwvertical extends StatelessWidget {
  final double heightt;
  const dorwvertical({Key? key, required this.heightt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      height: heightt,
      width: 1,
    );
  }
}

class myDivider extends StatelessWidget {
  const myDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 7,
      color: AppColor.primaryColor,
    );
    ;
  }
}

class myrow extends StatelessWidget {
  final String text1;
  final String text2;
  final Color textColor;
  final FontWeight? fontWeight;
  const myrow(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.textColor,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColor.primaryColor, width: 1)),
                  child: Center(
                      child: MyText(
                    color: textColor,
                    text: text1,
                    size: 33,
                    fontWeight: fontWeight,
                  )))),
        ),
        Expanded(
          child: Center(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColor.primaryColor, width: 1)),
                  child: Center(
                      child: MyText(
                          color: textColor,
                          text: text2,
                          size: 33,
                          fontWeight: fontWeight)))),
        ),
      ],
    );
  }
}
