import 'package:dio/dio.dart';
import 'package:eqms_test/Api/Retrofit/RestClient.dart';
import 'package:eqms_test/Widget/ScrollableSheetData.dart';
import 'package:eqms_test/Widget/google_map/models/MapItems.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapModel with ChangeNotifier {
  final dio = Dio();
  late RestClient client = RestClient(dio);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  List<Circle> _circleItems = [];
  List<ClusterData> _markerItems = [];
  List<ScrollableSheetData> _sheetItems = [];
  String _sheetTitle = "";
  String _bottomSheetTitle = "";

  List<Circle> get circleItems => _circleItems;
  List<ClusterData> get markerItems => _markerItems;
  List<ScrollableSheetData> get sheetItems => _sheetItems;
  String get sheetTitle => _sheetTitle;
  String get bottomSheetTitle => _bottomSheetTitle;

  void RemoveItems() {
    _circleItems.clear();
    _markerItems.clear();
    _sheetItems.clear();
    notifyListeners();
  }

  void EarthQuakeItems() async {
    _circleItems.clear();
    _markerItems.clear();
    _sheetItems.clear();
    try {
      List<EarthQuake> value = await client.getEarthQuake();
      if (value.isNotEmpty) {
        for (int i = 0; i < value.length; i++) {
          _sheetItems.add(ScrollableSheetData(
              id: value[i].id.toString(),
              description: value[i].magnitude.toString(),
              description2: null,
              description3: null));
        }
        _sheetItems.insert(
            0,
            ScrollableSheetData(
                id: "-",
                description: "-",
                description2: null,
                description3: null));
      }
      value.clear();
      value = await client.getEarthQuakeRecent();
      if (value.isNotEmpty) {
        for (int i = 0; i < value.length; i++) {
          _circleItems.add(Circle(
            circleId: CircleId(value[i].id.toString()),
            center: LatLng(value[i].latitude, value[i].longitude),
            fillColor: Colors.blue.withOpacity(0.5),
            radius: value[i].magnitude * 10000,
            strokeColor: Colors.blueAccent,
            strokeWidth: 1,
            onTap: () {
              // BottomSheets.showItemBottomSheet(navigatorKey.currentContext!, value[i].id.toString());
            },
            consumeTapEvents: true,
          ));
        }
      }
      _sheetTitle = "최근 발생 지진";
      _bottomSheetTitle = "해당 지진 정보";
    } catch (error) {
      // TODO
    }
    notifyListeners();
  }

  void ShelterItems() async {
    _circleItems.clear();
    _markerItems.clear();
    _sheetItems.clear();
    try {
      List<Shelter> value = await client.getShelter();
      if (value.isNotEmpty) {
        for (int i = 0; i < value.length; i++) {
          _markerItems.add(ClusterData(
            id: value[i].id.toString(),
            latLng: LatLng(value[i].ycord, value[i].xcord),
            address: value[i].dtl_adres,
            detail: null,
          ));
          _sheetItems.add(ScrollableSheetData(
              id: value[i].id.toString(),
              description: value[i].dtl_adres,
              description2: null,
              description3: null));
        }
        _sheetItems.insert(
            0,
            ScrollableSheetData(
                id: "-",
                description: "-",
                description2: null,
                description3: null));

        _sheetTitle = "내 주변 대피소";
        _bottomSheetTitle = "해당 대피소 정보";
      }
    } catch (error) {
      // TODO
    }
    notifyListeners();
  }

  void SensorItems() async {
    _circleItems.clear();
    _markerItems.clear();
    _sheetItems.clear();
    try {
      List<SensorInfo> value = await client.getSensorInformation();
      if (value.isNotEmpty) {
        for (int i = 0; i < value.length; i++) {
          _markerItems.add(ClusterData(
            id: value[i].id.toString(),
            latLng: LatLng(value[i].latitude, value[i].longitude),
            address: value[i].address,
            detail: null,
          ));
          _sheetItems.add(ScrollableSheetData(
              id: value[i].deviceid.toString(),
              description: value[i].address,
              description2: null,
              description3: null));
        }
        _sheetItems.insert(
            0,
            ScrollableSheetData(
                id: "-",
                description: "-",
                description2: null,
                description3: null));

        _sheetTitle = "센서";
        _bottomSheetTitle = "해당 센서 정보";
      }
    } catch (error) {
      // TODO
    }
    notifyListeners();
  }
}
