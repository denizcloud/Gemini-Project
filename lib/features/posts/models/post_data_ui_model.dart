import 'dart:convert';

class PostDataUiModel {
  final String title;
  final String genre;
  final String summary;
  final String article;

  PostDataUiModel({
    required this.title,
    required this.genre,
    required this.article,
    required this.summary,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'genre': genre,
      'summary': summary,
      'article': article
    };
  }

  factory PostDataUiModel.fromMap(Map<String, dynamic> map) {
    return PostDataUiModel(
      title: map['title']?.toString() ?? '',
      genre :map['author']?.toString() ?? '',
      summary: map['description']?.toString() ?? '',
      article: map['url']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostDataUiModel.fromJson(String source) => PostDataUiModel.fromMap(json.decode(source));
}
