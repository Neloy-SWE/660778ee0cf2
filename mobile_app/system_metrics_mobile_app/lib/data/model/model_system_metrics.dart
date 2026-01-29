/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

import 'package:equatable/equatable.dart';

class ModelSystemMetrics extends Equatable {
  final String? deviceId;
  final String? deviceOs;
  final DateTime? timestamp;
  final int? thermalValue;
  final int? batteryLevel;
  final int? memoryUsage;
  final String? thermalStatus;

  const ModelSystemMetrics({
    this.deviceId,
    this.deviceOs,
    this.timestamp,
    this.thermalValue,
    this.batteryLevel,
    this.memoryUsage,
    this.thermalStatus,
  });

  factory ModelSystemMetrics.fromRawJson(String str) =>
      ModelSystemMetrics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelSystemMetrics.fromJson(Map<String, dynamic> json) =>
      ModelSystemMetrics(
        deviceId: json["DeviceId"],
        deviceOs: json["DeviceOS"],
        timestamp: json["Timestamp"] == null
            ? null
            : DateTime.parse(json["Timestamp"]),
        thermalValue: json["ThermalValue"],
        batteryLevel: json["BatteryLevel"],
        memoryUsage: json["MemoryUsage"],
      );

  Map<String, dynamic> toJson() => {
    "DeviceId": deviceId,
    "DeviceOS": deviceOs,
    "Timestamp": timestamp?.toIso8601String(),
    "ThermalValue": thermalValue,
    "BatteryLevel": batteryLevel,
    "MemoryUsage": memoryUsage,
  };

  @override
  List<Object?> get props => [
    deviceId,
    deviceOs,
    timestamp,
    thermalValue,
    batteryLevel,
    memoryUsage,
    thermalStatus,
  ];
}
