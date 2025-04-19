import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled/calendar.dart';


import 'Screen/preferences_screen.dart';
import 'Services/SettingsService.dart';
import 'core/TTSSettings.dart';
import 'core/background_service.dart';
import 'core/day_service.dart';
import 'l10n/app_localizations.dart';



import 'package:flutter_background_service/flutter_background_service.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';


// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();


// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     print("🔔 تنفيذ التذكير: $task");
//
//     String title = inputData?['title'] ?? 'تذكير';
//     String body = inputData?['body'] ?? 'لا يوجد نص';
//
//     // عرض إشعار عند وقت التذكير
//     showNotification(title, body);
//
//     return Future.value(true);
//   });
// }
// void requestPermission() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   NotificationSettings settings = await messaging.requestPermission();
//   print('إذن الإشعارات: ${settings.authorizationStatus}');
// }
//
// void showNotification(String title, String body) async {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   var androidDetails = AndroidNotificationDetails(
//     'full_screen_channel_id',
//     'تذكير كامل الشاشة',
//     importance: Importance.high,
//     priority: Priority.high,
//     fullScreenIntent: true, // ✅ إشعار ملء الشاشة
//     playSound: true,
//     sound: RawResourceAndroidNotificationSound('custom_sound'), // ✅ الصوت
//   );
//
//   var platformDetails = NotificationDetails(android: androidDetails);
//
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     title,
//     body,
//     platformDetails,
//   );
// }

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("تم استلام إشعار في الخلفية: ${message.messageId}");
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  final service = FlutterBackgroundService();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String langCode = prefs.getString('lang') ?? 'ar'; // الافتراضي 'ar'
  // await Firebase.initializeApp();
  // await Get.putAsync(() async => DayService());
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // requestPermission();
  // تهيئة الإشعارات
  // const AndroidInitializationSettings initializationSettingsAndroid2 =
  // AndroidInitializationSettings('@mipmap/ic_launcher');
  //
  // final InitializationSettings initializationSettings2 =
  // InitializationSettings(android: initializationSettingsAndroid2);
  //
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings2);

  TTSSettings.configureTTS();
  // تهيئة WorkManager
  // Workmanager().initialize(
  //   callbackDispatcher,
  //   isInDebugMode: false, // 🚀 الوضع الإنتاجي
  // );

  //
  // // ✅ بدء AlarmManager
  // await AndroidAlarmManager.initialize();
  //
  // // ✅ إعداد الإشعارات
  // const AndroidInitializationSettings initializationSettingsAndroid =
  // AndroidInitializationSettings('app_icon');
  // const InitializationSettings initSettings =
  // InitializationSettings(android: initializationSettingsAndroid);
  //
  // await flutterLocalNotificationsPlugin.initialize(
  //   initSettings,
  // );
  // // إعداد TTS
  //

  await Get.putAsync(() async {
    final service = SettingsService();
    await service.initSettings();
    return service;
  });

  runApp(MyApp(langCode: langCode));}


class MyApp extends StatefulWidget {
  final String langCode;

  const MyApp({super.key, required this.langCode});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {}); // تحديث الواجهة عند العودة من الخلفية
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hijri Picker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      supportedLocales: const [
        Locale('en'), // 🇬🇧 الإنجليزية
        Locale('ar'), // 🇸🇦 العربية
        Locale('fr'), // 🇫🇷 الفرنسية
        Locale('tr'), // 🇹🇷 التركية
        Locale('ja'), // 🇹🇷 التركية
        Locale('de'), // 🇹🇷 التركية
        Locale('ku'), // 🇹🇷 التركية
        Locale('ru'), // 🇹🇷 التركية
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(widget.langCode.toString()), // 🇸🇦 العربية

      home:Calendar(),

    );
  }
}

// // تعريف كائن الإشعارات
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// // إعداد الإشعارات
// Future<void> initializeNotifications() async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('@mipmap/ic_launcher');
//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// }
//
// // إرسال الإشعار
// Future<void> showPrayerNotification(String prayerName) async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//   AndroidNotificationDetails(
//     'prayer_channel_id', // ID القناة
//     'Prayer Notifications', // اسم القناة
//     channelDescription: 'Notifies when it is time for prayer.',
//     importance: Importance.max,
//     priority: Priority.high,
//     ticker: 'Prayer Time',
//   );
//
//   const NotificationDetails platformChannelSpecifics =
//   NotificationDetails(android: androidPlatformChannelSpecifics);
//
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     '🕌 وقت الصلاة!',
//     'حان الآن وقت صلاة $prayerName.',
//     platformChannelSpecifics,
//   );
// }
//

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إدارة المتحولات بـ GetX'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Get.to(PreferencesScreen()),
              child: Text('فتح شاشة الإعدادات'),
            ),
          ],
        ),
      ),
    );
  }
}


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsService settings = Get.find();

    return Scaffold(
      appBar: AppBar(title: Text('الإعدادات')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // الطريقة الصحيحة: تغليف الجزء الصغير فقط الذي يحتاج للتحديث
            Obx(() => SwitchListTile(
              title: Text('وضع إضافة يوم'),
              value: settings.addDay.value,
              onChanged: (val) {
                settings.addDay(val);
                settings.saveSettings();
              },
            )),
            SizedBox(height: 20),
            Obx(() => SwitchListTile(
              title: Text('وضع طرح يوم'),
              value: settings.subDay.value,
              onChanged: (val) {
                settings.subDay(val);
                settings.saveSettings();
              },
            )),
            SizedBox(height: 20),
            // عرض القيم - أيضاً مغلف بـ Obx
            Obx(() => Column(
              children: [
                Text('القيم الحالية:', style: TextStyle(fontSize: 18)),
                Text('إضافة يوم: ${settings.addDay.value}'),
                Text('طرح يوم: ${settings.subDay.value}'),
              ],
            )),
          ],
        ),
      ),
    );
  }
}