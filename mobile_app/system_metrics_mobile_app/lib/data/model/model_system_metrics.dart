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
        deviceId: json["deviceId"],
        deviceOs: json["deviceOS"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        thermalValue: json["thermalValue"],
        batteryLevel: json["batteryLevel"],
        memoryUsage: json["memoryUsage"],
      );

  Map<String, dynamic> toJson() => {
    "deviceId": deviceId,
    "deviceOS": deviceOs,
    "timestamp": timestamp?.toIso8601String(),
    "thermalValue": thermalValue,
    "batteryLevel": batteryLevel,
    "memoryUsage": memoryUsage,
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
