import 'package:flutter_posts_redux/redux/app/app_state.dart';
import 'package:flutter_posts_redux/redux/posts/posts_actions.dart';
import 'package:flutter_posts_redux/api/posts_api.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createPostsMiddleware() {
  final loadPosts = _createLoadPostsMiddleware();

  return [
    new TypedMiddleware<AppState, LoadPosts>(loadPosts)
  ];
}

Middleware<AppState> _createLoadPostsMiddleware() {
  return (Store<AppState> store, action, NextDispatcher next) async {

    // already loading, do nothing
    if (!store.state.postsState.isLoading) {

      // starting to load posts
      store.dispatch(LoadPostsRequested());

      try {
        PostApi authApi = PostApi();
        var result = await authApi.getPostsEnum();

        if (result != null) {
          // posts are loaded
          store.dispatch(LoadPostsSuccessful(result));
          action.completer?.complete(null);
        }
      }
      catch (error) {
        // errored
        store.dispatch(new LoadPostsFail());
        action.completer?.complete(error);
      }
    }

    next(action);
  };
}