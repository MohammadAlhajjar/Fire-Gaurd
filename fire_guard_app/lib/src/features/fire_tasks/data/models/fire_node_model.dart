// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fire_guard_app/src/features/fire_tasks/data/models/address_model.dart';

class FireNodeModel {

  final Address? address;
  final int? id;
  final String? name;
  final String? description;
  final String?  createdAt;
  final String?  updatedAt;
  FireNodeModel({
    this.address,
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });


  FireNodeModel copyWith({
    Address? address,
    int? id,
    String? name,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return FireNodeModel(
      address: address ?? this.address,
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
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory FireNodeModel.fromMap(Map<String, dynamic> map) {
    return FireNodeModel(
      address: map['address'] != null ? Address.fromMap(map['address'] as Map<String,dynamic>) : null,
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FireNodeModel.fromJson(String source) => FireNodeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FireNodeModel(address: $address, id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant FireNodeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.address == address &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return address.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
