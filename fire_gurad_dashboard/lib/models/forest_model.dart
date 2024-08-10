// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'address_model.dart';

class ForestModel {
  final int? id;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final AddressModel? address;
  ForestModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.address,
  });

  ForestModel copyWith({
    int? id,
    String? name,
    String? description,
    String? createdAt,
    String? updatedAt,
    AddressModel? address,
  }) {
    return ForestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'address': address?.toMap(),
    };
  }

  factory ForestModel.fromMap(Map<String, dynamic> map) {
    return ForestModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      address: map['address'] != null ? AddressModel.fromMap(map['address'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForestModel.fromJson(String source) => ForestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ForestModel(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, address: $address)';
  }

  @override
  bool operator ==(covariant ForestModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      address.hashCode;
  }
}
