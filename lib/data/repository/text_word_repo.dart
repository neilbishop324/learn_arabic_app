import 'package:learn_arabic_app/data/local_database/dao/text_word_dao.dart';
import 'package:learn_arabic_app/data/local_database/database/floor_database.dart';
import 'package:learn_arabic_app/data/model/textword.dart';
import 'package:learn_arabic_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TextWordRepository {
  Future<List<TextWord>?> fetchTextWords(
      {required int firstIndex, required int lastIndex});
  Future<List<TextWord>?> fetchLocalTextWords();
}

class TextWordRepo extends TextWordRepository {
  @override
  Future<List<TextWord>?> fetchTextWords(
      {required int firstIndex, required int lastIndex}) async {
    try {
      var data = await Supabase.instance.client
          .from(wordsCollection)
          .select()
          .range(firstIndex, lastIndex);

      return data.map((e) => TextWord.fromMap(e)).toList();
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }

  @override
  Future<List<TextWord>?> fetchLocalTextWords() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    TextWordDao textWordDao = database.textWordDao;

    return textWordDao.findAllTextWords();
  }
}
