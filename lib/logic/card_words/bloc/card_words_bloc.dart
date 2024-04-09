import 'package:bloc/bloc.dart';
import 'package:learn_arabic_app/data/model/cardword.dart';
import 'package:learn_arabic_app/data/repository/card_word_repo.dart';
import 'package:meta/meta.dart';

part 'card_words_event.dart';
part 'card_words_state.dart';

class CardWordsBloc extends Bloc<CardWordsEvent, CardWordsState> {
  final CardWordRepo repo;
  CardWordsBloc(this.repo) : super(CardWordsInitial()) {
    on<LoadCardWords>((event, emit) async {
      List<CardWord>? list;
      emit(CardWordsLoading());

      list = await repo.fetchCardWords(category: event.category);

      if (list == null) {
        emit(CardWordsError("Words were not found!"));
      } else {
        emit(CardWordsLoaded(list));
      }
    });
    on<LoadLocalCardWords>((event, emit) async {
      List<CardWord>? list;
      emit(CardWordsLoading());

      list = await repo.fetchLocalCardWords();

      if (list == null) {
        emit(CardWordsError("Words were not found!"));
      } else {
        emit(CardWordsLoaded(list));
      }
    });
  }
}
