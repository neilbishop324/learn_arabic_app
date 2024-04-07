part of 'text_words_bloc.dart';

@immutable
sealed class TextWordsState {}

class TextWordsInitial extends TextWordsState {}

class TextWordsLoading extends TextWordsState {}

class TextWordsLoaded extends TextWordsState {
  final List<TextWord> data;

  TextWordsLoaded(this.data);
}

class TextWordsError extends TextWordsState {
  final String error;

  TextWordsError(this.error);
}
