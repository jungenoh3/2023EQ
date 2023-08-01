import 'package:eqms_test/Api/GoogleMapModel.dart';
import 'package:eqms_test/Widget/CustomScrollableSheet.dart';
import 'package:eqms_test/Widget/google_map/google_map.dart';
import 'package:flutter/material.dart';
import 'package:eqms_test/Widget/google_map/models/EnumGoogleMap.dart';
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
    context.read<GoogleMapModel>().SensorItems();
    print('Sensor_map initState');
  }

  @override
  void dispose() {
    print("Sensor_map dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Google_Map(
                mode: GoogleMapMode.sensor,
                circleItems: context.watch<GoogleMapModel>().circleItems,
                markerItems: context.watch<GoogleMapModel>().markerItems),
            CustomScrollableSheet(),
          ],
        ),
      ),
    );
  }

}
