import 'package:architecture/features/daily_news/domain/entities/article.dart';
import 'package:equatable/equatable.dart';

abstract class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  const LocalArticleState({this.articles});

  @override
  List<Object?> get props => [articles!];
}

class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

class LocalArticleDone extends LocalArticleState {
  const LocalArticleDone(List<ArticleEntity> articles)
      : super(articles: articles);
}
