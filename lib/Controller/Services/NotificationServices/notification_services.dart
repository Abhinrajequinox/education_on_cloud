import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmTocken = await _firebaseMessaging.getToken();
    log(fcmTocken.toString());
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);
  }
  
}

Future<void> handleBackgroundMessages(RemoteMessage message) async {
  log(message.notification!.title.toString());
  log(message.notification!.body.toString());
  log(message.data.toString());

  
}
