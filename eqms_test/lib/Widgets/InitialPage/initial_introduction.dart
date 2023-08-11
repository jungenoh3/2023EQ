import 'package:eqms_test/Widgets/EQInfo/EQInfo.dart';
import 'package:eqms_test/Widgets/RootScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../style/color_guide.dart';


class InitialIntroduction extends StatefulWidget {
  const InitialIntroduction({Key? key}) : super(key: key);

  @override
  _InitialIntroductionState createState() => _InitialIntroductionState();
}

class _InitialIntroductionState extends State<InitialIntroduction> {
  // Function to request notification permissions
  Future<void> savePermissionStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationPermission', status);

  }
  Future<void> saveAlarmStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAlarmenabled', status);

  }



  Future<void> requestNotificationPermission() async {
    await Permission.notification.request();
  }

  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    // 예시 이미지 리스트
    final List<String> images = [
      'images/image1.jpg',
      'images/image1.jpg',
      'images/image1.jpg',
      // add other image paths
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    itemBuilder: (context, index) {
                      final image = images[index % images.length];
                      return Image.asset(image, fit: BoxFit.cover);
                    },
                    itemCount: images.length,
                    onPageChanged: (index) {
                      selectedIndex.value = index % images.length;
                    },
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: selectedIndex,
                    builder: (context, value, child) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(images.length, (index) {
                            return Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: index == value
                                    ? primaryOrange
                                    : Colors.white,
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: primaryOrange,
                    shadowColor: Colors.transparent,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.7,
                      MediaQuery.of(context).size.height * 0.08,
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 1000),
                        child: RootScreen(),
                      ),
                    );
                  },
                  child: Text(
                    '시작하기',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final selectedIndex = ValueNotifier<int>(0);
