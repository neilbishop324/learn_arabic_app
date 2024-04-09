part of 'card_words_bloc.dart';

@immutable
sealed class CardWordsEvent {}

class LoadCardWords extends CardWordsEvent {
  final String category;

  LoadCardWords(this.category);
}

class LoadLocalCardWords extends CardWordsEvent {
  LoadLocalCardWords();
}
