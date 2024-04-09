import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:learn_arabic_app/logic/card_words/bloc/card_words_bloc.dart';
import 'package:learn_arabic_app/presentation/screens/card_words/components/card_back_content.dart';

import 'card_front_content.dart';

class SlidingCard extends StatelessWidget {
  SlidingCard({
    super.key,
    required this.index,
  });

  final int index;
  final controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardWordsBloc, CardWordsState>(
        listener: (context, state) {},
        builder: (context, state) {
          state as CardWordsLoaded;
          return FlipCard(
            rotateSide: RotateSide.bottom,
            onTapFlipping: true,
            axis: FlipAxis.vertical,
            controller: controller,
            frontWidget: cardContent(
              child: CardFrontContent(
                  cardWord: state.data[index], flipCard: () => flipCard()),
            ),
            backWidget: cardContent(
              child: CardBackContent(
                  cardWord: state.data[index], flipCard: () => flipCard()),
            ),
          );
        });
  }

  Widget cardContent({required Widget child}) {
    return Card(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: child);
  }

  void flipCard() {
    controller.flipcard();
  }
}
