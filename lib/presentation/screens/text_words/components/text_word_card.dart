import 'package:flutter/material.dart';
import 'package:learn_arabic_app/data/local_database/dao/text_word_dao.dart';
import 'package:learn_arabic_app/data/local_database/database/floor_database.dart';
import 'package:learn_arabic_app/data/model/textword.dart';
import 'package:nb_utils/nb_utils.dart';

class TextWordCard extends StatefulWidget {
  const TextWordCard({
    super.key,
    required this.textWord,
  });

  final TextWord textWord;

  @override
  State<TextWordCard> createState() => _TextWordCardState();
}

class _TextWordCardState extends State<TextWordCard> {
  SharedPreferences? sharedPreferences;
  TextWordDao? textWordDao;

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
    textWordDao = database.textWordDao;
    setState(() {
      saved = sharedPreferences?.getBool(widget.textWord.id) ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.textWord.ar,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.bookmark, color: saved ? Colors.blue : null),
                  onPressed: () => saveTextWord(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Level: ${widget.textWord.level}',
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 8),
            Text(
              'Part of Speech: ${widget.textWord.pos}',
              style: const TextStyle(color: Colors.green),
            ),
            Divider(color: Colors.grey[300]),
            Text(
              'English: ${widget.textWord.en}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Turkish: ${widget.textWord.tr}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    ).paddingAll(8);
  }

  saveTextWord() async {
    if (saved) {
      sharedPreferences?.setBool(widget.textWord.id, false);
      textWordDao?.deleteById(widget.textWord.id);
    } else {
      sharedPreferences?.setBool(widget.textWord.id, true);
      textWordDao?.insertTextWord(widget.textWord);
    }
    setState(() {
      saved = !saved;
    });
  }
}
