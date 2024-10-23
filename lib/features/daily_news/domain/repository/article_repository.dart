import 'package:architecture/core/resources/data_state.dart';
import 'package:architecture/features/daily_news/data/models/article.dart';
import 'package:architecture/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  //API methods
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  //Database methods
  Future<List<ArticleEntity>> getSavedArticles();

  Future<void> saveArticle(ArticleEntity article);

  Future<void> deleteArticle(ArticleEntity article);
}
