import 'package:flutter/material.dart';
import 'package:learn_arabic_app/presentation/screens/card_words/card_words_screen.dart';
import 'package:learn_arabic_app/presentation/screens/home/home_screen.dart';
import 'package:learn_arabic_app/presentation/screens/text_words/text_words_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case CardWordsScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const CardWordsScreen(),
        );
      case TextWordsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const TextWordsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SizedBox());
    }
  }
}
