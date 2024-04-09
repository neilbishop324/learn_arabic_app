import 'package:floor/floor.dart';
import 'package:learn_arabic_app/data/model/cardword.dart';

@dao
abstract class CardWordDao {
  @Query('SELECT * FROM CardWord')
  Future<List<CardWord>> findAllCardWords();

  @insert
  Future<void> insertCardWord(CardWord cardWord);

  @Query('DELETE FROM CardWord WHERE id=:id')
  Future<void> deleteById(String id);
}
