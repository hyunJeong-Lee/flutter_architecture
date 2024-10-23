import 'package:architecture/features/daily_news/data/models/article.dart';
import 'package:floor/floor.dart';

//DAO 클래스 생성
@dao
abstract class ArticleDao {
  @Insert()
  Future<void> insertArticle(ArticleModel articleModel);

  @delete
  Future<void> deleteArticle(ArticleModel articleModel);

  @Query('SELECT * FROM article')
  Future<List<ArticleModel>> getArticle();
}
