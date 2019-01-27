import 'dart:async';

import 'package:flutter_posts_redux/model/posts.dart';

//
// middleware
//

class LoadPosts {
  final Completer<dynamic> completer;
  LoadPosts([this.completer]);
}

//
// actions
//

class LoadPostsRequested {}

class LoadPostsSuccessful {
  final Posts posts;
  LoadPostsSuccessful(this.posts);
}

class LoadPostsFail {}