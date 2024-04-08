import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_arabic_app/data/model/textword.dart';
import 'package:learn_arabic_app/logic/quiz/bloc/quiz_bloc.dart';
import 'package:learn_arabic_app/logic/text_words/cubit/text_words_quiz_cubit.dart';
import 'package:learn_arabic_app/presentation/screens/quiz/quiz_screen.dart';
import 'package:learn_arabic_app/presentation/utils/widget_functions.dart';
import 'package:learn_arabic_app/presentation/utils/widgets.dart';
import 'package:learn_arabic_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class QuizDialog extends Dialog {
  QuizDialog(this.data, {super.key});

  final List<TextWord> data;

  final GlobalKey noqViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: BlocBuilder<TextWordsQuizCubit, TextWordsQuizState>(
        builder: (cubitContext, state) {
          return SizedBox(
            height: 280.0,
            width: 300.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Quiz Yourself',
                  style: GoogleFonts.hindMadurai(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ).paddingSymmetric(vertical: 20),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "First Language:",
                      style: TextStyle(fontSize: 18),
                    ),
                    5.width,
                    choiceView(
                        context: context,
                        selectedChoice: state.firstLanguage,
                        choices: languages,
                        onSelectChoice: (language) => {
                              cubitContext
                                  .read<TextWordsQuizCubit>()
                                  .setFirstLanguage(language)
                            }),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Second Language:",
                      style: TextStyle(fontSize: 18),
                    ),
                    5.width,
                    choiceView(
                        context: context,
                        selectedChoice: state.secondLanguage,
                        choices: languages,
                        onSelectChoice: (language) => {
                              cubitContext
                                  .read<TextWordsQuizCubit>()
                                  .setSecondLanguage(language)
                            }),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Number Of Questions:",
                      style: TextStyle(fontSize: 18),
                    ),
                    5.width,
                    Container(
                      key: noqViewKey,
                      child: choiceView(
                        context: context,
                        selectedChoice: state.numberOfQuestions.toString(),
                        choices: [],
                        onSelectChoice: (choice) {},
                        onClick: () async {
                          int? changedNOQ = await showPopupMenu(
                            context,
                            noqViewKey,
                            List.generate(
                                5, (index) => ((index + 1) * 5).toString()),
                            100,
                            50,
                          );

                          if (changedNOQ != null && cubitContext.mounted) {
                            cubitContext
                                .read<TextWordsQuizCubit>()
                                .setNumberOfQuestions((changedNOQ + 1) * 5);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                10.height,
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    BlocProvider.of<QuizBloc>(context).add(PrepareQuestions(
                      data,
                      state.firstLanguage,
                      state.secondLanguage,
                      state.numberOfQuestions,
                    ));
                    Navigator.pushNamed(context, QuizScreen.routeName,
                        arguments: QuizScreenArgs(data));
                  },
                  child: const Text("Start Quiz"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
