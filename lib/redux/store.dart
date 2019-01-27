import 'package:flutter_posts_redux/redux/app/app_middleware.dart';
import 'package:flutter_posts_redux/redux/app/app_state.dart';
import 'package:flutter_posts_redux/redux/posts/posts_middleware.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:flutter_posts_redux/redux/app/app_reducer.dart';
import 'package:flutter_posts_redux/redux/login/login_middleware.dart';

Store<AppState> createStore() {
  return Store<AppState>(
      appReducer,
      initialState: AppState(),

      middleware: []
        ..addAll(createLoginMiddleware())
        ..addAll(createAppMiddleware())
        ..addAll(createPostsMiddleware())
        ..addAll([
          LoggingMiddleware.printer(),
        ]));
}