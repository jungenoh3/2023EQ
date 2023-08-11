import 'package:eqms_test/Widgets/EQInfo/EQInfo.dart';
import 'package:eqms_test/Widgets/RootScreen.dart';
import 'package:flutter/material.dart';
import './initial_introduction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isFirstTime;
  @override
  void initState() {
    super.initState();
    navigateAfterSplash();
  }
  Future<void> setFirstTimeFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_time', false);
  }

  Future<void> navigateAfterSplash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('first_time') ?? true;

    Timer(
      const Duration(milliseconds: 2000),
          () async {
        if (isFirstTime) {
          await setFirstTimeFalse();  // 여기에서 첫번째 실행이 아니라는 것을 저장합니다.

          Navigator.pushReplacement(context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 1000),
                child: InitialIntroduction(),
              ));
          print('first_time');
        } else {
          Navigator.pushReplacement(context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 1000),
                child: RootScreen(),
              ));
        }
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    const String imageLogoName = 'images/초연결융합기술연구소로고세로.png';
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.384375),
                Container(
                  child: Image.asset(
                    imageLogoName,
                    width: screenWidth * 0.616666,
                    height: screenHeight * 0.0859375,
                  ),
                ),
                Expanded(child: SizedBox()),
                Align(
                  child: Text(
                    "© Copyright 2023, 초연결융합기술연구소",
                    style: TextStyle(
                      fontSize: screenWidth * (14 / 360),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0625,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
