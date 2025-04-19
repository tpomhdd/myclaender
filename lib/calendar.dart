import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/jHijri.dart';
import 'package:jhijri_picker/jhijri_picker.dart';
import 'package:untitled/Theme/color.dart';
import 'package:untitled/core/Clinet.dart';
import 'package:untitled/core/Services/pickimage.dart';
import 'package:untitled/List_note.dart';
import 'package:untitled/widgets/calender_widget.dart';
import 'package:untitled/widgets/man_widget/mytext.dart';
import 'package:untitled/widgets/myWidget/bottombar.dart';
import 'package:untitled/widgets/tap_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:permission_handler/permission_handler.dart';

import '../core/man_widget/Btn.dart';
import '../core/man_widget/textfiled.dart';
import '../core/mydata.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:untitled/Theme/color.dart';
import 'package:untitled/List_note.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:untitled/widgets/calender_widget.dart';
import 'package:untitled/widgets/man_widget/mytext.dart';
import 'package:untitled/core/Clinet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import 'HijriDateScreen.dart';
import 'PAGESNOTE.dart';
import 'Services/SettingsService.dart';
import 'Services/add_location_weather.dart';
import 'dily.dart';
import 'l10n/app_localizations.dart';
// باقي الاستيرادات ...

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}
class _CalendarState extends State<Calendar> with SingleTickerProviderStateMixin {

  Future<bool> _checkLocationPermission() async {
    var status = await Permission.location.request();
    return status.isGranted;
  }

  bool speek = false;
  late JHijri jh3;
  final TextEditingController textController = TextEditingController();

  Future<void> speak(String text) async {
    final FlutterTts flutterTts = FlutterTts();

    if (text.isEmpty) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? lang = prefs.getString('lang');
    if (speek) {
      await flutterTts.setLanguage(lang ?? 'ar');
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.5);

      await flutterTts.speak(text);

      flutterTts.setCompletionHandler(() {
        setState(() {
          speek = false;
        });
      });
    } else {
      flutterTts.stop();
    }
  }
  int daysInMonth = 29; // عدد الأيام الافتراضي

  Future<int?> fetchHijriDays(int year, int month) async {
    final url = 'https://api.aladhan.com/v1/gToH?date=$year-$month-01';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        int days = int.parse(data['data']['hijri']['days']);
        return days;
      }
    } catch (e) {
      print('Failed to fetch hijri days: $e');
    }
    return null;
  }

  void updateHijriDays() async {
    int? correctedDays = await fetchHijriDays(jh3.year, jh3.month);

    setState(() {
      if (correctedDays != null) {
        daysInMonth = correctedDays; // ضبط عدد الأيام من API
        print('عدد الأيام بعد التعديل: $daysInMonth');
      } else {

   //     daysInMonth = jh3.d; // إذا فشل الـ API استخدم عدد الأيام من المكتبة
      }
    });
  }




  String translateDayName(String day, AppLocalizations loc) {
    switch(day.toLowerCase()){
      case "sunday":
        return loc.day_name_sunday;
      case "monday":
        return loc.day_name_monday;
      case "tuesday":
        return loc.day_name_tuesday;
      case "wednesday":
        return loc.day_name_wednesday;
      case "thursday":
        return loc.day_name_thursday;
      case "friday":
        return loc.day_name_friday;
      case "saturday":
        return loc.day_name_saturday;
      default:
        return day;
    }
  }
  int temperature = 0;
  String condition = '';
  int humidity = 0;
  String country = '';
  String city = '';
  WeatherModel weatherModel = WeatherModel();
  Position? _currentPosition;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;


  Future<void> _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position; // تحديث الموقع وعرضه في الشاشة
      });
    }
  }



  /// variable weatherData contain response from the API
  /// to fetch data check the response to get the way the data structured
  getLocationData() async {
    var weatherData = await weatherModel.getLocationWeather();
    setState(() {
      condition = weatherData['weather'][0]['main'];
      humidity = weatherData['main']['humidity'];
      country = weatherData['sys']['country'];
      city = weatherData['name'];
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
    });
  }
  // Future<void> sendTokenToServer(String token) async {
  //   final response = await http.post(
  //     Uri.parse("https://tpowep.com/api/mycleander/save_token.php"),
  //     body: {"token": token},
  //   );
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print("إشعار وارد: ${message.notification?.title}");
  //   });
  //   if (response.statusCode == 200) {
  //     print("تم حفظ التوكن بنجاح");
  //   } else {
  //     print("فشل حفظ التوكن");
  //   }
  // }
  //
  @override
  void initState() {
  _getLocation(); // طلب الموقع مباشرة عند تشغيل التطبيق
  getLocationData();
setState(() {
  final SettingsService settings = Get.find();


  DateTime date = settings.addDay.value ? DateTime.now().add(Duration(days: 1)) : DateTime.now();
  jh3 = JHijri(fDate: date);
   date = settings.subDay.value ? DateTime.now().subtract(Duration(days: 1)) : DateTime.now();
  jh3 = JHijri(fDate: date);

});
  updateHijriDays();
  /*aseMessaging.instance.getToken().then((token) {
    print("FCM Token: $token");
    sendTokenToServer(token.toString());

    // يمكنك إرسال التوكن إلى قاعدة بياناتك
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("تم استلام إشعار في المقدمة: ${message.notification?.title}");
  });*/
  _controller = AnimationController(vsync: this, duration: Duration(seconds: 1))
    ..repeat(reverse: true);
  _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
  );    // TODO: implement initState
    super.initState();
  }

  @override
  DateTime now = DateTime.now();


  Widget build(BuildContext context) {


    int d = (now.weekday+1) % 7;


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
    final List<String> hijriMonths = [
      localizations.hijri_month_1,
      localizations.hijri_month_2,
      localizations.hijri_month_3,
      localizations.hijri_month_4,
      localizations.hijri_month_5,
      localizations.hijri_month_6,
      localizations.hijri_month_7,
      localizations.hijri_month_8,
      localizations.hijri_month_9,
      localizations.hijri_month_10,
      localizations.hijri_month_11,
      localizations.hijri_month_12,
    ];

    final List<String> days = [
      localizations.day_name_saturday,
      localizations.day_name_sunday,
      localizations.day_name_monday,
      localizations.day_name_tuesday,
      localizations.day_name_wednesday,
      localizations.day_name_thursday,
      localizations.day_name_friday,


    ];
    print(days.toString());
    print(now.weekday.toString());
    return Scaffold(

      body:
_currentPosition != null?
Center(
  child:   Container(


    decoration: BoxDecoration(
      color: AppColor.backgroundcolor,
//      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child:   calender_widget(
      speekbool: speek,
            hijriyear: jh3.hijri.year.toString(),
            hijridayName: days[d],
            year: now.year.toString(),
            hijrimonthName: hijriMonths[jh3.month-1],
            monthName: months[now.month - 1],
            month: now.month.toString(),
            hijriday: jh3.hijri.day.toString(),
            day: now.day.toString(),
            viewer: '0',
            onPressed2: () => Get.to(List_note()),
            onPressed3: () {
              setState(() {
                d = (d + 1) %6 ; // إذا أصبح d 7 سيصبح 0
                now = now.add(Duration(days: 1)); // الانتقال لليوم التالي
                jh3 = JHijri(fDate: now); // تحديث التاريخ الهجري
              });
            },
            speek: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              String? lang = prefs.getString('lang'); // قراءة القيمة

     setState(() {
       speek=!speek;
       String currentTime = DateFormat('hh:mm a',lang).format(now); // تنسيق الوقت الحالي بالعربية
       speak(days[d] + "  " + now.day.toString() + " " + months[now.month - 1] + " " + now.year.toString() +
           " ميلادي " + jh3.hijri.day.toString() + " " + hijriMonths[jh3.month - 1] + " " + jh3.hijri.year.toString() +
           " هجري، والوقت الآن " + currentTime+"  "+localizations.temperature+temperature.toString() +localizations.celsius+"   "+localizations.greetings);

     });       },
            onPressed4: () {
              setState(() {
                // لضمان عدم نزول d تحت الصفر: نضيف 7 ثم نقسم على باقي 7
                d = (d - 1) % 7;
                now = now.subtract(Duration(days: 1)); // الانتقال لليوم السابق
                jh3 = JHijri(fDate: now); // تحديث التاريخ الهجري
              });
            },
            onPressed1: () => _showAddNoteDialog(context),
            onPressed5: () => _showDateSelectionDialog(context),
            dateTime: now,
            onPressed6: ()=>showCustomBottomSheet(context),
          ),
  ),
):Center(
  child:

  ScaleTransition(
    scale: _scaleAnimation,
    child: Icon(Icons.location_on, size: 155, color: Colors.green),
  ),),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    final localizations = AppLocalizations.of(context)!;    mydata mydataa = mydata();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // شريط السحب في الأعلى
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 15),

                // إدخال النص
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: localizations.settings,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 15),

  upuimg(),              SizedBox(height: 10),

                // زر الحفظ
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    String img = sharedPreferences.getString("img") ?? "";
                    mydataa.addnote(
                      textEditingController.text,
                        now.toString(),
                      jh3.toString(),
                      'TEXT',
                      img,
                      'state',
                    );

mydata.snakbar();                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Text(localizations.save, style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },

    );

  }
  void _showDateSelectionDialog(BuildContext context) {
    Get.defaultDialog(
      title: AppLocalizations.of(context)!.go_to_date, // استخدام المفتاح
      content: Column(
        children: [
          tap_settings(
            txt: AppLocalizations.of(context)!.gregorian_calendar,
            onPressed1: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                lastDate: DateTime.now(),
                firstDate: DateTime(2015),
                initialDate: DateTime.now(),
              );
              if (pickedDate != null) {
                setState(() {
                  now = pickedDate;
                  jh3 = JHijri(fDate: pickedDate);
                });
              }
            },
          ),
          tap_settings(
            txt: AppLocalizations.of(context)!.hijri_calendar,
            onPressed1: () async {
              final dateTime = await showJHijriPicker(
                context: context,
                startDate: JDateModel(jhijri: JHijri(fYear: 1442, fMonth: 12, fDay: 10)),
                selectedDate: JDateModel(jhijri: JHijri.now()),
                endDate: JDateModel(jhijri: JHijri(fYear: 1460, fMonth: 1, fDay: 25)),
                pickerMode: DatePickerMode.day,
                theme: Theme.of(context),
                locale: Locale("ar", "SA"),
                okButton: AppLocalizations.of(context)!.save,
                cancelButton: AppLocalizations.of(context)!.back,
                onOk: (HijriDate value) {
                  setState(() {
                    jh3 = JHijri(
                        fYear: value.year,
                        fMonth: value.month,
                        fDay: value.day
                    );
                  });
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                onCancel: () => Navigator.pop(context),
                primaryColor: Colors.blue,
                calendarTextColor: Colors.white,
                backgroundColor: Colors.black,
                borderRadius: Radius.circular(10),
                buttonTextColor: Colors.white,
                headerTitle: Center(child: Text(AppLocalizations.of(context)!.hijri_calendar)),
              );
            },
          ),
        ],
      ),
    );
  }


  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5, // نسبة الارتفاع عند الفتح
          minChildSize: 0.3, // أقل ارتفاع عند السحب
          maxChildSize: 0.9, // أقصى ارتفاع يمكن الوصول إليه
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildListTile(
                    context,
                    icon: Icons.note_add,
                    title: "إضافة ملاحظة",
              //      onTap: onPressed1,
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.list_alt,
                    title: "سجل التذكيرات",
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => List_note()),
                    ),
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.date_range,
                    title: "إضافة صفحة يومية",
                    onTap: () => Get.to(DailyPlannerScreen(dateTime: now)),
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.book,
                    title: "صفحات دفتر الملاحظات",
                    onTap: () => Get.to(PagesNote()),
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.calendar_today,
                    title: "التقويم الهجري",
                    onTap: () => Get.to(HijriDateScreen()),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildListTile(BuildContext context, {required IconData icon, required String title, void Function()? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      onTap: () {
        Navigator.pop(context);
        if (onTap != null) onTap();
      },
    );
  }

  DateTime convertHijriToGregorian(JHijri hijriDate) {
    // دالة تحويل (مثال توضيحي)
    return DateTime(hijriDate.fYear, hijriDate.fMonth, hijriDate.fDay);
  }
}

// باقي الكود (مثل dorwvertical, myDivider, myrow، و Setteing) يجب تعديل النصوص الثابتة فيها بنفس الطريقة:

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
                  border: Border.all(
                      color: AppColor.primaryColor, width: 1)),
              child: Center(
                  child: MyText(
                    color: textColor,
                    text: text1,
                    size: 22,
                    fontWeight: fontWeight,
                  )),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColor.primaryColor, width: 1)),
              child: Center(
                  child: MyText(
                      color: textColor,
                      text: text2,
                      size: 22,
                      fontWeight: fontWeight)),
            ),
          ),
        ),
      ],
    );
  }
}

class Setteing extends StatelessWidget {
  final void Function()? onPressed1;
  final DateTime dateTime;
  const Setteing({Key? key, this.onPressed1, required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.scale,
            title: 'مرحبا',
            desc: 'هذا حوار رائع!',
            btnOkOnPress: () {},
          ).show();

          // showAnimatedDialog(
          //   context: context,
          //   barrierDismissible: true,
          //   builder: (BuildContext context) {
          //     return Material(
          //         shadowColor: Colors.yellow,
          //         child: Container(
          //             decoration: BoxDecoration(
          //                 color: AppColor.thirdColor,
          //                 border: Border.all(
          //                     color: AppColor.primaryColor, width: 1)),
          //             alignment: Alignment.center,
          //             height: 15,
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 tap_settings(
          //                   txt: AppLocalizations.of(context)!.add_note,
          //                   onPressed1: onPressed1,
          //                 ),
          //                 tap_settings(
          //                   txt: AppLocalizations.of(context)!.reminder_log,
          //                   onPressed1: () {
          //                     Navigator.pushReplacement(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) => List_note()),
          //                     );
          //                   },
          //                 ),
          //                 tap_settings(
          //                   txt: AppLocalizations.of(context)!.add_page,
          //                   onPressed1: () {
          //                     Get.to(DailyPlannerScreen(
          //                       dateTime: dateTime,
          //                     ));
          //                   },
          //                 ),
          //                 tap_settings(
          //                   txt: AppLocalizations.of(context)!.notebook_pages,
          //                   onPressed1: () {
          //                     Get.to(PagesNote());
          //                   },
          //                 ),
          //                 tap_settings(
          //                   txt: AppLocalizations.of(context)!.hijri_calendar,
          //                   onPressed1: () {
          //                     Get.to(HijriDateScreen());
          //                   },
          //                 )
          //               ],
          //             )));
          //   },
          //   animationType: DialogTransitionType.scaleRotate,
          //   curve: Curves.fastOutSlowIn,
          //   duration: Duration(seconds: 1),
          // );


        },
        child: Center(
            child: MyText(
                color: Colors.black,
                text: AppLocalizations.of(context)!.settings,
                size: 17))
    );
  }
}
