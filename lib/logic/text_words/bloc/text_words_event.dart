part of 'text_words_bloc.dart';

@immutable
sealed class TextWordsEvent {}

class LoadTextWords extends TextWordsEvent {
  final int firstIndex;
  final int lastIndex;

  LoadTextWords(this.firstIndex, this.lastIndex);
}
