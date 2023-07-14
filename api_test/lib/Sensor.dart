import 'package:flutter/material.dart';

class Sensor {
  final int id;
  final String deviceId;
  final double latitude;
  final double longitude;

  Sensor({
    required this.id,
    required this.deviceId,
    required this.latitude,
    required this.longitude});

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
        id: json['id'] as int,
        deviceId: json['deviceid'] as String,
        latitude: json['longitude'] as double,
        longitude: json['longitude'] as double,
    );
  }
}