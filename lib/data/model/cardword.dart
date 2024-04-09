// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@entity
class CardWord {
  @primaryKey
  final String id;
  final String ar;
  final String en;
  final String tr;
  final String image;
  final String audio;
  final int index;
  final String transliteration;
  final String category;
  final String createdAt;
  CardWord({
    required this.id,
    required this.ar,
    required this.en,
    required this.tr,
    required this.image,
    required this.audio,
    required this.index,
    required this.transliteration,
    required this.category,
    required this.createdAt,
  });

  CardWord copyWith({
    String? id,
    String? ar,
    String? en,
    String? tr,
    String? image,
    String? audio,
    int? index,
    String? transliteration,
    String? category,
    String? createdAt,
  }) {
    return CardWord(
      id: id ?? this.id,
      ar: ar ?? this.ar,
      en: en ?? this.en,
      tr: tr ?? this.tr,
      image: image ?? this.image,
      audio: audio ?? this.audio,
      index: index ?? this.index,
      transliteration: transliteration ?? this.transliteration,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ar': ar,
      'en': en,
      'tr': tr,
      'image': image,
      'audio': audio,
      'index': index,
      'transliteration': transliteration,
      'category': category,
      'createdAt': createdAt,
    };
  }

  factory CardWord.fromMap(Map<String, dynamic> map) {
    return CardWord(
      id: map['id'] as String,
      ar: map['ar'] as String,
      en: map['en'] as String,
      tr: map['tr'] as String,
      image: map['image'] as String,
      audio: map['audio'] as String,
      index: map['index'] as int,
      transliteration: map['transliteration'] as String,
      category: map['category'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CardWord.fromJson(String source) =>
      CardWord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CardWord(id: $id, ar: $ar, en: $en, tr: $tr, image: $image, audio: $audio, index: $index, transliteration: $transliteration, category: $category, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant CardWord other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.ar == ar &&
        other.en == en &&
        other.tr == tr &&
        other.image == image &&
        other.audio == audio &&
        other.index == index &&
        other.transliteration == transliteration &&
        other.category == category &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ar.hashCode ^
        en.hashCode ^
        tr.hashCode ^
        image.hashCode ^
        audio.hashCode ^
        index.hashCode ^
        transliteration.hashCode ^
        category.hashCode ^
        createdAt.hashCode;
  }
}
