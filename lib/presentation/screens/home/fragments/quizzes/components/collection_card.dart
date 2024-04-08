import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_arabic_app/data/model/collection.dart';
import 'package:learn_arabic_app/logic/text_words/bloc/text_words_bloc.dart';
import 'package:learn_arabic_app/presentation/screens/card_words/card_words_screen.dart';
import 'package:learn_arabic_app/presentation/screens/text_words/text_words_screen.dart';
import 'package:learn_arabic_app/utils/constants.dart';
import 'package:learn_arabic_app/utils/ui.dart';
import 'package:nb_utils/nb_utils.dart';

class CollectionCard extends StatelessWidget {
  final Collection collection;
  const CollectionCard(
    this.collection, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(
            collection.image,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              Text(
                collection.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                collection.desc,
                style: const TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ).paddingAll(6),
        ],
      ).onClick(() => cardOnClick(collection, context)),
    );
  }

  cardOnClick(Collection collection, BuildContext context) {
    switch (collection.collectionName) {
      case wordsCollection:
        BlocProvider.of<TextWordsBloc>(context).add(LoadTextWords(0, 99));
        Navigator.pushNamed(context, TextWordsScreen.routeName,
            arguments: TextWordsScreenArgs(true));
        break;
      case wordsWithPicsCollection:
        Navigator.pushNamed(context, CardWordsScreen.routeName,
            arguments: CardWordsScreenArgs(collection.name));
        break;
      case savedWordsCollection:
        BlocProvider.of<TextWordsBloc>(context).add(LoadLocalTextWords());
        Navigator.pushNamed(context, TextWordsScreen.routeName,
            arguments: TextWordsScreenArgs(false));
    }
  }
}
