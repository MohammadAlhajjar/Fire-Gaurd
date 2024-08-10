// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class Fire  {
  final int? id;
  final String? createsAt;
  Fire({
    this.id,
    this.createsAt,
  });

  Fire copyWith({
    int? id,
    String? createsAt,
  }) {
    return Fire(
      id: id ?? this.id,
      createsAt: createsAt ?? this.createsAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createsAt': createsAt,
    };
  }

  factory Fire.fromMap(Map<String, dynamic> map) {
    return Fire(
      id: map['id'] != null ? map['id'] as int : null,
      createsAt: map['createsAt'] != null ? map['createsAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fire.fromJson(String source) =>
      Fire.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Fire(id: $id, createsAt: $createsAt)';

  @override
  bool operator ==(covariant Fire other) {
    if (identical(this, other)) return true;

    return other.id == id && other.createsAt == createsAt;
  }

  @override
  int get hashCode => id.hashCode ^ createsAt.hashCode;
}
