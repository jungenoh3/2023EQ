import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Google_Map extends StatefulWidget {
  const Google_Map({super.key});

  @override
  State<Google_Map> createState() => _Google_MapState();
}

class _Google_MapState extends State<Google_Map> {
  // latitude - 위도, longitude - 경도
  static final LatLng companyLatLng = LatLng(
      35.8881525,
      128.6109335
  );
  static final CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );

  static final Circle circle = Circle(
    circleId: CircleId('circle'),
    center: companyLatLng,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: 100,
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );
  static final Marker marker = Marker(
    markerId: MarkerId('marker'),
    position: companyLatLng,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkPermission(), // 상태가 변경될때마다 재빌드
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.data == '위치 권한이 허가되었습니다.'){
            return Column(
              children: [
                _CustomGoogleMap(
                    initialPosition: initialPosition,
                    circle: circle,
                    marker: marker,
                ),
              ],
            );
          }

          return Center(
            child: Text(snapshot.data),
          );
        },
      ),
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
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;

  const _CustomGoogleMap({
    required this.initialPosition,
    required this.circle,
    required this.marker,

    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        circles: Set.from([circle]),
        markers: Set.from([marker]),
      ),
    );
  }
}

