import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place with ClusterItem {
  final String id;
  final String address;
  final LatLng latLng;

  Place({required this.id, required this.address, required this.latLng});

  @override
  LatLng get location => latLng;
}