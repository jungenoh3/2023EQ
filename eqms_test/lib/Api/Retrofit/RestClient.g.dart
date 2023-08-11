// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RestClient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorInfo _$SensorInfoFromJson(Map<String, dynamic> json) => SensorInfo(
      id: json['id'] as int,
      deviceid: json['deviceid'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      manu_comp: json['manu_comp'] as String,
      facility: json['facility'] as String?,
      level: json['level'] as String,
      etc: json['etc'] as String?,
      region: json['region'] as String,
    );

Map<String, dynamic> _$SensorInfoToJson(SensorInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceid': instance.deviceid,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'manu_comp': instance.manu_comp,
      'facility': instance.facility,
      'level': instance.level,
      'etc': instance.etc,
      'region': instance.region,
    };

SensorAbnormal _$SensorAbnormalFromJson(Map<String, dynamic> json) =>
    SensorAbnormal(
      id: json['id'] as int,
      deviceid: json['deviceid'] as String,
      accelerator: json['accelerator'] as String?,
      pressure: json['pressure'] as String?,
      temperature: json['temperature'] as String?,
      noise_class: json['noise_class'] as String?,
      fault_message: json['fault_message'] as String?,
      address: json['address'] as String,
      region: json['region'] as String,
    );

Map<String, dynamic> _$SensorAbnormalToJson(SensorAbnormal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceid': instance.deviceid,
      'accelerator': instance.accelerator,
      'pressure': instance.pressure,
      'temperature': instance.temperature,
      'noise_class': instance.noise_class,
      'fault_message': instance.fault_message,
      'address': instance.address,
      'region': instance.region,
    };

Shelter _$ShelterFromJson(Map<String, dynamic> json) => Shelter(
      id: json['id'] as int,
      vt_acmdfclty_nm: json['vt_acmdfclty_nm'] as String,
      dtl_adres: json['dtl_adres'] as String,
      xcord: (json['xcord'] as num).toDouble(),
      ycord: (json['ycord'] as num).toDouble(),
    );

Map<String, dynamic> _$ShelterToJson(Shelter instance) => <String, dynamic>{
      'id': instance.id,
      'vt_acmdfclty_nm': instance.vt_acmdfclty_nm,
      'dtl_adres': instance.dtl_adres,
      'xcord': instance.xcord,
      'ycord': instance.ycord,
    };

EarthQuake _$EarthQuakeFromJson(Map<String, dynamic> json) => EarthQuake(
      id: json['id'] as int,
      assoc_id: json['assoc_id'] as int,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      update_time: DateTime.parse(json['update_time'] as String),
    );

Map<String, dynamic> _$EarthQuakeToJson(EarthQuake instance) =>
    <String, dynamic>{
      'id': instance.id,
      'assoc_id': instance.assoc_id,
      'lat': instance.lat,
      'lng': instance.lng,
      'update_time': instance.update_time.toIso8601String(),
    };

EmergencyInst _$EmergencyInstFromJson(Map<String, dynamic> json) =>
    EmergencyInst(
      id: json['id'] as int,
      institution: json['institution'] as String,
      address: json['address'] as String,
      med_category: json['med_category'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$EmergencyInstToJson(EmergencyInst instance) =>
    <String, dynamic>{
      'id': instance.id,
      'institution': instance.institution,
      'address': instance.address,
      'med_category': instance.med_category,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://172.20.10.5:1234/EQMS';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<SensorInfo>> getSensorInformation() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<SensorInfo>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/sensor-info/all',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => SensorInfo.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<SensorInfo>> getSensorSearch(Map<String, String> queries) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<SensorInfo>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/sensor-info/search',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => SensorInfo.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<SensorAbnormal>> getSensorAbnormalSearch(
      Map<String, String> queries) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<SensorAbnormal>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/sensor-abnormal/search',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => SensorAbnormal.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Shelter>> getShelter() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<Shelter>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/shelter/specific',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => Shelter.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<EarthQuake>> getEarthQuakeOngoing() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<EarthQuake>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/earthquake/ongoing',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => EarthQuake.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<EarthQuake>> getEarthQuake() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<EarthQuake>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/earthquake/all',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => EarthQuake.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<EmergencyInst>> getEmergencyInst() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<EmergencyInst>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/emergency/specific',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => EmergencyInst.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
