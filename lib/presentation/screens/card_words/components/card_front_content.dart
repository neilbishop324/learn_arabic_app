import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:learn_arabic_app/data/model/cardword.dart';
import 'package:nb_utils/nb_utils.dart';

class CardFrontContent extends StatelessWidget {
  CardFrontContent({super.key, required this.cardWord, required this.flipCard});

  final CardWord cardWord;
  final Function() flipCard;
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          child: Image.network(
            cardWord.image,
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.none,
          ),
        ),
        8.height,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(cardWord.ar,
                    style: const TextStyle(
                      fontSize: 26,
                    )),
                8.height,
                Text(cardWord.transliteration,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                    )),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => playSound(),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                        backgroundColor: const Color(0xFF92001E),
                      ),
                      child: const Icon(Icons.volume_up, color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () => flipCard(),
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiaryContainer),
                      child: const Icon(Icons.flip, color: Colors.white),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  playSound() async {
    await player.setUrl(cardWord.audio);
    player.play();
  }
}
