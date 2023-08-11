import 'package:flutter/material.dart';
import './toactinfobuttonnoani.dart';
import './toeqmapbutton.dart';
import '../CommonWidgets/segment.dart';
import '../../style/color_guide.dart';
import '../../style/text_style.dart';

class SeismicDesign extends StatefulWidget {
  const SeismicDesign({super.key});

  @override
  State<SeismicDesign> createState() => _SeismicDesignState();
}

class _SeismicDesignState extends State<SeismicDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('내진설계확인', style: kAppBarTitleTextStyle),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex:3,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Align(alignment: Alignment.centerLeft, child: Text('주소 검색', style: kSeismicTitleTextStyle,)),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    child: Row(
                        children: [
                      Expanded(
                        flex:8,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '주소를 정확하게 입력해주세요',
                            hintStyle: kHintTextStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Expanded(
                          flex:1,
                          child: Icon(Icons.search))
                    ]),
                  ),
                  SizedBox(height: 3),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text('주소가 정확히 입력되지 않았습니다.',style: kWarningTextStyle),
                  )
                ],
              ),
            ),
          ),
          SegmentH(size: 3),
          Expanded(
            flex:4,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('내진설계 여부', style: kSeismicTitleTextStyle),
                            SizedBox(height: 50),
                            Text('-')
                          ],
                        ),
                      ),
                      SegmentV(size: 100),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('내진능력', style: kSeismicTitleTextStyle),
                            SizedBox(height: 50),
                            Text('-')
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Text(
                      '내진 설계',
                      style: kSeismicDescriptionTextStyle,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex:3,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              color: lightGray1_5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: ToActInfoButtonNoAni()),
                  Expanded(child: ToEQMapButton())
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(height: 60, color: Colors.red),
    );
  }
}
