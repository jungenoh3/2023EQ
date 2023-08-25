import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'http://155.230.118.78:1234/EQMS')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/user/register')
  Future<String> postUserInfo(@Queries() Map<String, String> registerData);

  @GET('/user/login')
  Future<String> getRegisterInfo(@Queries() Map<String, String> loginData);


  @GET('/sensor/count')
  Future<SensorCount> getSensorCount();

  @GET('/sensor-info/all')
  Future<List<SensorInfo>> getSensorInformation();

  @GET('/sensor-info/region')
  Future<List<String>> getSensorInfoRegion();

  @GET('/sensor-info/facility')
  Future<List<String>> getSensorInfoFacility();

  @GET('/sensor-info/search')
  Future<List<SensorInfo>> getSensorSearch(@Queries() Map<String, String> queries);


  @GET('/sensor-abnormal/region')
  Future<List<String>> getSensorAbnormalRegion();

  @GET('/sensor-abnormal/facility')
  Future<List<String>> getSensorAbnormalFacility();

  @GET('/sensor-abnormal/search')
  Future<List<SensorAbnormal>> getSensorAbnormalSearch(@Queries() Map<String, String> queries);


  @GET('/shelter/specific')
  Future<List<Shelter>> getShelter();


  @GET('/earthquake/ongoing')
  Future<List<EarthQuake>> getEarthQuakeOngoing();

  @GET('/earthquake/all')
  Future<List<EarthQuake>> getEarthQuake();

  @GET('/emergency/specific')
  Future<List<EmergencyInst>> getEmergencyInst();
}

@JsonSerializable()
class User {
  String name;
  String identification;
  String password;
  String phoneNumber;
  String email;

  User({required this.name, required this.identification, required this.password, required this.phoneNumber, required this.email});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class SensorCount {
  int abnormal_sensor;
  int all_sensor;

  SensorCount({required this.abnormal_sensor, required this.all_sensor});
  factory SensorCount.fromJson(Map<String, dynamic> json) => _$SensorCountFromJson(json);
  Map<String, dynamic> toJson() => _$SensorCountToJson(this);
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
  String? etc;
  String region;

  SensorInfo({required this.id, required this.deviceid, required this.latitude, required this.longitude,
    required this.address, required this.manu_comp, this.facility, required this.level, required this.etc, required this.region});

  factory SensorInfo.fromJson(Map<String, dynamic> json) => _$SensorInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SensorInfoToJson(this);
}

@JsonSerializable()
class SensorAbnormal {
  int id;
  String deviceid;
  String? accelerator;
  String? pressure;
  String? temperature;
  String? noise_class;
  String? fault_message;
  String address;
  String region;

  SensorAbnormal({required this.id, required this.deviceid, required this.accelerator, required this.pressure,
    required this.temperature, required this.noise_class, this.fault_message, required this.address, required this.region});

  factory SensorAbnormal.fromJson(Map<String, dynamic> json) => _$SensorAbnormalFromJson(json);
  Map<String, dynamic> toJson() => _$SensorAbnormalToJson(this);
}

@JsonSerializable()
class Shelter {
  int id;
  String vt_acmdfclty_nm;
  String dtl_adres;
  double xcord;
  double ycord;

  Shelter({required this.id, required this.vt_acmdfclty_nm, required this.dtl_adres, required this.xcord, required this.ycord});

  factory Shelter.fromJson(Map<String, dynamic> json) => _$ShelterFromJson(json);
  Map<String, dynamic> toJson() => _$ShelterToJson(this);
}

@JsonSerializable()
class EarthQuake {
  int id;
  int assoc_id;
  double lat;
  double lng;
  DateTime update_time;

  EarthQuake({required this.id, required this.assoc_id, required this.lat, required this.lng, required this.update_time});

  factory EarthQuake.fromJson(Map<String, dynamic> json) => _$EarthQuakeFromJson(json);
  Map<String, dynamic> toJson() => _$EarthQuakeToJson(this);
}

@JsonSerializable()
class EmergencyInst {
  int id;
  String institution;
  String address;
  String med_category;
  double latitude;
  double longitude;

  EmergencyInst({required this.id, required this.institution, required this.address, required this.med_category, required this.latitude, required this.longitude});

  factory EmergencyInst.fromJson(Map<String, dynamic> json) => _$EmergencyInstFromJson(json);
  Map<String, dynamic> toJson() => _$EmergencyInstToJson(this);
}