import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:eqms_test/GoogleMap/Models/MapItems.dart';
import 'package:eqms_test/GoogleMap/Widget/custom_scrollablesheet.dart';
import 'package:eqms_test/Widgets/EQInfo/CustomCategory.dart';
import 'package:eqms_test/GoogleMap/custom_googlemap.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EQInfo extends StatefulWidget {
  const EQInfo({super.key});

  @override
  State<EQInfo> createState() => _EQInfoState();
}

class _EQInfoState extends State<EQInfo> {
  List<Circle> circleItems = [];
  List<ClusterData> markerItems = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    final googleMapModel = context.read<GoogleMapModel>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      googleMapModel.RemoveItems();
    });
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          CustomGoogleMap( // in google map build call CustomFloatingButton for FAB
            circleItems: context.watch<GoogleMapModel>().circleItems,
            markerItems: context.watch<GoogleMapModel>().markerItems,
            mode: 0,
          ),
          const CustomCategory(),
          CustomScrollableSheet(), // scrollablesheet
        ],
      ),
    );
  }
}
