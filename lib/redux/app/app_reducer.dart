import 'package:flutter_posts_redux/redux/app/app_actions.dart';
import 'package:flutter_posts_redux/redux/app/app_state.dart';
import 'package:flutter_posts_redux/redux/login/login_reducer.dart';
import 'package:flutter_posts_redux/redux/posts/posts_reducer.dart';
import 'package:redux/redux.dart';


AppState appReducer(AppState state, dynamic action) {
  return state.rebuild((b) => b
    ..sessionState = sessionReducers(state.sessionState, action)
    ..loginState.replace(loginReducer(state.loginState, action))
    ..postsState.replace(postsReducer(state.postsState, action))
  );
}

final sessionReducers = combineReducers<SessionState>([
  TypedReducer<SessionState, SessionAuthenticated>(_setAuthenticated),
  TypedReducer<SessionState, SessionUnAuthenticated>(_setUnAuthenticated),
]);

SessionState _setAuthenticated(SessionState state, action) {
  return SessionState.Authenticated;
}

SessionState _setUnAuthenticated(SessionState state, action) {
  return SessionState.UnAuthenticated;
}