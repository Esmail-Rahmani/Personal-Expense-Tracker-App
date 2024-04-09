
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
    await _plugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(
      {required String title, required String body, required DateTime scheduledTime}) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'expense_reminder_channel', 'Expense Reminder',
        importance: Importance.high, priority: Priority.high,
        ticker: 'Expense Reminder');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails,);
    final Location defaultLocation = getLocation('Asia/Calcutta');

    final scheduledTZDateTime = TZDateTime.from(scheduledTime.toLocal(),defaultLocation);
    final now = TZDateTime.now(defaultLocation);

    print("current time $now");
    await _plugin.zonedSchedule(
        0, title, body, scheduledTZDateTime , notificationDetails,
        androidAllowWhileIdle: true, uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime);
  }
}