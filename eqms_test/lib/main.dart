import 'package:eqms_test/api/firebase_message.dart';
import 'package:eqms_test/api/firebase_realtimeDB.dart';
import 'package:eqms_test/widget/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'Api/SSE_api.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await FirebaseMessageApi().initNotifications();
  getData();
  // FirebaseRealtimeDBApi().readRealTimeDB();

  // android 환경의 java.lang.NullPointerException 오류 해결
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
    mapsImplementation.initializeWithRenderer(AndroidMapRenderer.latest);
  }

  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
