part of 'card_words_bloc.dart';

@immutable
sealed class CardWordsState {}

class CardWordsInitial extends CardWordsState {}

class CardWordsLoading extends CardWordsState {}

class CardWordsLoaded extends CardWordsState {
  final List<CardWord> data;

  CardWordsLoaded(this.data);
}

class CardWordsError extends CardWordsState {
  final String error;

  CardWordsError(this.error);
}
