import 'package:bloc/bloc.dart';
import 'package:learn_arabic_app/data/model/textword.dart';
import 'package:learn_arabic_app/data/repository/text_word_repo.dart';
import 'package:meta/meta.dart';

part 'text_words_event.dart';
part 'text_words_state.dart';

class TextWordsBloc extends Bloc<TextWordsEvent, TextWordsState> {
  final TextWordRepo repo;
  TextWordsBloc(this.repo) : super(TextWordsInitial()) {
    on<LoadTextWords>((event, emit) async {
      List<TextWord>? list;
      emit(TextWordsLoading());

      list = await repo.fetchTextWords(
          firstIndex: event.firstIndex, lastIndex: event.lastIndex);

      if (list == null) {
        emit(TextWordsError("Words were not found!"));
      } else {
        emit(TextWordsLoaded(list));
      }
    });
  }
}
