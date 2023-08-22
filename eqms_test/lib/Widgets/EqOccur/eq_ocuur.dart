import 'package:eqms_test/style/color_guide.dart';
import 'package:eqms_test/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EqOccur extends StatefulWidget {
  const EqOccur({Key? key}) : super(key: key);

  @override
  State<EqOccur> createState() => _EqOccurState();
}

class _EqOccurState extends State<EqOccur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryOrange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset('assets/Warning.svg', fit: BoxFit.fill),
                const SizedBox(height: 10),
                const Text(
                  '2023년 8월 22일 (화) 13:39',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                RichText(
                  text: const TextSpan(
                    style: kEqOccurTextStyle,
                    children: <TextSpan>[
                      TextSpan(text: '추정 규모 '),
                      TextSpan(
                        text: '5.4',
                        style: kEqOccurMagnituteTextStyle,
                      ),
                    ],
                  ),
                ),
                const Text(
                  '지진 발생!',
                  style: kEqOccurTextStyle,
                ),
                const Text(
                  '대구 북구 대학로 80길 15KM',
                  style: kEqOccurLocationTextStyle,
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset('images/Drop.png'),
                      Text('숙이고')
                    ],
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
                      onPressed: () {},
                      child: const Text('지진 안전 정보', style: kButtonTextStyle),
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
