import 'dart:convert';

import 'package:flutter_posts_redux/api/web_client.dart';
import 'package:flutter_posts_redux/model/posts.dart';
import 'package:flutter_posts_redux/model/serializers.dart';

class PostApi {
  final WebClient webClient;

  const PostApi({
    this.webClient = const WebClient(),
  });

  Future<Posts> getPosts() async {

    final response = await webClient.get('posts');

    try {
      return serializers.deserializeWith(
          Posts.serializer, response);
    }
    catch (error) {
      print(error);
    }

    return null;
  }

  // just for demo purposes, doesnt call a real api. Use getposts above to do that
  Future<Posts> getPostsEnum() async {

    final body = """
      {
			"data": [
              {
                "id": "B8DC099F-C477-4619-8650-19901383DE87",
                "title": "post one",
                "description": "description one"
              },
              {
                "id": "B8DC099F-C477-4619-8650-19901383DE88",
                "title": "post two",
                "description": "description two"
              },
              {
                "id": "B8DC099F-C477-4619-8650-19901383DE89",
                "title": "post three",
                "description": "description three"
              },
              {
                "id": "B8DC099F-C477-4619-8650-19901383DE90",
                "title": "post four",
                "description": "description four"
              },
              {
                "id": "B8DC099F-C477-4619-8650-19901383DE91",
                "title": "post five",
                "description": "description five"
              }
            ]
		  }""";

    // wait to simulate web call
    await Future.delayed(Duration(seconds: 2));

    final sessionMap = json.decode(body);

    return serializers.deserializeWith(
        Posts.serializer, sessionMap);
  }
}