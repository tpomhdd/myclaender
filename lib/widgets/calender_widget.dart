import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

import 'package:intl/intl.dart';
import 'package:untitled/AgeCalculatorScreen.dart';
import 'package:untitled/EidCountdownScreen.dart';
import 'package:untitled/HijriDateScreen.dart';
import 'package:untitled/NotesListScreen.dart';
import 'package:untitled/PAGESNOTE.dart';
import 'package:untitled/Payer.dart';
import 'package:untitled/Prayer.dart';
import 'package:untitled/Screen/Page2.dart';
import 'package:untitled/VoiceMemoScreen.dart';
import 'package:one_clock/one_clock.dart';

import '../../Theme/color.dart';
import 'dart:io';

import 'package:get/get.dart';
import 'package:untitled/CountryCityPicker.dart';
import 'package:untitled/core/Clinet.dart';
import 'package:untitled/timkes.dart';
import 'package:untitled/widgets/myWidget/myclock.dart';
import 'package:untitled/widgets/tap_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import '../List_note.dart';
import '../Services/SettingsService.dart';
import '../Theme/color.dart';
import '../core/AdManager.dart';
import '../core/man_widget/mytext.dart';
import '../calendar.dart';
import 'package:intl/intl.dart';
import '../dily.dart';
import '../l10n/app_localizations.dart';

class calender_widget extends StatelessWidget {
  final String hijriyear;
  final String hijridayName;
  final String year;
  final String hijrimonthName;
  final String monthName;
  final String month;
  final DateTime dateTime;
  final String hijriday;
  final String day;
  final String viewer;
  final bool speekbool;
  final String? text;
  final String? IMG;
  final void Function()? onPressed1;
  final void Function()? speek;
  final void Function()? onPressed2;
  final void Function()? onPressed3;
  final void Function()? onPressed4;
  final void Function()? onPressed5;
  final void Function()? onPressed6;

  const calender_widget({
    Key? key,
    required this.hijriyear,
    required this.hijridayName,
    required this.year,
    required this.hijrimonthName,
    required this.monthName,
    required this.month,
    required this.hijriday,
    required this.day,
    required this.viewer,
    this.onPressed1,
    this.onPressed2,
    this.text,
    this.IMG,
    this.onPressed3,
    this.onPressed4,
    this.onPressed5,
    required this.dateTime,
    this.speek,
    this.onPressed6,
    required this.speekbool,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // نستخدم AppLocalizations من الـ context الخارجي
    final localizations = AppLocalizations.of(context)!;
    DateTime currentDateTime = DateTime.now();

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: Column(
                  children: [
                    Center(
                        child: Row(
                      children: [
                        Expanded(flex: 7, child: Page2()),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: speek,
                                child: Icon(
                                  speekbool
                                      ? Icons.stop
                                      : Icons.volume_down_sharp,
                                  size: 32,
                                )))
                      ],
                    )),
                    Center(
                      child: Container(
                        color: AppColor.primaryColor,
                        width: MediaQuery.of(context).size.width - 50,
                        child: Row(
                          children: [
                            Expanded(flex: 9, child: myclock()),
                            Expanded(
                              flex: 2,
                              child: AnalogClock(
                                width: 50,
                                height: 50,
                                isLive: true,
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  shape: BoxShape.circle,
                                ),
                                datetime: currentDateTime,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: Center(
                                child: MyText(
                                  color: Colors.black,
                                  text: '$hijriyear',
                                  size: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(
                                  color: AppColor.primaryColor,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$hijridayName',
                                  style: TextStyle(
                                    fontFamily: 'tow',
                                    fontSize: 46,
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(
                                  color: AppColor.primaryColor,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: Center(
                                child: MyText(
                                  color: Colors.black,
                                  text: '$year',
                                  size: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(
                                  color: AppColor.primaryColor,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    myrow(
                      text1: '$hijrimonthName',
                      text2: '$monthName',
                      textColor: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    myrow(
                      text1: '$hijriday',
                      text2: '$day',
                      textColor: AppColor.secondColor,
                      fontWeight: FontWeight.w800,
                    ),
                    // مثال على استخدام PrayerTimesScreen (يُفترض أنه مُعرف في مشروعك)
                    Column(
                      children: [
                        PrayerTimesScreen(),

                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.thirdColor,
                            border: Border.all(
                              color: AppColor.primaryColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: onPressed3,
                                  child: Center(
                                    child: MyText(
                                      color: Colors.black,
                                      text: localizations.next_day,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: onPressed4,
                                  child: Center(
                                    child: MyText(
                                      color: Colors.black,
                                      text: localizations.previous_day,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 55,
                          child: Center(
                            child: MyText(
                              color: Colors.black,
                              text: localizations.greetings,
                              size: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.thirdColor,
                            border: Border.all(
                              color: AppColor.primaryColor,
                              width: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.thirdColor,
                        border: Border.all(
                          color: AppColor.primaryColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Setteing(
                              onPressed1: onPressed1,
                              dateTime: dateTime,
                            ),
                          ),
                          Container(
                            color: AppColor.primaryColor,
                            width: 1,
                            height: 50,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: onPressed5,
                              child: Center(
                                child: MyText(
                                  color: Colors.black,
                                  text: localizations.go_to_date,
                                  size: 17,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
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
        ),
      ),
    );
  }
}

class myrow extends StatelessWidget {
  final String text1;
  final String text2;
  final Color textColor;
  final FontWeight? fontWeight;
  const myrow({
    Key? key,
    required this.text1,
    required this.text2,
    required this.textColor,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.primaryColor, width: 1),
              ),
              child: Center(
                child: MyText(
                  color: textColor,
                  text: text1,
                  size: 22,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.primaryColor, width: 1),
              ),
              child: Center(
                child: MyText(
                  color: textColor,
                  text: text2,
                  size: 22,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class Setteing extends StatefulWidget {
  final void Function()? onPressed1;
  final DateTime dateTime;
  const Setteing({Key? key, this.onPressed1, required this.dateTime})
      : super(key: key);

  @override
  State<Setteing> createState() => _SetteingState();
}

class _SetteingState extends State<Setteing> {
  @override
  Widget build(BuildContext context) {
    final SettingsService settings = Get.find();
    final localizations = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {
        AdManager.loadInterstitialAd(() {
          print("تم إغلاق الإعلان بنجاح");
        });
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: AppColor.thirdColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // شريط السحب العلوي
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 10),

                    // عنوان الإعدادات
                    Text(
                      localizations.settings,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    SizedBox(height: 15),

                    // قائمة الخيارات
                    ListView(
                      shrinkWrap: true,
                      children: [
                        _buildSettingItem(
                          icon: Icons.note_add,
                          text: localizations.add_note,
                          onTap:widget.onPressed1,
                        ),
                        _buildSettingItem(
                          icon: Icons.notifications,
                          text: localizations.reminder_log,
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => List_note()));
                          },
                        ),
                        // _buildSettingItem(
                        //   icon: Icons.add_circle_outline,
                        //   text: localizations.add_page,
                        //   onTap: () {
                        //     Get.to(DailyPlannerScreen(dateTime:widget.dateTime));
                        //   },
                        // ),
                        //
                        _buildSettingItem(
                          icon: Icons.book,
                          text: localizations.notebook_pages,
                          onTap: () {
                            Get.to(PagesNote());
                          },
                        ),
                        // _buildSettingItem(
                        //   icon: Icons.calendar_today,
                        //   text: localizations.hijri_calendar,
                        //   onTap: () {
                        //     Get.to(HijriDateScreen());
                        //   },
                        // ),

                        _buildSettingItem(
                          icon: Icons.list,
                          text: localizations.list_note,
                          onTap: () {
                            Get.to(NotesListScreen());
                          },
                        ),
                        _buildSettingItem(
                          icon: Icons.volume_down_sharp,
                          text: localizations.voice_Memo,
                          onTap: () {
                            Get.to(VoiceMemoScreen());
                          },
                        ),
                        _buildSettingItem(
                          icon: Icons.timer,
                          text: localizations.change_Language,
                          onTap: () {
                            Get.defaultDialog(
                              title: localizations.change_Language,
                              titleStyle: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white,
                              radius: 10,
                              barrierDismissible: true,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // خيار اللغة العربية
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                      sharedPreferences.setString("lang", "ar");

                                      Get.updateLocale(Locale(
                                          'ar', 'SA')); // تغيير اللغة للعربية
                                      Get.back(); // إغلاق الحوار
                                      Get.back(); // إغلاق الحوار
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'العربية',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  // خيار اللغة الإنجليزية
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                      sharedPreferences.setString("lang", "en");
                                      Get.updateLocale(Locale('en', 'US'));
                                      Get.back();
                                      Get.back();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'English',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  // خيار اللغة الفرنسية
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                      sharedPreferences.setString("lang", "fr");
                                      Get.updateLocale(Locale('fr', 'FR'));
                                      Get.back();
                                      Get.back();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Français',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  // خيار اللغة التركية

                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                      sharedPreferences.setString("lang", "tr");

                                      Get.updateLocale(Locale('tr', 'TR'));
                                      Get.back();
                                      Get.back();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Türkçe',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                      sharedPreferences.setString("lang", "de");

                                      Get.updateLocale(Locale('de', 'DE'));
                                      Get.back();
                                      Get.back();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Deutsch',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                      sharedPreferences.setString("lang", "ru");

                                      Get.updateLocale(Locale('ru', 'RU'));
                                      Get.back();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Русский',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                      sharedPreferences.setString("lang", "ja");

                                      Get.updateLocale(Locale('ja', 'JP'));
                                      Get.back();
                                      Get.back();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '日本語', // "Nihongo" (اليابانية)
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),

                          child: Obx(() => SwitchListTile(
                            title: Text(localizations.increase_hijri_day),
                            value: settings.addDay.value,
                            onChanged: (val) {
                              settings.addDay(val);
                              settings.saveSettings();
                              Future.delayed(Duration(milliseconds: 300), () {
                                Restart.restartApp();
                              });
                            },
                          )),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),

                          child: Obx(() => SwitchListTile(
                            title: Text(localizations.decrease_hijri_day),
                            value: settings.subDay.value,
                            onChanged: (val) {
                              setState(() {
                                settings.subDay(val);
                                settings.saveSettings();
                                Future.delayed(Duration(milliseconds: 300), () {
                                  Restart.restartApp();
                                });

                              });
                            },
                          )),
                        ),

                        // _buildSettingItem(
                        //   icon: Icons.timer,
                        //   text: 'اعرف عمرك',
                        //   onTap: () {
                        //     Get.to(AgeCalculatorScreen());
                        //   },
                        // ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Center(
        child: MyText(
          color: Colors.black,
          text: localizations.settings,
          size: 17,
        ),
      ),
    );
  }
}


Widget _buildSettingItem(
    {required IconData icon,
    required String text,
    required VoidCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
            Icon(icon, color: AppColor.primaryColor, size: 24),
            SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    ),
  );
}
