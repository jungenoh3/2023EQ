import 'dart:async';
import 'dart:ui';
import 'package:eqms_test/Widget/google_map/widget/bottomsheets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'models/EnumGoogleMap.dart';
import 'models/MapItems.dart';

class Google_Map extends StatefulWidget {
  final GoogleMapMode mode;
  final List<Circle> circleItems;
  final List<ClusterData> markerItems;

  const Google_Map({
    required this.mode,
    required this.circleItems,
    required this.markerItems,
    Key? key}) : super(key: key);

  @override
  State<Google_Map> createState() => Google_MapState();
}

class Google_MapState extends State<Google_Map> {
  late ClusterManager _manager;
  Completer<GoogleMapController> _controller = Completer();
  bool _isPermissionGranted = false;
  Set<Marker> markers = Set();
  Set<Circle> circles = Set();

  final CameraPosition _CameraPosition =
  CameraPosition(target: LatLng(35.8881525, 128.6109335), zoom: 6.5);

  @override
  void initState() {
    super.initState();
    print('google_map initState');
    checkPermission().then((value){
      setState(() {
        if(value == '위치 권한이 허가되었습니다.'){
          _isPermissionGranted = true;
        }
      });
    });
    _manager = _initClusterManager();
    _updateClusterData();
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<ClusterData>(
        widget.markerItems,
        _updateMarkers,
        markerBuilder: _markerBuilder,
        levels: [1, 3, 6.8, 9, 11, 13, 15, 17, 19, 20],
    );
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  @override
  void didUpdateWidget(covariant Google_Map oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateClusterData();
  }

  void _updateClusterData(){
    circles.clear();
    markers.clear();
    _manager.setItems(widget.markerItems);
    circles = Set.from(widget.circleItems);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('google_map build');
    return _isPermissionGranted ? buildGoogleMap() : buildPermissionDenied();
  }

  Widget buildGoogleMap(){
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _CameraPosition,
        markers: markers,
        circles: circles,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _manager.setMapId(controller.mapId);
        },
        onCameraMove: _manager.onCameraMove,
        onCameraIdle: _manager.updateMap,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
          ),
        },
    );
  }

  Widget buildPermissionDenied() {
    return Center(
      child: Text('위치 서비스를 활성화 해주세요.'),
    );
  }

  Future<String> checkPermission() async {
    // GPS 켜져있는지
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isLocationEnabled){
      return '위치 서비스를 활성화 해주세요.';
    }
    // GPS 권한이 있는지
    LocationPermission checkPermission = await Geolocator.checkPermission();

    if(checkPermission == LocationPermission.denied){
      checkPermission = await Geolocator.requestPermission();
      if(checkPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }
    if(checkPermission == LocationPermission.deniedForever){
      return '위치 권한을 세팅에서 허가해주세요.';
    }
    return '위치 권한이 허가되었습니다.';
  }

  Future<Marker> Function(Cluster<ClusterData>) get _markerBuilder =>
          (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            if (!cluster.isMultiple){
              BottomSheets.showItemBottomSheet(
                  context,
                  widget.mode,
                  cluster.items.single.id.toString());
            }
            print('---- $cluster');
            cluster.items.forEach((p) => print(p));
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
            text: cluster.isMultiple ? cluster.count.toString() : null),
          // 마지막 마커 png로 표시 - 추후에 이미지 변경
          // cluster.isMultiple ? await _getMarkerBitmap(125,
          //     text: cluster.count.toString())
          //     : await bitmapDescriptorFromImgAsset(context, "assets/maps-and-flags.png", 100),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1); // 테두리 원
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2); // 흰 테두리
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1); // 제일 안에 있는 원

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  Future<BitmapDescriptor> bitmapDescriptorFromImgAsset(
      BuildContext context,
      String assetName,
      int size,
      ) async {
    ByteData data = await rootBundle.load(assetName);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: size);
    ui.FrameInfo fi = await codec.getNextFrame();
    ByteData? bytes = await fi.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

}