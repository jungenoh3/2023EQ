import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'RestClient.g.dart';

@RestApi(baseUrl: 'http://155.230.118.78:1234/EQMS')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/sensor-info/all')
  Future<List<SensorInfo>> getSensorInformation();

  @GET('/shelter/specific')
  Future<List<Shelter>> getShelter();

  @GET('/earthquake/specific')
  Future<List<EarthQuake>> getEarthQuakeRecent();

  @GET('/earthquake/all')
  Future<List<EarthQuake>> getEarthQuake();

  @GET('/emergency/specific')
  Future<List<EmergencyInst>> getEmergencyInst();
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


@JsonSerializable()
class Shelter {
  int id;
  String dtl_adres;
  double xcord;
  double ycord;

  Shelter({required this.id, required this.dtl_adres, required this.xcord, required this.ycord});

  factory Shelter.fromJson(Map<String, dynamic> json) => _$ShelterFromJson(json);
  Map<String, dynamic> toJson() => _$ShelterToJson(this);
}

@JsonSerializable()
class EarthQuake {
  int id;
  double magnitude;
  double latitude;
  double longitude;
  DateTime update_time;

  EarthQuake({required this.id, required this.magnitude, required this.latitude, required this.longitude, required this.update_time});

  factory EarthQuake.fromJson(Map<String, dynamic> json) => _$EarthQuakeFromJson(json);
  Map<String, dynamic> toJson() => _$EarthQuakeToJson(this);
}

@JsonSerializable()
class EmergencyInst {
  int id;
  String institution;
  double latitude;
  double longitude;

  EmergencyInst({required this.id, required this.institution, required this.latitude, required this.longitude});

  factory EmergencyInst.fromJson(Map<String, dynamic> json) => _$EmergencyInstFromJson(json);
  Map<String, dynamic> toJson() => _$EmergencyInstToJson(this);
}