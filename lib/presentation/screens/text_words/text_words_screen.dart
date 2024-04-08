import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_arabic_app/data/model/textword.dart';
import 'package:learn_arabic_app/logic/text_words/bloc/text_words_bloc.dart';
import 'package:learn_arabic_app/logic/text_words/cubit/text_words_index_cubit.dart';
import 'package:learn_arabic_app/presentation/screens/error/components/error_component.dart';
import 'package:learn_arabic_app/presentation/screens/text_words/components/quiz_dialog.dart';
import 'package:nb_utils/nb_utils.dart';

import 'components/text_word_card.dart';

class TextWordsScreen extends StatefulWidget {
  const TextWordsScreen({super.key});

  static const String routeName = "text_words_screen";

  @override
  State<TextWordsScreen> createState() => _TextWordsScreenState();
}

class TextWordsScreenArgs {
  final bool hasPageSystem;

  TextWordsScreenArgs(this.hasPageSystem);
}

class _TextWordsScreenState extends State<TextWordsScreen> {
  int wordsSizeRange = 99;
  late TextWordsIndexCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<TextWordsIndexCubit>();
  }

  @override
  void dispose() {
    // Dispose of your resources here
    cubit.setFirstIndex(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextWordsIndexCubit, TextWordsIndexState>(
        builder: (cubitContext, cubitState) {
      return BlocConsumer<TextWordsBloc, TextWordsState>(
        listener: (blocContext, blocState) {},
        builder: (blocContext, blocState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(
                "3000 Words",
                style: GoogleFonts.hindMadurai(fontWeight: FontWeight.w700),
              ),
              actions: (ModalRoute.of(context)!.settings.arguments
                          as TextWordsScreenArgs)
                      .hasPageSystem
                  ? [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () => moveToAnotherPage(-100, cubitState),
                      ),
                      Text(
                        (cubitState.firstIndex ~/ 100 + 1).toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () => moveToAnotherPage(100, cubitState),
                      ),
                    ]
                  : null,
            ),
            body: content(blocContext, blocState),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                if (blocState is TextWordsLoaded) {
                  Dialog quizDialog = QuizDialog(blocState.data);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => quizDialog);
                }
              },
              label: const Text("Quiz"),
              icon: const Icon(Icons.quiz),
            ),
          );
        },
      );
    });
  }

  Widget content(BuildContext context, TextWordsState state) {
    if (state is TextWordsLoaded) {
      return buildLoadedlayout(state.data);
    } else if (state is TextWordsLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is TextWordsError) {
      return ErrorComponent(errorContent: state.error);
    } else {
      return const SizedBox();
    }
  }

  Widget buildLoadedlayout(List<TextWord> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        TextWord textWord = data[index];
        return TextWordCard(textWord: textWord);
      },
    ).paddingOnly(left: 4, right: 4, top: 8);
  }

  moveToAnotherPage(int changeIndex, TextWordsIndexState cubitState) {
    if (cubitState.firstIndex + changeIndex >= 0 &&
        cubitState.firstIndex + wordsSizeRange + changeIndex <= 3000) {
      BlocProvider.of<TextWordsBloc>(context).add(LoadTextWords(
          cubitState.firstIndex + changeIndex,
          cubitState.firstIndex + wordsSizeRange + changeIndex));

      cubit.setFirstIndex(cubitState.firstIndex + changeIndex);
    }
  }
}
