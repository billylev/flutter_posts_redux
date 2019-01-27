import 'package:flutter_posts_redux/redux/login/login_actions.dart';
import 'package:flutter_posts_redux/redux/login/login_state.dart';
import 'package:redux/redux.dart';

Reducer<LoginState> loginReducer = combineReducers([
  TypedReducer<LoginState, LogInRequested>(_logInRequestedReducer),
  TypedReducer<LoginState, LogInFail>(_logInFailReducer),
  TypedReducer<LoginState, LogInSuccessful>(_logInSuccessfulReducer)
]);

LoginState _logInRequestedReducer(LoginState loginState, LogInRequested action) {
  return loginState.rebuild((b) => b
    ..isLoading = true);
}

LoginState _logInFailReducer(LoginState loginState, LogInFail action) {
  return loginState.rebuild((b) => b
    ..isLoading = false);
}

LoginState _logInSuccessfulReducer(LoginState loginState, LogInSuccessful action) {
  return loginState.rebuild((b) => b
    ..isLoading = false);
}

