import 'package:architecture/core/resources/data_state.dart';
import 'package:architecture/core/usecases/usecase.dart';
import 'package:architecture/features/daily_news/domain/entities/article.dart';
import 'package:architecture/features/daily_news/domain/repository/article_repository.dart';

class GetArticleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;
  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }
}
