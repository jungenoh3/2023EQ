import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message?.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message){
    if (message == null ) return;
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message?.data}');
  }

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  Future initLocalNotification() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
        settings,
        onDidReceiveNotificationResponse: (payload) {
          final message = RemoteMessage.fromMap(jsonDecode(payload.toString()));
          handleMessage(message);
        }
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
            // other properties...
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> checkFCMToken() async {
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: ${fCMToken}');
    final url = Uri.parse('http://155.230.118.78:1234/FCMToken/check');
    final http.Response response = await http.post(url, body: fCMToken);
    if (response.statusCode < 200 || response.statusCode > 400){
      print('error code: ${response.statusCode}');
      return;
    } else {
      if (response.body == "subscribe"){
        _firebaseMessaging.subscribeToTopic("EQMS"); // void여서 뭘 반환할 수가 없어...
        print("subscribed");
      }
    }
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    checkFCMToken();
    initPushNotifications();
  }

}