import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:eqms_test/GoogleMap/Models/google_maps_models.dart';
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
    print('EQInfo inistState');
    super.initState();
    final googleMapModel = context.read<GoogleMapModel>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      googleMapModel.RemoveItems();
    });
  }

  @override
  void deactivate() {
    print('EQInfo deactivate');
    final googleMapModel = context.read<GoogleMapModel>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      googleMapModel.RemoveItems();
    });
    super.deactivate();
  }

  @override
  void dispose() {
    print('EQInfo dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMapModelData = context.watch<GoogleMapModel>();

    return SafeArea(
      child: Stack(
        children: [
          CustomGoogleMap(
            circleItems: GoogleMapModelData.circleItems,
            markerItems: GoogleMapModelData.markerItems,
            mode: 0,
          ),
          const CustomCategory(),
          CustomScrollableSheet(), // scrollablesheet
        ],
      ),
    );
  }
}
