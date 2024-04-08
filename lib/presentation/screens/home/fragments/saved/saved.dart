import 'package:flutter/material.dart';
import 'package:learn_arabic_app/data/model/collection.dart';
import 'package:learn_arabic_app/presentation/screens/home/fragments/quizzes/components/collection_card.dart';
import 'package:learn_arabic_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CollectionCard(Collection(
            id: 0,
            name: "3000 Words",
            desc: "Saved portion of 3000 simple words.",
            collectionName: savedWordsCollection,
            createdAt: "",
            image: wordCollectionImageLink)),
        10.height,
        CollectionCard(Collection(
            id: 0,
            name: "Your Card Collection",
            desc: "Remember the words you saved with the cards.",
            collectionName: savedWordsWithPicsCollection,
            createdAt: "",
            image: cardCollectionImageLink))
      ],
    ).paddingAll(20);
  }
}
