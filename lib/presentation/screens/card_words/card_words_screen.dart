import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_arabic_app/logic/card_words/bloc/card_words_bloc.dart';
import 'package:learn_arabic_app/presentation/screens/error/components/error_component.dart';

import 'components/sliding_card.dart';

class CardWordsScreen extends StatefulWidget {
  const CardWordsScreen({super.key});

  static const String routeName = "card_words_screen";

  @override
  State<CardWordsScreen> createState() => _CardWordsScreenState();
}

class CardWordsScreenArgs {
  final String category;

  CardWordsScreenArgs(this.category);
}

class _CardWordsScreenState extends State<CardWordsScreen> {
  late String category;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    category =
        (ModalRoute.of(context)!.settings.arguments as CardWordsScreenArgs)
            .category;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          category,
          style: GoogleFonts.hindMadurai(fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocConsumer<CardWordsBloc, CardWordsState>(
        listener: (blocContext, state) {},
        builder: (blocContext, state) {
          return content(blocContext, state);
        },
      ),
    );
  }

  Widget content(BuildContext blocContext, CardWordsState state) {
    if (state is CardWordsLoaded) {
      if (state.data.isEmpty) {
        return const Center(
          child: Text(
            "No words here",
            style: TextStyle(fontSize: 18),
          ),
        );
      }
      return buildLoadedlayout(state);
    } else if (state is CardWordsLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is CardWordsError) {
      return ErrorComponent(errorContent: state.error);
    } else {
      return const SizedBox();
    }
  }

  Widget buildLoadedlayout(CardWordsLoaded state) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        child: PageView(
          controller: pageController,
          children: state.data
              .asMap()
              .map((i, cardWord) {
                return MapEntry(i, SlidingCard(index: i));
              })
              .values
              .toList(),
        ),
      ),
    );
  }
}
