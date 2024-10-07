import 'package:architecture/core/resources/data_state.dart';
import 'package:architecture/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
