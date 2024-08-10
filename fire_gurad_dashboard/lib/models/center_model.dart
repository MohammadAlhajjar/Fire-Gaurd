// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fire_gurad_dashboard/models/address_model.dart';

class CenterModel {
  final AddressModel? address;
  final int? id;
  final String? name;
  final String? description;
  final String? phoneNumber;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  CenterModel({
    this.address,
    this.id,
    this.name,
    this.description,
    this.phoneNumber,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  CenterModel copyWith({
    AddressModel? address,
    int? id,
    String? name,
    String? description,
    String? phoneNumber,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return CenterModel(
      address: address ?? this.address,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address?.toMap(),
      'id': id,
      'name': name,
      'description': description,
      'phoneNumber': phoneNumber,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory CenterModel.fromMap(Map<String, dynamic> map) {
    return CenterModel(
      address: map['address'] != null ? AddressModel.fromMap(map['address'] as Map<String,dynamic>) : null,
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CenterModel.fromJson(String source) => CenterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CenterModel(address: $address, id: $id, name: $name, description: $description, phoneNumber: $phoneNumber, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant CenterModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.address == address &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.phoneNumber == phoneNumber &&
      other.status == status &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return address.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      phoneNumber.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
