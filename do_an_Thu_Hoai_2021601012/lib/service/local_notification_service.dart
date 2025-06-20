// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// class LocalNotificationService {
//   LocalNotificationService();

//   final _localNotificationService = FlutterLocalNotificationsPlugin();

//   final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

//   Future<void> intialize() async {
//     tz.initializeTimeZones();
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@drawable/ic_notifi');

//     DarwinInitializationSettings iosInitializationSettings =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     final InitializationSettings settings = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );

//     await _localNotificationService.initialize(
//       settings,
//     );
//   }

//   Future<NotificationDetails> _notificationDetails() async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('channel_id', 'channel_name',
//             channelDescription: 'description',
//             importance: Importance.max,
//             priority: Priority.max,
//             playSound: true);

//     const DarwinNotificationDetails iosNotificationDetails =
//         DarwinNotificationDetails();

//     return const NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: iosNotificationDetails,
//     );
//   }

//   Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//   }) async {
//     final details = await _notificationDetails();
//     await _localNotificationService.show(id, title, body, details);
//   }

//   Future<void> showScheduledNotification(
//       {required int id,
//       required String title,
//       required String body,
//       required DateTime dateTime}) async {
//     final details = await _notificationDetails();
//     await _localNotificationService.zonedSchedule(
//       id = id,
//       title = title,
//       body = body,
//       tz.TZDateTime.from(
//         dateTime,
//         tz.local,
//       ),
//       details,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
//     );
//   }

//   Future<void> showNotificationWithPayload(
//       {required int id,
//       required String title,
//       required String body,
//       required String payload}) async {
//     final details = await _notificationDetails();
//     await _localNotificationService.show(id, title, body, details,
//         payload: payload);
//   }

//   Future<void> cancelNotification(int id) async {
//     await _localNotificationService.cancel(id);
//   }

//   void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {
//     print('id $id');
//   }

//   void onSelectNotification(String? payload) {
//     print('payload $payload');
//     if (payload != null && payload.isNotEmpty) {
//       onNotificationClick.add(payload);
//     }
//   }
// }
