import 'package:learn_arabic_app/data/model/collection.dart';
import 'package:learn_arabic_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CollectionRepository {
  Future<List<Collection>?> fetchCollections(
      {required int firstIndex, required int lastIndex});
}

class CollectionRepo extends CollectionRepository {
  @override
  Future<List<Collection>?> fetchCollections(
      {required int firstIndex, required int lastIndex}) async {
    try {
      var data = await Supabase.instance.client
          .from(wordCollectionsCollection)
          .select()
          .range(firstIndex, lastIndex);

      return data.map((e) => Collection.fromMap(e)).toList();
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }
}
