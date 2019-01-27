import 'package:flutter_posts_redux/redux/app/app_actions.dart';
import 'package:flutter_posts_redux/redux/app/app_state.dart';
import 'package:flutter_posts_redux/redux/posts/posts_actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Middleware<AppState>> createAppMiddleware() {
  final sessionStartedState = _createSessionStartedStateMiddleware();

  return [
    new TypedMiddleware<AppState, SessionStarted>(sessionStartedState)
  ];
}

Middleware<AppState> _createSessionStartedStateMiddleware() {
  return (Store<AppState> store, action, NextDispatcher next) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString('login');

    // let the splash show for a bit
    await Future.delayed(const Duration(seconds: 2), () => "");

    // for now if it there its ok
    if (result != null) {
      store.dispatch(SessionAuthenticated());
      store.dispatch(LoadPosts());
    } else {
      store.dispatch(SessionUnAuthenticated());
    }

    next(action);
  };
}