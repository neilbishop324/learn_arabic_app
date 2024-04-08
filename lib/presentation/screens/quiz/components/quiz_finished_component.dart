import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_arabic_app/data/model/textword.dart';
import 'package:learn_arabic_app/logic/quiz/bloc/quiz_bloc.dart';
import 'package:learn_arabic_app/logic/text_words/cubit/text_words_quiz_cubit.dart';
import 'package:nb_utils/nb_utils.dart';

class QuizFinishedComponent extends StatelessWidget {
  const QuizFinishedComponent({
    super.key,
    required this.allWordList,
    required this.context,
    required this.state,
  });

  final List<TextWord> allWordList;
  final BuildContext context;
  final QuizFinished state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quiz Result',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            32.height,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.green,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Correct Answers',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    state.correctAnswer.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            16.height,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.red,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Incorrect Answers',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    state.incorrectAnswer.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            32.height,
            ElevatedButton(
              onPressed: () {
                TextWordsQuizCubit cubit = context.read<TextWordsQuizCubit>();
                BlocProvider.of<QuizBloc>(context).add(PrepareQuestions(
                  allWordList,
                  cubit.state.firstLanguage,
                  cubit.state.secondLanguage,
                  cubit.state.numberOfQuestions,
                ));
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
