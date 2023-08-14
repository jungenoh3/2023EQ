import 'package:flutter/material.dart';
import '../CommonWidgets/segment.dart';
import '../../style/text_style.dart';
import '../../style/color_guide.dart';

class ServiceIntroduction extends StatelessWidget {
  const ServiceIntroduction({Key? key}) : super(key: key);

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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('서비스 소개', style: kAppBarTitleTextStyle),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  itemBuilder: (context, index) {
                    final image = images[index % images.length];
                    return Image.asset(image, fit: BoxFit.cover);
                  },
                  itemCount: null,
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
                              color:
                                  index == value ? primaryOrange : Colors.white,
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
          const SegmentH(size: 8),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image(
                          image: AssetImage('images/초연결융합기술연구소로고세로.png'),
                          fit: BoxFit.cover, // 이 부분이 이미지 크기를 조정합니다.
                        ),
                      ),
                      SizedBox(width: 20),
                      SegmentV(size: 100),
                      SizedBox(width: 20),
                      Expanded(
                        child: Image(
                          image: AssetImage('images/초연결융합기술연구소로고세로.png'),
                          fit: BoxFit.cover, // 이 부분이 이미지 크기를 조정합니다.
                        ),
                      ),
                    ],
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

// Create a ValueNotifier to hold the index of the selected image
final selectedIndex = ValueNotifier<int>(0);
