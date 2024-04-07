// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TextWord {
  final String id;
  final String ar;
  final String en;
  final String tr;
  final int index;
  final String level;
  final String pos;
  final String createdAt;
  TextWord({
    required this.id,
    required this.ar,
    required this.en,
    required this.tr,
    required this.index,
    required this.level,
    required this.pos,
    required this.createdAt,
  });

  TextWord copyWith({
    String? id,
    String? ar,
    String? en,
    String? tr,
    int? index,
    String? level,
    String? pos,
    String? createdAt,
  }) {
    return TextWord(
      id: id ?? this.id,
      ar: ar ?? this.ar,
      en: en ?? this.en,
      tr: tr ?? this.tr,
      index: index ?? this.index,
      level: level ?? this.level,
      pos: pos ?? this.pos,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ar': ar,
      'en': en,
      'tr': tr,
      'index': index,
      'level': level,
      'pos': pos,
      'createdAt': createdAt,
    };
  }

  factory TextWord.fromMap(Map<String, dynamic> map) {
    return TextWord(
      id: map['id'] as String,
      ar: map['ar'] as String,
      en: map['en'] as String,
      tr: map['tr'] as String,
      index: map['index'] as int,
      level: map['level'] as String,
      pos: map['pos'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TextWord.fromJson(String source) =>
      TextWord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TextWord(id: $id, ar: $ar, en: $en, tr: $tr, index: $index, level: $level, pos: $pos, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant TextWord other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.ar == ar &&
        other.en == en &&
        other.tr == tr &&
        other.index == index &&
        other.level == level &&
        other.pos == pos &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ar.hashCode ^
        en.hashCode ^
        tr.hashCode ^
        index.hashCode ^
        level.hashCode ^
        pos.hashCode ^
        createdAt.hashCode;
  }
}
