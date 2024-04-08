// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent {}

class PrepareQuestions extends QuizEvent {
  final List<TextWord> wordList;
  final String firstLanguage;
  final String secondLanguage;
  final int numberOfQuestions;
  PrepareQuestions(this.wordList, this.firstLanguage, this.secondLanguage,
      this.numberOfQuestions);
}

class NextQuestion extends QuizEvent {
  NextQuestion();
}

class QuizFinishedEvent extends QuizEvent {
  final int trueWord;
  final int falseWord;
  QuizFinishedEvent({
    required this.trueWord,
    required this.falseWord,
  });
}

class QuizErrorEvent extends QuizEvent {
  final String message;
  QuizErrorEvent(this.message);
}
