part of 'quiz_bloc.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Question> questions;
  final int questionIndex;
  QuizLoaded(
    this.questions,
    this.questionIndex,
  );
}

class QuizError extends QuizState {
  final String error;
  QuizError(this.error);
}

class QuizFinished extends QuizState {
  final int correctAnswer;
  final int incorrectAnswer;
  QuizFinished({
    required this.correctAnswer,
    required this.incorrectAnswer,
  });
}
