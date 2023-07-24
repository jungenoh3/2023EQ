import 'package:eqms_test/Widget/google_map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class EQ_Info extends StatefulWidget {
  const EQ_Info({super.key});

  @override
  State<EQ_Info> createState() => _EQ_InfoState();
}

class _EQ_InfoState extends State<EQ_Info> {
  @override
  Widget build(BuildContext context) {
    return const Google_Map(mode: 1,);
  }
}