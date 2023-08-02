import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:eqms_test/GoogleMap/models/EnumGoogleMap.dart';
import 'package:eqms_test/GoogleMap/models/MapItems.dart';
import 'package:eqms_test/GoogleMap/widget/CustomScrollableSheet.dart';
import 'package:eqms_test/Widget/eq_info/CustomCategory.dart';
import 'package:eqms_test/GoogleMap/google_map.dart';
import 'package:eqms_test/Widget/eq_info/CustomFloatingButton.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EQ_Info extends StatefulWidget {
  const EQ_Info({super.key});

  @override
  State<EQ_Info> createState() => _EQ_InfoState();
}

class _EQ_InfoState extends State<EQ_Info> {
  List<Circle> circleItems = [];
  List<ClusterData> markerItems = [];

  @override
  void initState() {
    super.initState();
    print('EQ_Info initState');
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
          Google_Map(
            circleItems: context.watch<GoogleMapModel>().circleItems,
            markerItems: context.watch<GoogleMapModel>().markerItems,
            mode: GoogleMapMode.shelter,
          ),
          const CustomCategory(),
          CustomScrollableSheet(),
        ],
      ),
    );
  }
}
