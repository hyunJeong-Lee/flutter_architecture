import 'package:architecture/features/daily_news/domain/entities/article.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

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

  // {
  //   return ArticleModel(
  //     author: json['author'] ?? "",
  //     title: json['title'] ?? "",
  //     description: json['description'] ?? "",
  //     url: json['url'] ?? "",
  //     urlToImage: json['urlToImage'] ?? "",
  //     publishedAt: json['publishedAt'] ?? "",
  //     content: json['content'] ?? "",
  //   );
  // }
}
