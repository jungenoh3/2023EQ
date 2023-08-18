import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ServiceIntroduction extends StatefulWidget {
  const ServiceIntroduction({Key? key}) : super(key: key);

  @override
  _ServiceIntroductionState createState() => _ServiceIntroductionState();
}

class _ServiceIntroductionState extends State<ServiceIntroduction> {
  final List<String> images = [
    'images/Intro1.png',
    'images/Intro2.png',
    'images/Intro3.png',
    'images/Intro4.png',
    'images/Intro5.png',
    'images/Intro6.png',
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final primaryOrange = Color(0xFFFFA726);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('서비스 소개', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: CarouselSlider(
              items: images.map((item) => Image.asset(item, fit: BoxFit.fitWidth)).toList(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                height: double.infinity,
                aspectRatio: 16 / 9,
                viewportFraction: 1.2,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(images.length, (index) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: index == selectedIndex ? primaryOrange : Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image(
                      image: AssetImage('images/초연결융합기술연구소로고세로.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Image(
                      height: 100,
                      image: AssetImage('images/LOGO.png'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
