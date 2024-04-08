import 'package:floor/floor.dart';
import 'package:learn_arabic_app/data/model/textword.dart';

@dao
abstract class TextWordDao {
  @Query('SELECT * FROM TextWord')
  Future<List<TextWord>> findAllTextWords();

  @insert
  Future<void> insertTextWord(TextWord textWord);

  @Query('DELETE FROM TextWord WHERE id=:id')
  Future<void> deleteById(String id);
}
