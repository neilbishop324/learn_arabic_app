import 'package:bloc/bloc.dart';
import 'package:learn_arabic_app/utils/constants.dart';

part 'text_words_quiz_state.dart';

class TextWordsQuizCubit extends Cubit<TextWordsQuizState> {
  TextWordsQuizCubit()
      : super(TextWordsQuizState(
          firstLanguage: languages[0],
          secondLanguage: languages[2],
          numberOfQuestions: 10,
        ));

  void setNumberOfQuestions(int noq) => emit(TextWordsQuizState(
        firstLanguage: state.firstLanguage,
        secondLanguage: state.secondLanguage,
        numberOfQuestions: noq,
      ));

  void setFirstLanguage(String newValue) {
    var firstLanguage = state.firstLanguage;
    var secondLanguage = state.secondLanguage;

    if (newValue == secondLanguage) {
      secondLanguage = firstLanguage;
    }
    firstLanguage = newValue;

    emit(TextWordsQuizState(
      firstLanguage: firstLanguage,
      secondLanguage: secondLanguage,
      numberOfQuestions: state.numberOfQuestions,
    ));
  }

  void setSecondLanguage(String newValue) {
    var firstLanguage = state.firstLanguage;
    var secondLanguage = state.secondLanguage;

    if (newValue == firstLanguage) {
      firstLanguage = secondLanguage;
    }
    secondLanguage = newValue;

    emit(TextWordsQuizState(
      firstLanguage: firstLanguage,
      secondLanguage: secondLanguage,
      numberOfQuestions: state.numberOfQuestions,
    ));
  }
}
