import 'package:flutter_posts_redux/redux/posts/posts_actions.dart';
import 'package:flutter_posts_redux/redux/posts/posts_state.dart';
import 'package:redux/redux.dart';

Reducer<PostsState> postsReducer = combineReducers([
  TypedReducer<PostsState, LoadPostsRequested>(_loadPostsRequestedReducer),
  TypedReducer<PostsState, LoadPostsFail>(_loadPostsFailReducer),
  TypedReducer<PostsState, LoadPostsSuccessful>(_loadPostsSuccessfulReducer)
]);

PostsState _loadPostsRequestedReducer(PostsState postState, LoadPostsRequested action) {
  return postState.rebuild((b) => b
      ..isLoading = true
    );
}

PostsState _loadPostsFailReducer(PostsState postState, LoadPostsFail action) {
  return postState.rebuild((b) => b
    ..isLoading = false
  );
}

PostsState _loadPostsSuccessfulReducer(PostsState postState, LoadPostsSuccessful action) {
  return postState.rebuild((b) => b
    ..isLoading = false
    ..list.replace(action.posts.data)
  );
}