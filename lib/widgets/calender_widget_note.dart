import 'package:flutter/material.dart';
import 'dart:io';


import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myclaender/CountryCityPicker.dart';
import 'package:myclaender/widgets/myWidget/myclock.dart';
import 'package:myclaender/widgets/tap_settings.dart';

import '../List_note.dart';
import '../Theme/color.dart';
import '../core/man_widget/mytext.dart';
import '../calendar.dart';

import 'package:intl/intl.dart';

class calender_widget_note extends StatelessWidget {
  final String hijriyear;
  final String hijridayName;
  final String year;
  final String hijrimonthName;
  final String monthName;
  final String month;
  final String hijriday;
  final String day;
  final String viewer;
  final String? text;
  final String? IMG;
  final void Function()? onPressed1;
  final void Function()? onPressed2;
  final void Function()? onPressed3;
  final void Function()? onPressed4;

  const calender_widget_note({Key? key, required this.hijriyear, required this.hijridayName, required this.year, required this.hijrimonthName, required this.monthName, required this.month, required this.hijriday, required this.day, required this.viewer, this.text, this.IMG, this.onPressed1, this.onPressed2, this.onPressed3, this.onPressed4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50,

            //    color: AppColor.primaryColor,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex:1,

                      child: Container(
                        child: RotatedBox(
                            quarterTurns: -1,
                            child: Center(
                                child: MyText(
                                  color: Colors.black,
                                  text: '${hijriyear}',
                                  size: 18,fontWeight: FontWeight.w800,))),

                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                vertical: BorderSide(
                                    color: AppColor.primaryColor, width: 1))),

                      ),
                    ),
                    Expanded(
                      flex:5,

                      child: Container(
                        child: Center(
                            child: Text('${hijridayName}',style: TextStyle(fontFamily: '3',fontSize: 73),)),

                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                vertical: BorderSide(
                                    color: AppColor.primaryColor, width: 1))),

                      ),
                    ),
                    Expanded(
                      flex:1,

                      child: Container(
                        child: RotatedBox(
                            quarterTurns: -1,
                            child: Center(
                                child: MyText(
                                  color: Colors.black,
                                  text: '${year}',
                                  size: 18,fontWeight: FontWeight.w800,))),

                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                vertical: BorderSide(
                                    color: AppColor.primaryColor, width: 1))),

                      ),
                    ),
                  ],
                ),                  myrow(
                  text1: '${hijrimonthName}',
                  text2: '${monthName}',
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                myrow(
                    text1: '${hijriday}',
                    text2: '${day}',
                    textColor: AppColor.secondColor,
                    fontWeight: FontWeight.w800),



                Row(
                  children: [
                    Expanded(child: MyText(color: Colors.black, text: text.toString(), size: 30)),
                    Expanded(child: Container(
                      width: 200,
                      height: 200,
                      child: Image.file(
                        //to show image, you type like this.
                        File(IMG.toString()),
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200,
                      ),
                    )),
                  ],
                ),




              ],
            ),
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(30),
              color: Colors.white,

              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor,
                  spreadRadius: 5,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
