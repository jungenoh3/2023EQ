import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './seismic_design.dart';
import '../../style/text_style.dart';

class ToSeismicDesignButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SeismicDesign(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.fromLTRB(10, 30, 20, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 100,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10,
              bottom: -14,
              height: 110,
              width: 110,
              child: SvgPicture.asset(
                'assets/eqhouse.svg',
                fit: BoxFit.contain,
              ),
            ),
            const Positioned(
              left: 10,
              top: 10,
              child: Text('내진설계', style: kInfoTitleTextStyle),
            ),
            const Positioned(
              left: 12,
              top: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('주소 검색으로', style: kInfoDescriptionTextStyle),
                  Text('빠른 내진설계 확인', style: kInfoDescriptionTextStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
