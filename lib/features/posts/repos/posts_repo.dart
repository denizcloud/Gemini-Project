import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app_empty/features/posts/models/post_data_ui_model.dart';

class PostsRepo {

  static String api_key = "3fca12e8720a441b8af936d0cbe15837";

  static String url = ("https://newsapi.org/v2/top-headlines?country=us&apiKey=$api_key");


  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client.get(Uri.parse(url));
      var result = jsonDecode(response.body);

      if (result['status'] == 'ok'){
        for (int i = 0; i < result['articles'].length; i++) {
          PostDataUiModel post =
              PostDataUiModel.fromMap(result['articles'][i] as Map<String, dynamic>);
          posts.add(post);
        }
      }

      return posts;
    } catch (e) {
      print(e.toString());
      log(e.toString());
      return [];
    }
  }

}
