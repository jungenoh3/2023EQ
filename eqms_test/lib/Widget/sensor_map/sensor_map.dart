import 'package:eqms_test/Widget/google_map/google_map.dart';
import 'package:flutter/material.dart';

import 'package:eqms_test/Widget/google_map/models/GoogleMapMode.dart';

class Sensor_Map extends StatefulWidget {
  const Sensor_Map({super.key});

  @override
  State<Sensor_Map> createState() => _Sensor_MapState();
}

class _Sensor_MapState extends State<Sensor_Map> {


  @override
  Widget build(BuildContext context) {
    return const Google_Map(mode: GoogleMapMode.sensor);
  }

  @override
  void initState() {
    super.initState();
    print('Sensor_map initState');
  }
}