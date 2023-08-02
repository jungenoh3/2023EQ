import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheets {
  static void showItemBottomSheet(BuildContext context, String data){
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
                    Text(context.watch<GoogleMapModel>().bottomSheetTitle,
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