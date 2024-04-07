import 'package:flutter/material.dart';
import 'package:learn_arabic_app/data/model/textword.dart';
import 'package:nb_utils/nb_utils.dart';

class TextWordCard extends StatelessWidget {
  const TextWordCard({
    super.key,
    required this.textWord,
  });

  final TextWord textWord;

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
                  textWord.ar,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark),
                  onPressed: () {
                    // Add your save functionality here
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Level: ${textWord.level}',
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 8),
            Text(
              'Part of Speech: ${textWord.pos}',
              style: const TextStyle(color: Colors.green),
            ),
            Divider(color: Colors.grey[300]),
            Text(
              'English: ${textWord.en}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Turkish: ${textWord.tr}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    ).paddingAll(8);
  }
}
