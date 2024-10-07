import 'package:architecture/core/constants/constants.dart';
import 'package:architecture/core/resources/data_state.dart';
import 'package:architecture/features/daily_news/data/datasources/remote/news_api_service.dart';
import 'package:architecture/features/daily_news/data/models/article.dart';
import 'package:architecture/features/daily_news/domain/entities/article.dart';
import 'package:architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: apiKey,
        country: country,
        category: category,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
