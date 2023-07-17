import 'package:eqms_test/firebase/firebase_api.dart';
import 'package:eqms_test/widget/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await FirebaseApi().initNotifications();
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
