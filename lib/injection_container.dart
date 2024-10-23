import 'package:architecture/features/daily_news/data/datasources/local/app_database.dart';
import 'package:architecture/features/daily_news/data/datasources/remote/news_api_service.dart';
import 'package:architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:architecture/features/daily_news/domain/usecases/delete_article.dart';
import 'package:architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:architecture/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:architecture/features/daily_news/domain/usecases/save_article.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// 모든 파일에서 접근 가능하도록 전역적으로 정의
final locator = GetIt.instance;
initializeDependencies() async {
  // Database 구축
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  // Dio
  locator.registerSingleton<Dio>(Dio());

  // Dependencies
  locator.registerSingleton<NewsApiService>(NewsApiService(locator()));

  locator.registerSingleton<ArticleRepository>(
      ArticleRepositoryImpl(locator(), locator()));

  // UseCases
  locator.registerSingleton<GetArticleUseCase>(GetArticleUseCase(locator()));
  locator.registerSingleton<GetSavedArticleUseCase>(
      GetSavedArticleUseCase(locator()));
  locator.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(locator()));
  locator
      .registerSingleton<DeleteArticleUseCase>(DeleteArticleUseCase(locator()));

  // Blocs, bloc 의 경우 상태가 변경될 떄마다 새 인스턴스를 반환하기 때문에 singletone 으로 등록하면 안됨.
  locator
      .registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(locator()));
}
