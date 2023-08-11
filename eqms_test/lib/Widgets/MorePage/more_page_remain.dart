import 'package:flutter/material.dart';
import '../ServiceAgree/service_use_promise.dart';
import '../ServiceAgree/privacy_policy.dart';
import '../../style/text_style.dart';
import './more_page_call.dart';

class MorePageRemain extends StatelessWidget {
  final bool isLoggedIn;
  const MorePageRemain({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int flexValue = isLoggedIn ? 4 : 5;

    return Expanded(
      flex: flexValue,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ServiceUsePromise(),
                                ),
                              );
                            },
                            child: Text('이용약관')),
                        SizedBox(width: 20),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrivacyPolicy(),
                                ),
                              );
                            },
                            child: Text('개인정보 처리방침'))
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Contact',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text('- 경북대학교 초연결융합기술연구소', style: kMorePageRemainTextStyle),
                    SizedBox(height: 5),
                    Text('- 웹사이트 주소', style: kMorePageRemainTextStyle),
                    Text('   https://connected.knu.ac.kr/',
                        style: kMorePageRemainTextStyle),
                    SizedBox(height: 5),
                    Text('- 이메일', style: kMorePageRemainTextStyle),
                    Text('   ywkwon@knu.ac.kr',
                        style: kMorePageRemainTextStyle),
                  ],
                )),
            Expanded(flex: 2, child: MorePageCall())
          ],
        ),
      ),
    );
  }
}
