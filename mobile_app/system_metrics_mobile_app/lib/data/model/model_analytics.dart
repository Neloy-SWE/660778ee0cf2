/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

import 'package:equatable/equatable.dart';

class ModelAnalytics extends Equatable {
  final String? title;
  final double? average;
  final int? minimum;
  final int? maximum;

  const ModelAnalytics({this.title, this.average, this.minimum, this.maximum});

  factory ModelAnalytics.fromRawJson(String str) =>
      ModelAnalytics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelAnalytics.fromJson(Map<String, dynamic> json) => ModelAnalytics(
    title: json["title"],
    average: json["average"]?.toDouble(),
    minimum: json["minimum"],
    maximum: json["maximum"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "average": average,
    "minimum": minimum,
    "maximum": maximum,
  };

  @override
  List<Object?> get props => [title, average, minimum, maximum];
}
