import 'package:architecture/features/daily_news/domain/entities/article.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? error;

  const RemoteArticleState({this.articles, this.error});

  @override
  List<Object?> get props => [articles!, error!];
}

// 서버에 요청을 보내고 서버가 응답을 기다리는 상태
class RemoteArticlesLoading extends RemoteArticleState {
  const RemoteArticlesLoading();
}

// 데이터가 수신됐을때
class RemoteArticlesDone extends RemoteArticleState {
  const RemoteArticlesDone(List<ArticleEntity>? article)
      : super(articles: article);
}

// 데이터 수신 오류
class RemoteArticlesError extends RemoteArticleState {
  const RemoteArticlesError(DioException? error) : super(error: error);
}
