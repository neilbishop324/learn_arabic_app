import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_arabic_app/presentation/screens/home/fragments/quizzes/quizzes.dart';
import 'package:learn_arabic_app/presentation/screens/home/fragments/saved/saved.dart';
import 'package:learn_arabic_app/presentation/screens/home/fragments/translate/translate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  final List<String> titles = ['Learn Arabic ع', 'Saved', 'Translate'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          titles[currentPageIndex],
          style: GoogleFonts.hindMadurai(fontWeight: FontWeight.w700),
        ),
      ),
      body: const <Widget>[
        QuizzesPage(),
        SavedPage(),
        TranslatePage(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.quiz),
            label: 'Quizzes',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.translate),
            label: 'Translate',
          ),
        ],
      ),
    );
  }
}
