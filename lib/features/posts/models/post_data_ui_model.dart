import 'dart:convert';

class PostDataUiModel {
  final String q;
  final String a;
  final String c;
  PostDataUiModel({
    required this.q,
    required this.a,
    required this.c,
  });

  Map<String, dynamic> toMap() {
    return {
      'q': q,
      'a': a,
      'c': c,
    };
  }

  factory PostDataUiModel.fromMap(Map<String, dynamic> map) {
    return PostDataUiModel(
      q: map['q']?.toString() ?? '',
      a: map['a']?.toString() ?? '',
      c: map['c']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostDataUiModel.fromJson(String source) => PostDataUiModel.fromMap(json.decode(source));
}
