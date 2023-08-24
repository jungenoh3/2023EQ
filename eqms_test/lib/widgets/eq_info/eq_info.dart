import 'package:eqms_test/api/google_map_model.dart';
import 'package:eqms_test/custom_googlemap/custom_googlemap.dart';
import 'package:eqms_test/custom_googlemap/models/google_maps_models.dart';
import 'package:eqms_test/custom_googlemap/widgets/custom_scrollablesheet.dart';
import 'package:eqms_test/widgets/eq_info/widgets/custom_choicechips.dart';
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
