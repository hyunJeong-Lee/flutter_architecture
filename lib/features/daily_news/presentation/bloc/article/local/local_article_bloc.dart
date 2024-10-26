import 'package:architecture/features/daily_news/domain/usecases/delete_article.dart';
import 'package:architecture/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:architecture/features/daily_news/domain/usecases/save_article.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final DeleteArticleUseCase _deleteArticleUseCase;

  LocalArticleBloc(this._getSavedArticleUseCase, this._saveArticleUseCase,
      this._deleteArticleUseCase)
      : super(const LocalArticleLoading()) {
    on<GetSavedArticles>(onGetSavedArticle);
    on<DeleteArticles>(onDeleteArticle);
    on<SavedArticles>(onSaveArticle);
  }

  void onGetSavedArticle(
      GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    print('LocalArticleBloc onGetSavedArticle');
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  void onDeleteArticle(
      DeleteArticles article, Emitter<LocalArticleState> emit) async {
    print('LocalArticleBloc onDeleteArticle');

    await _deleteArticleUseCase(params: article.article);
    // onDeleteArticle(article, emit);
  }

  void onSaveArticle(
      SavedArticles article, Emitter<LocalArticleState> emit) async {
    print('LocalArticleBloc onSaveArticle');
    await _saveArticleUseCase(params: article.article);
    // onSaveArticle(article, emit);
  }
}
