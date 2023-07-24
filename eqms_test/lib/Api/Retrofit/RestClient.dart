import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'RestClient.g.dart';

@RestApi(baseUrl: 'http://155.230.118.78:1234')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/sensor-info/all')
  Future<List<SensorInfo>> getSensorInformation();
}

@JsonSerializable()
class SensorInfo {
  int id;
  String deviceid;
  double latitude;
  double longitude;
  String address;
  String manu_comp;
  String? facility;
  String level;

  SensorInfo({required this.id, required this.deviceid, required this.latitude, required this.longitude,
    required this.address, required this.manu_comp, this.facility, required this.level});

  factory SensorInfo.fromJson(Map<String, dynamic> json) => _$SensorInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SensorInfoToJson(this);
}