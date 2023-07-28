import 'package:eqms_test/Widget/google_map/models/GoogleMapMode.dart';
import 'package:flutter/material.dart';

class BottomSheets {

  static void showMapBottomSheet(BuildContext context, GoogleMapMode mode, dynamic data){
  }

  static void showItemBottomSheet(BuildContext context, GoogleMapMode mode, String data){
    String title;

    switch (mode) {
      case GoogleMapMode.EQinfo:
        title = "해당 지진 정보";
        break;
      case GoogleMapMode.EQupdate:
        title = "해당 지진 정보";
        break;
      case GoogleMapMode.shelter:
        title = "해당 대피소 정보";
        break;
      case GoogleMapMode.sensor:
        title = "해당 센서 정보";
        break;
      default:
        title = "아직 없는 데이터";
        break;
    }

    showBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text("아이디: $data",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      backgroundColor: Colors.transparent,
      // barrierColor: Colors.transparent,
      // isScrollControlled: true,
      // useRootNavigator: true,
      // useSafeArea: true,
    );
  }
}