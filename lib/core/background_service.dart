// import 'dart:async';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'notification_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:workmanager/workmanager.dart';
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
// final FlutterTts flutterTts = FlutterTts();
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     String? title = inputData?['title'];
//     String? body = inputData?['body'];
//
//     if (title != null && body != null) {
//       await _showFullScreenNotification(title, body);
//
//       // ✅ تشغيل TTS
//       await flutterTts.speak("$title. $body");
//     }
//     return Future.value(true);
//   });
// }
//
// Future<void> scheduleReminder(DateTime scheduledTime, String title, String body) async {
//   final delay = scheduledTime.difference(DateTime.now());
//   await Workmanager().cancelAll(); // ✅ إزالة المهام السابقة
//
//   if (delay.isNegative) {
//     print('🛑 الوقت المحدد قد مرّ!');
//     return;
//   }
//
//   Workmanager().registerOneOffTask(
//     "unique_task_id", // معرف فريد للمهمة
//     "reminder-task",
//     inputData: {
//       'title': title,
//       'body': body,
//     },
//     initialDelay: delay, // ✅ تأخير التنفيذ حتى الوقت المحدد
//     existingWorkPolicy: ExistingWorkPolicy.replace, // ✅ استبدال المهمة إن كانت موجودة
//     constraints: Constraints(
//       networkType: NetworkType.not_required, // ✅ لا حاجة للشبكة
//       requiresBatteryNotLow: false,
//     ),
//   );
//
//   print("✅ تذكير مضبوط بعد ${delay.inMinutes} دقيقة");
// }
//
// const String notificationSound = 'custom_sound';
//
// Future<void> _showFullScreenNotification(String title, String body) async {
//   final androidPlatformChannelSpecifics = AndroidNotificationDetails(
//     'full_screen_channel_id',
//     'Full Screen Notifications',
//     channelDescription: 'إشعارات ملء الشاشة',
//     importance: Importance.max,
//     priority: Priority.high,
//     fullScreenIntent: true,
//     playSound: true,
//     sound: RawResourceAndroidNotificationSound(notificationSound), // ✅
//   );
//
//   final details = NotificationDetails(android: androidPlatformChannelSpecifics);
//
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     title,
//     body,
//     details,
//     payload: 'reminder',
//   );
// }
//
// void scheduleAlarm(DateTime scheduledTime, String title, String body) {
//   final int alarmId = 0;
//
//   // 🕐 ضبط الوقت
//   final Duration delay = scheduledTime.difference(DateTime.now());
//
//   if (delay.isNegative) {
//     print('🛑 الوقت المحدد قد مرّ!');
//     return;
//   }
//
//   // ✅ جدولة المنبه باستخدام AlarmManager
//   AndroidAlarmManager.oneShot(
//     delay, // وقت التأخير
//     alarmId,
//         () async => showNotification(title, body),
//     exact: true,
//     wakeup: true, // 🚨 تشغيل الجهاز عند التنبيه
//   );
//
//   print("✅ تم ضبط المنبه بعد ${delay.inMinutes} دقيقة");
// }
