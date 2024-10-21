import 'package:architecture/config/theme/app_theme.dart';
import 'package:architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:architecture/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:architecture/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: BlocProvider(
          create: (context) => RemoteArticleBloc(locator<GetArticleUseCase>())
            ..add(const GetArticles()),
          child: const DailyNews()),
    );
  }
}
