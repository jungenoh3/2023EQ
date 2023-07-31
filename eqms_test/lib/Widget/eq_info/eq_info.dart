import 'package:eqms_test/Widget/eq_info/CategoryChip.dart';
import 'package:eqms_test/Widget/google_map/models/EnumGoogleMap.dart';
import 'package:eqms_test/Widget/google_map/google_map.dart';
import 'package:eqms_test/Widget/google_map/models/MapItems.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Google_Map(
                circleItems: circleItems,
                markerItems: markerItems,
                mode: GoogleMapMode.shelter,
            ),
            const CustomCategory(),
          ],
        ),
      )
    );
  }
}


