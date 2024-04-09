import 'package:learn_arabic_app/data/local_database/dao/card_word_dao.dart';
import 'package:learn_arabic_app/data/local_database/database/floor_database.dart';
import 'package:learn_arabic_app/data/model/cardword.dart';
import 'package:learn_arabic_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CardWordRepository {
  Future<List<CardWord>?> fetchCardWords({required String category});
  Future<List<CardWord>?> fetchLocalCardWords();
}

class CardWordRepo extends CardWordRepository {
  @override
  Future<List<CardWord>?> fetchCardWords({required String category}) async {
    try {
      var data = await Supabase.instance.client
          .from(wordsWithPicsCollection)
          .select()
          .eq("category", category);

      return data.map((e) => CardWord.fromMap(e)).toList();
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }

  @override
  Future<List<CardWord>?> fetchLocalCardWords() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    CardWordDao cardWordDao = database.cardWordDao;

    return cardWordDao.findAllCardWords();
  }
}
