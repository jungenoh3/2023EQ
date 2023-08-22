import 'package:eqms_test/Api/DraggableSheetModel.dart';
import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:eqms_test/GoogleMap/custom_googlemap.dart';
import 'package:eqms_test/GoogleMap/widget/custom_scrollablesheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SensorMap extends StatefulWidget {
  const SensorMap({super.key});

  @override
  State<SensorMap> createState() => _SensorMapState();
}

class _SensorMapState extends State<SensorMap> {

  @override
  void initState() {
    print('Sensor_map initState');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try {
        context.read<GoogleMapModel>().SensorItems();
        context.read<DraggableSheetModel>().getDraggableSheetHeight(0.11);
      } catch (e) {
        print('Error occurred: $e');
      }
    });
  }


  @override
  void deactivate() {
    print('Sensor_map deactivate');
    final googleMapModel = context.read<GoogleMapModel>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      googleMapModel.RemoveItems();
    });
    super.deactivate();
  }

  @override
  void dispose() {
    print("Sensor_map dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
          children: [
            CustomGoogleMap(
                mode: 1,
                circleItems: context.watch<GoogleMapModel>().circleItems,
                markerItems: context.watch<GoogleMapModel>().markerItems
            ),
            CustomScrollableSheet(),
          ],
        ),
      );
  }
}
