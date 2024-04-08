import 'package:bloc/bloc.dart';
import 'package:learn_arabic_app/data/model/question.dart';
import 'package:learn_arabic_app/data/model/textword.dart';
import 'package:learn_arabic_app/utils/constants.dart';
import 'package:meta/meta.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    on<PrepareQuestions>(prepareQuestions);
    on<NextQuestion>((event, emit) {
      if (state is QuizLoaded) {
        emit(QuizLoaded((state as QuizLoaded).questions,
            (state as QuizLoaded).questionIndex + 1));
      }
    });
    on<QuizFinishedEvent>((event, emit) {
      if (state is QuizLoaded) {
        emit(QuizFinished(
            correctAnswer: event.trueWord, incorrectAnswer: event.falseWord));
      }
    });
    on<QuizErrorEvent>((event, emit) {
      emit(QuizError(event.message));
    });
  }

  prepareQuestions(PrepareQuestions event, Emitter<QuizState> emit) {
    int minimumSizeOfWordList =
        event.numberOfQuestions + 3 * (event.numberOfQuestions - 1);

    if (minimumSizeOfWordList > event.wordList.length) {
      emit(QuizError("Not enough words to make a quiz."));
      return;
    }

    List<Question> questions = [];

    for (int i = 0; i < event.numberOfQuestions; i++) {
      List<TextWord> optionWords = event.wordList
          .where((element) => !questions
              .map((e) => e.word)
              .toList()
              .contains(element.getWord(event.firstLanguage)))
          .toList();

      optionWords.shuffle();

      Question question = Question(word: "", options: []);

      List<Option> options = optionWords
          .getRange(0, 4)
          .toList()
          .map((e) => Option(
                firstLan: e.getWord(event.firstLanguage),
                secondLan: e.getWord(event.secondLanguage),
                isTrue: false,
              ))
          .toList();

      options[0].isTrue = true;
      question.word = options[0].firstLan;

      options.shuffle();
      question.options = options;

      questions.add(question);
    }

    emit(QuizLoaded(questions, 0));
  }
}

extension QuizExtensions on TextWord {
  String getWord(String language) {
    return (language == languages[0])
        ? ar
        : (language == languages[1])
            ? en
            : tr;
  }
}
