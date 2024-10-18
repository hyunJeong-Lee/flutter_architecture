// DB 에서 기사를 표시할 bloc

import 'package:architecture/core/resources/data_state.dart';
import 'package:architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticleBloc(this._getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    // state : Loading 상태로 초기화
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data)); // 설공 시 state : Done
    }

    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error)); // 실패 시 state : Error
    }
  }
}
