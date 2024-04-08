import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_arabic_app/data/model/question.dart';
import 'package:learn_arabic_app/data/model/textword.dart';
import 'package:learn_arabic_app/logic/quiz/bloc/quiz_bloc.dart';
import 'package:learn_arabic_app/presentation/screens/error/components/error_component.dart';
import 'package:learn_arabic_app/presentation/screens/quiz/components/quiz_finished_component.dart';
import 'package:learn_arabic_app/utils/ui.dart';
import 'package:nb_utils/nb_utils.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  static const String routeName = "quiz_screen";

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class QuizScreenArgs {
  final List<TextWord> wordList;

  QuizScreenArgs(this.wordList);
}

class _QuizScreenState extends State<QuizScreen> {
  int _correctAnswers = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            shadowColor: Colors.transparent,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close)),
            title: LinearProgressIndicator(
              minHeight: 15,
              value: (state is QuizLoaded)
                  ? (state.questionIndex + 1) / state.questions.length
                  : 1 / 10,
            ).cornerRadiusWithClipRRect(20).paddingOnly(left: 10, right: 30),
          ),
          body: questionComponent(context, state),
        );
      },
    );
  }

  Widget questionComponent(BuildContext context, QuizState state) {
    if (state is QuizLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is QuizError) {
      return ErrorComponent(errorContent: state.error);
    } else if (state is QuizLoaded) {
      return loadedComponent(state);
    } else if (state is QuizFinished) {
      return QuizFinishedComponent(
          allWordList:
              (ModalRoute.of(context)!.settings.arguments as QuizScreenArgs)
                  .wordList,
          context: context,
          state: state);
    } else {
      return const SizedBox();
    }
  }

  Widget loadedComponent(QuizLoaded state) {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Meaning of ${state.questions[state.questionIndex].word}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              32.height,
              optionButton(
                  state.questions[state.questionIndex].options[0], state, "A"),
              16.height,
              optionButton(
                  state.questions[state.questionIndex].options[1], state, "B"),
              16.height,
              optionButton(
                  state.questions[state.questionIndex].options[2], state, "C"),
              16.height,
              optionButton(
                  state.questions[state.questionIndex].options[3], state, "D"),
            ],
          )),
    );
  }

  Widget optionButton(Option option, QuizLoaded state, String optionChar) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                optionChar,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ).paddingAll(10),
          16.height,
          Expanded(
            child: Text(
              option.secondLan,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onPressed: () => answerOnClick(context, option, state),
    );
  }

  answerOnClick(BuildContext context, Option option, QuizLoaded state) {
    showSnackBar(
        context,
        (option.isTrue)
            ? "Correct!"
            : "Incorrect! It was ${state.questions[state.questionIndex].options.firstWhere((element) => element.isTrue).secondLan}");

    //Changing result
    if (option.isTrue) {
      _correctAnswers++;
    }

    if (state.questionIndex + 1 == state.questions.length) {
      showSnackBar(context,
          "Quiz is over! $_correctAnswers right, ${state.questions.length - _correctAnswers} wrong");
      context.read<QuizBloc>().add(QuizFinishedEvent(
          trueWord: _correctAnswers,
          falseWord: state.questions.length - _correctAnswers));
      _correctAnswers = 0;
    }

    context.read<QuizBloc>().add(NextQuestion());
  }
}
