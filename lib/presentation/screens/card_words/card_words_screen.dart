import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Container(),
    );
  }
}
