// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fire_gurad_dashboard/models/device_model.dart';
import 'package:fire_gurad_dashboard/models/forest_model.dart';
import 'package:fire_gurad_dashboard/models/status_model.dart';

// fire_model.dart
class FireModel {
  final int? id;
  final StatusModel? status;
  final ForestModel? forest;
  final String? updatedAt;
  final String? createdAt;
  final DeviceModel? device;
  FireModel({
    this.id,
    this.status,
    this.forest,
    this.updatedAt,
    this.createdAt,
    this.device,
  });

  FireModel copyWith({
    int? id,
    StatusModel? status,
    ForestModel? forest,
    String? updatedAt,
    String? createdAt,
    DeviceModel? device,
  }) {
    return FireModel(
      id: id ?? this.id,
      status: status ?? this.status,
      forest: forest ?? this.forest,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      device: device ?? this.device,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status?.toMap(),
      'forest': forest?.toMap(),
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'device': device?.toMap(),
    };
  }

  factory FireModel.fromMap(Map<String, dynamic> map) {
    return FireModel(
      id: map['id'] != null ? map['id'] as int : null,
      status: map['status'] != null
          ? StatusModel.fromMap(map['status'] as Map<String, dynamic>)
          : null,
      forest: map['forest'] != null
          ? ForestModel.fromMap(map['forest'] as Map<String, dynamic>)
          : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      device: map['device'] != null
          ? DeviceModel.fromMap(map['device'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FireModel.fromJson(String source) =>
      FireModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FireModel(id: $id, status: $status, forest: $forest, updatedAt: $updatedAt, createdAt: $createdAt, device: $device)';
  }

  @override
  bool operator ==(covariant FireModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.status == status &&
        other.forest == forest &&
        other.updatedAt == updatedAt &&
        other.createdAt == createdAt &&
        other.device == device;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        forest.hashCode ^
        updatedAt.hashCode ^
        createdAt.hashCode ^
        device.hashCode;
  }
}
