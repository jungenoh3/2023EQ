import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClusterData with ClusterItem {
  final String id;
  final LatLng latLng;
  final String address;
  String? detail;

  ClusterData({required this.id, required this.latLng, required this.address, required this.detail});

  @override
  LatLng get location => latLng;
}