import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
}

class FirebaseApi {

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final _notification = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await messaging.requestPermission();
    final fCMToken = await messaging.getToken();
    print('Token: $fCMToken');
   FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}