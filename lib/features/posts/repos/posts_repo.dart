import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app_empty/features/posts/models/post_data_ui_model.dart';

class PostsRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://zenquotes.io/api/quotes'));

      List result = jsonDecode(response.body);



      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post =
            PostDataUiModel.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
      }


      return posts;
    } catch (e) {
      print(e.toString());
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPost() async {
    var client = http.Client();

    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        "title": "Akshit is a Flutter Teacher",
        "body": "Akshit makes good Bloc videos",
        "userId": "34"
      });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
