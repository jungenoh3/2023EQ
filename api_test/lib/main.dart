import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'apitest.dart';
import 'firebase_options.dart';
import 'api/firebase_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await FirebaseApi().initNotifications();


  runApp(const MyStatefulWidget());
}
