import 'package:architecture/features/daily_news/domain/entities/article.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

// Entity 생성
@Entity(tableName: 'article', primaryKeys: ['id'])
@JsonSerializable()
class ArticleModel extends ArticleEntity {
  const ArticleModel({
    super.id,
    super.author,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
        id: entity.id,
        author: entity.author,
        content: entity.content,
        description: entity.description,
        publishedAt: entity.publishedAt,
        title: entity.title,
        url: entity.url,
        urlToImage: entity.urlToImage);
  }
}
