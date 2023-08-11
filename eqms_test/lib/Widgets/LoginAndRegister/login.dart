import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../style/text_style.dart';
import '../../style/color_guide.dart';

class Login extends StatelessWidget {
  final String
      nextRoute; // The next route to navigate to after a successful login.

  const Login({Key? key, required this.nextRoute}) : super(key: key);
  // TODO: 로그인 아이디 비번 관련 validation(아예 입력하지 않은 경우)
  void _loginAction(BuildContext context) async {
    // TODO: 로그인 관련 유저정보 검증 및 확인 실시
    // Simulating a successful login for demonstration purposes.
    bool isLoggedIn = true;

    if (isLoggedIn) {
      // If the login is successful, save the login state to local storage.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);

      // Navigate to the specified next route.
      Navigator.pushReplacementNamed(context, nextRoute);
    } else {
      // Handle the case when login fails (optional).
      // You can show an error message or perform other actions here.
    } // TODO: 상황에 맞는 실패 메시지 안내
  }

  @override
  Widget build(BuildContext context) {
    // Check the login state during app startup.
    // If isLoggedIn is true, navigate to the specified next route directly.
    _checkLoginState(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('로그인', style: kAppBarTitleTextStyle),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('LOGIN',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('센서지도 및 센서현황 서비스 사용에는 로그인이 필요합니다.',
                style: kMorePageRemainTextStyle),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: '아이디',
                  hintStyle: kHintTextStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  hintStyle: kHintTextStyle,
                  border: InputBorder.none,
                ),
                obscureText: true, // Hide the password text
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryOrange),
                  elevation: MaterialStateProperty.all<double>(0),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(
                      double.infinity,
                      50)), // Width will be as wide as possible within the container
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          horizontal: 5)), // Horizontal padding
                ),
                onPressed: () => _loginAction(context),
                child: const Text('로그인', style: kButtonTextStyle),
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
                style: const ButtonStyle(
                    foregroundColor:
                        MaterialStatePropertyAll<Color>(primaryOrange)),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/registeragree');
                },
                child: const Text('관리자 계정생성'))
          ],
        ),
      ),
    );
  }

  // Check the login state during app startup.
  void _checkLoginState(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // If the user is logged in, navigate to the specified next route directly.
      Navigator.pushReplacementNamed(context, nextRoute);
    }
  }
}
