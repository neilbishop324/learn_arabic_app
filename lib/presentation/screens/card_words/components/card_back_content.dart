import 'package:flutter/material.dart';
import 'package:learn_arabic_app/data/local_database/dao/card_word_dao.dart';
import 'package:learn_arabic_app/data/local_database/database/floor_database.dart';
import 'package:learn_arabic_app/data/model/cardword.dart';
import 'package:nb_utils/nb_utils.dart';

class CardBackContent extends StatefulWidget {
  const CardBackContent(
      {super.key, required this.cardWord, required this.flipCard});

  final Function() flipCard;

  final CardWord cardWord;

  @override
  State<CardBackContent> createState() => _CardBackContentState();
}

class _CardBackContentState extends State<CardBackContent> {
  SharedPreferences? sharedPreferences;
  CardWordDao? cardWordDao;

  bool saved = false;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  _initData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    cardWordDao = database.cardWordDao;
    setState(() {
      saved = sharedPreferences?.getBool(widget.cardWord.id) ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          color: Theme.of(context).colorScheme.onSurface,
          child: Image.network(
            fit: BoxFit.fitHeight,
            widget.cardWord.image,
            width: 120,
            height: 120,
          ),
        ).cornerRadiusWithClipRRect(100),
        Text(
          "English: ${widget.cardWord.en}",
          style: const TextStyle(
            fontSize: 21,
          ),
        ),
        Text(
          "Turkish: ${widget.cardWord.tr}",
          style: const TextStyle(
            fontSize: 21,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => saveCardWord(),
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer),
              child: Icon(Icons.bookmark,
                  color: saved ? Colors.blue : Colors.white),
            ),
            ElevatedButton(
              onPressed: () => widget.flipCard(),
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer),
              child: const Icon(Icons.flip, color: Colors.white),
            ),
          ],
        ),
      ],
    ).paddingAll(16);
  }

  saveCardWord() async {
    if (saved) {
      sharedPreferences?.setBool(widget.cardWord.id, false);
      cardWordDao?.deleteById(widget.cardWord.id);
    } else {
      sharedPreferences?.setBool(widget.cardWord.id, true);
      cardWordDao?.insertCardWord(widget.cardWord);
    }
    setState(() {
      saved = !saved;
    });
  }
}
