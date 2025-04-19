import 'package:jhijri/jHijri.dart';
import 'package:jhijri_picker/jhijri_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:untitled/core/AdManager.dart';
import 'package:untitled/man_widget/Btn.dart';
import 'package:untitled/widgets/man_widget/mytext.dart';

class HijriDateScreen extends StatefulWidget {
  const HijriDateScreen({Key? key}) : super(key: key);

  @override
  State<HijriDateScreen> createState() => _HijriDateScreenState();
}

class _HijriDateScreenState extends State<HijriDateScreen> {
  DateTime now = DateTime.now(); // تخزين التاريخ الحالي
  late JHijri jh3; // تخزين التاريخ الهجري المحول

  @override
  void initState() {
    super.initState();
    jh3 = JHijri(fDate: now); // تعيين التاريخ الهجري عند بدء الشاشة
    AdManager.loadInterstitialAd(() {
      print("تم إغلاق الإعلان بنجاح");
    });
  }

  void updateDate() {
    setState(() {
      now = now.add(Duration(days: 1)); // الانتقال إلى اليوم التالي
      jh3 = JHijri(fDate: now); // تحديث التاريخ الهجري
      print("التاريخ الجديد: $now"); // اختبار التحديث في الكونسول
    });
  }

  void updateDate2() {
    setState(() {
      now = now.subtract(Duration(days: 1)); // الانتقال إلى اليوم التالي
      jh3 = JHijri(fDate: now); // تحديث التاريخ الهجري
      print("التاريخ الجديد: $now"); // اختبار التحديث في الكونسول
    });
  }

  void updateDate3() async {
    print("التاريخ الحالي: $now"); // طباعة التاريخ الحالي

    final dateTime = await showJHijriPicker(
      context: context,
      startDate: JDateModel(
        jhijri: JHijri(
          fYear: 1442,
          fMonth: 12,
          fDay: 10,
        ),
      ),
      selectedDate: JDateModel(jhijri: JHijri.now()),
      endDate: JDateModel(
        jhijri: JHijri(
          fDay: 25,
          fMonth: 1,
          fYear: 1460,
        ),
      ),
      pickerMode: DatePickerMode.day,
      theme: Theme.of(context),
      locale: const Locale("ar", "SA"),
      okButton: "حفظ",
      cancelButton: "عودة",
      onOk: (HijriDate value) {
        debugPrint("📅 التاريخ المختار: ${value}");

        setState(() {
          // إنشاء كائن JHijri باستخدام القيم المختارة
          jh3 = JHijri(fYear: value.year, fMonth: value.month, fDay: value.day);

          // تحويله إلى التاريخ الميلادي
          now = jh3.fDate ??
              DateTime.now(); // إذا كان `null` استخدم التاريخ الحالي

          print("📅 التاريخ الميلادي الجديد: $now");
        });
      },
      onCancel: () {
        Navigator.pop(context);
      },
      primaryColor: Colors.blue,
      calendarTextColor: Colors.white,
      backgroundColor: Colors.black,
      borderRadius: const Radius.circular(10),
      buttonTextColor: Colors.white,
      headerTitle: const Center(
        child: Text("التقويم الهجري"),
      ),
    );

    if (dateTime != null) {
      debugPrint("📅 التاريخ المحوّل: ${dateTime.toMap()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade700,
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: MyButton(
              text: 'اليوم التالي',
              mycolor: Colors.transparent,
              onPressed: updateDate, // تحديث التاريخ عند الضغط
            ),
          ),
          Expanded(
            child: MyButton(
              text: 'اليوم السابق',
              mycolor: Colors.transparent,
              onPressed: updateDate2, // تحديث التاريخ عند الضغط
            ),
          ),
          Expanded(
            child: MyButton(
              text: 'الذهاب الى التاريخ',
              mycolor: Colors.transparent,
              onPressed: updateDate3, // تحديث التاريخ عند الضغط
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade900,
              Colors.red.shade500,
              Colors.red.shade700
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                jh3.dayName, // اسم اليوم (مثلاً السبت)
                style: TextStyle(
                  fontSize: 95,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'tow',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,                children: [
                  Text(
                    convertToArabicNumbers(jh3.hijri.day.toString(),),

                    style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'tow',
                    ),
                  ),
                  SizedBox(width: 22),
                  Text(
                    jh3.monthName, // الشهر الهجري (مثلاً رجب)
                    style: TextStyle(
                      fontSize: 95,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'one',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                convertToArabicNumbers(jh3.year.toString()), // السنة الهجرية (مثلاً 1446)
                style: TextStyle(
                  fontSize: 65,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'tow',

                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  String convertToArabicNumbers(String text) {
    const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return text.split('').map((char) {
      if (char.contains(RegExp(r'\d'))) {
        return arabicNumbers[int.parse(char)];
      }
      return char;
    }).join('');
  }
}