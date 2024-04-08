import 'dart:async';

import 'package:floor/floor.dart';
import 'package:learn_arabic_app/data/local_database/dao/text_word_dao.dart';
import 'package:learn_arabic_app/data/model/textword.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'text_word_db.g.dart'; // the generated code will be there

@Database(version: 1, entities: [TextWord])
abstract class AppDatabase extends FloorDatabase {
  TextWordDao get textWordDao;
}
