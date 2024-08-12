import 'dart:convert';

class PostDataUiModel {
  final String title;
  PostDataUiModel({
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'genre': 'ez',
      'summary': 'yok',
      'article': 'burada yazan hicbirsey aslinda olmadi ez'
    };
  }

  factory PostDataUiModel.fromMap(Map<String, dynamic> map) {
    return PostDataUiModel(
      title: map['title']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostDataUiModel.fromJson(String source) => PostDataUiModel.fromMap(json.decode(source));
}
