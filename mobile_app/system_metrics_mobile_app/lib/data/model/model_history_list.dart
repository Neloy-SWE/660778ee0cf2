/* 
Created by Neloy on 30 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

import 'package:equatable/equatable.dart';

class ModelHistoryList extends Equatable {
  final List<History>? items;
  final int? totalCount;
  final int? pageNumber;
  final int? pageSize;

  const ModelHistoryList({
    this.items,
    this.totalCount,
    this.pageNumber,
    this.pageSize,
  });

  factory ModelHistoryList.fromRawJson(String str) =>
      ModelHistoryList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelHistoryList.fromJson(Map<String, dynamic> json) =>
      ModelHistoryList(
        items: json["items"] == null
            ? []
            : List<History>.from(
                json["items"]!.map((x) => History.fromJson(x)),
              ),
        totalCount: json["totalCount"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "totalCount": totalCount,
    "pageNumber": pageNumber,
    "pageSize": pageSize,
  };

  @override
  List<Object?> get props => [items, totalCount, pageNumber, pageSize];
}

class History extends Equatable {
  final int? id;
  final String? deviceId;
  final String? deviceOs;
  final DateTime? timestamp;
  final int? thermalValue;
  final int? batteryLevel;
  final int? memoryUsage;
  final DateTime? createdAt;

  const History({
    this.id,
    this.deviceId,
    this.deviceOs,
    this.timestamp,
    this.thermalValue,
    this.batteryLevel,
    this.memoryUsage,
    this.createdAt,
  });

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json["id"],
    deviceId: json["deviceId"],
    deviceOs: json["deviceOS"],
    timestamp: json["timestamp"] == null
        ? null
        : DateTime.parse(json["timestamp"]),
    thermalValue: json["thermalValue"],
    batteryLevel: json["batteryLevel"],
    memoryUsage: json["memoryUsage"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "deviceId": deviceId,
    "deviceOS": deviceOs,
    "timestamp": timestamp?.toIso8601String(),
    "thermalValue": thermalValue,
    "batteryLevel": batteryLevel,
    "memoryUsage": memoryUsage,
    "createdAt": createdAt?.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    id,
    deviceId,
    deviceOs,
    timestamp,
    thermalValue,
    batteryLevel,
    memoryUsage,
    createdAt,
  ];
}
