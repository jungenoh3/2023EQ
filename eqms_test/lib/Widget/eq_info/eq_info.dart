import 'package:eqms_test/Widget/google_map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class EQ_Info extends StatefulWidget {
  const EQ_Info({super.key});

  @override
  State<EQ_Info> createState() => _EQ_InfoState();
}

class _EQ_InfoState extends State<EQ_Info> {
  int mode = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 10, right: 20), // 임시 줄 맞추기
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActionChip(
              label: Text('지진 정보'),
              onPressed: () {
                setState(() {
                  if (mode != 0) mode = 0;
                });
              },
            ),
            ActionChip(
              label: Text('대피소 정보'),
              onPressed: () {
                setState(() {
                  if (mode != 1) mode = 1;
                });
              },
            ),
            ActionChip(
              label: Text('내진 설계'),
              onPressed: () {
                setState(() {
                  if (mode != 2) mode = 2;
                });
              },
            ),
          ],
        ),
      ),
      body: Google_Map(mode: mode,),
    );
  }
}