// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Collection {
  final int id;
  final String name;
  final String desc;
  final String collectionName;
  final String createdAt;
  final String image;
  Collection({
    required this.id,
    required this.name,
    required this.desc,
    required this.collectionName,
    required this.createdAt,
    required this.image,
  });

  Collection copyWith({
    int? id,
    String? name,
    String? desc,
    String? collectionName,
    String? createdAt,
    String? image,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      collectionName: collectionName ?? this.collectionName,
      createdAt: createdAt ?? this.createdAt,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'desc': desc,
      'collectionName': collectionName,
      'createdAt': createdAt,
      'image': image,
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['id'] as int,
      name: map['name'] as String,
      desc: map['desc'] as String,
      collectionName: map['collection_name'] as String,
      createdAt: map['created_at'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Collection(id: $id, name: $name, desc: $desc, collectionName: $collectionName, createdAt: $createdAt, image: $image)';
  }

  @override
  bool operator ==(covariant Collection other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.desc == desc &&
        other.collectionName == collectionName &&
        other.createdAt == createdAt &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        desc.hashCode ^
        collectionName.hashCode ^
        createdAt.hashCode ^
        image.hashCode;
  }
}
