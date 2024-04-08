import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:learn_arabic_app/data/repository/collection_repo.dart';
import 'package:learn_arabic_app/data/repository/text_word_repo.dart';
import 'package:learn_arabic_app/logic/collections/bloc/collections_bloc.dart';
import 'package:learn_arabic_app/logic/quiz/bloc/quiz_bloc.dart';
import 'package:learn_arabic_app/logic/text_words/bloc/text_words_bloc.dart';
import 'package:learn_arabic_app/logic/text_words/cubit/text_words_index_cubit.dart';
import 'package:learn_arabic_app/logic/text_words/cubit/text_words_quiz_cubit.dart';
import 'package:learn_arabic_app/presentation/router/app_router.dart';
import 'package:learn_arabic_app/presentation/theme/color_schemes.g.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "secret.env");
  final String supabaseUrl = dotenv.env['SUPABASE_URL'].toString();
  final String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'].toString();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<CollectionsBloc>(
          create: (context) => CollectionsBloc(CollectionRepo())),
      BlocProvider<TextWordsBloc>(
          create: (context) => TextWordsBloc(TextWordRepo())),
      BlocProvider<TextWordsIndexCubit>(
          create: (context) => TextWordsIndexCubit()),
      BlocProvider<TextWordsQuizCubit>(
          create: (context) => TextWordsQuizCubit()),
      BlocProvider<QuizBloc>(create: (context) => QuizBloc()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Arabic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
