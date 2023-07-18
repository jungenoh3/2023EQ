import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse('https://line.me/R/ti/p/%40336fgjcu');

    Future<void> _LineFriends() async {
      if (await canLaunchUrl(_url)) {
        await launchUrl(_url,
            mode: LaunchMode.platformDefault);
      }
      else {
        throw Exception('Could not launch $_url');
      }
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              ElevatedButton(
                  onPressed: _LineFriends,
                  child: Text('라인 친구 추가')),
          ],
        ),
      ),
    );
  }
}
