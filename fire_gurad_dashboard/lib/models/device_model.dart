// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fire_gurad_dashboard/models/address_model.dart';
import 'package:fire_gurad_dashboard/models/forest_model.dart';

class DeviceModel {
  final AddressModel? address;
  final ForestModel? forest;
  final int? id;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  DeviceModel({
    this.address,
    this.forest,
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  DeviceModel copyWith({
    AddressModel? address,
    ForestModel? forest,
    int? id,
    String? name,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return DeviceModel(
      address: address ?? this.address,
      forest: forest ?? this.forest,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address?.toMap(),
      'forest': forest?.toMap(),
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      address: map['address'] != null
          ? AddressModel.fromMap(map['address'] as Map<String, dynamic>)
          : null,
      forest: map['forest'] != null
          ? ForestModel.fromMap(map['forest'] as Map<String, dynamic>)
          : null,
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceModel.fromJson(String source) =>
      DeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Device(address: $address, forest: $forest, id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant DeviceModel other) {
    if (identical(this, other)) return true;

    return other.address == address &&
        other.forest == forest &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        forest.hashCode ^
        id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
