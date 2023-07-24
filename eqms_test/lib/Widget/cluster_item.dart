// import 'dart:async';
// import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
//
//
// class GoogleMapCluster{
//   Set<Marker> markers = {};
//   late Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();
//   late ClusterManager clusterManager;
//   List<PlaceModel> placeList = [
//     PlaceModel(id:1, type: 1, name: "Example Place1", latLng: LatLng(38.417392, 127.163635)),
//     PlaceModel(id:2, type: 0, name: "Example Place2", latLng: LatLng(38.429227, 127.203803)),
//     PlaceModel(id:3, type: 1, name: "Example Place3", latLng: LatLng(38.444287, 127.187667)),
//     PlaceModel(id:4, type: 0, name: "Example Place4", latLng: LatLng(38.468483, 127.174278)),
//     PlaceModel(id:5, type: 1, name: "Example Place5", latLng: LatLng(38.447245, 127.250152)),
//     PlaceModel(id:6, type: 0, name: "Example Place6", latLng: LatLng(38.477622, 127.212043)),
//     PlaceModel(id:7, type: 1, name: "Example Place7", latLng: LatLng(38.446976, 127.230239)),
//     PlaceModel(id:8, type: 0, name: "Example Place8", latLng: LatLng(38.482191, 127.213416)),
//     PlaceModel(id:9, type: 1, name: "Example Place9", latLng: LatLng(38.449127, 127.201400)),
//     PlaceModel(id:10, type: 1, name: "Example Place10", latLng: LatLng(38.467946, 127.215476)),
//   ];
//
//   ClusterManager _initClusterManager(){
//     return ClusterManager<PlaceModel>(
//         placeList,
//         _updateMarkers,
//         markerBuilder: markerBuilder
//     );
//   }
//
//   void _updateMarkers(Set<Marker> markers) {
//     setState(() {
//       this.markers = markers;
//     });
//   }
//
//   static Future<Marker> Function(Cluster) get markerBuilder => (cluster) async {
//     return Marker(
//       markerId: MarkerId(cluster.isMultiple ? cluster.getId() : cluster.items.single.id.toString()),
//       position: cluster.location,
//       onTap: () {
//         print(cluster.items);
//       },
//       icon: await getClusterBitmap(cluster.isMultiple ? 125 : 75,
//           text: cluster.isMultiple? cluster.count.toString() : null),
//     );
//   };
//
//   static Future<BitmapDescriptor> getClusterBitmap(int size, {String text?}) async {
//     final PictureRecorder pictureRecorder = PictureRecorder();
//     final Canvas canvas = Canvas(pictureRecorder);
//     final Paint paint1 = Paint()..color = Colors.red;
//
//     canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
//
//     if (text != null) {
//       TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
//       painter.text = TextSpan(
//         text: text,
//         style: TextStyle(
//             fontSize: size / 3,
//             color: Colors.white,
//             fontWeight: FontWeight.normal),
//       );
//       painter.layout();
//       painter.paint(
//         canvas,
//         Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
//       );
//     }
//
//     final img = await pictureRecorder.endRecording().toImage(size, size);
//     final data = await img.toByteData(format: ImageByteFormat.png);
//
//     return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
//   }
//
//
//
// }
//
// class PlaceModel with ClusterItem {
//   int? id;
//   int? type;
//   String? name;
//   final LatLng latLng;
//
//   PlaceModel({required this.name, required this.latLng,required this.type,required this.id});
//   @override
//   LatLng get location => latLng;
// }