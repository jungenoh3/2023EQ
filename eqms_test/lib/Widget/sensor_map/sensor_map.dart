import 'package:eqms_test/Api/DraggableSheetModel.dart';
import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:eqms_test/GoogleMap/google_map.dart';
import 'package:eqms_test/GoogleMap/widget/CustomScrollableSheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sensor_Map extends StatefulWidget {
  const Sensor_Map({super.key});

  @override
  State<Sensor_Map> createState() => _Sensor_MapState();
}

class _Sensor_MapState extends State<Sensor_Map> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<GoogleMapModel>().SensorItems();
      context.read<DraggableSheetModel>().getDraggableSheetHeight(0.11);
    });
    print('Sensor_map initState');
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
    print("Sensor_map dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
          children: [
            Google_Map(
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
