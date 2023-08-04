import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheets {
  static void showItemBottomSheet(BuildContext context, String? name, String location) {
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
                  topRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0,
                    spreadRadius: 0.0,
                    offset: Offset(0, -1),
                  )
                ]),
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 12, bottom: 2),
                  child: Text(
                    context.watch<GoogleMapModel>().bottomSheetTitle,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(color: Colors.grey[400], thickness: 1.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 2),
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    strutStyle: StrutStyle(fontSize: 15.0),
                    text: TextSpan(
                        text: name,
                        style: TextStyle(color: Colors.black,)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 2),
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    strutStyle: StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                      text: location,
                      style: TextStyle(color: Colors.black, fontSize: 13)
                    ),
                  ),
                ),
              ],
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
