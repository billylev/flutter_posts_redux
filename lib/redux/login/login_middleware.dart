
import 'dart:convert';
import 'package:flutter_posts_redux/model/serializers.dart';
import 'package:flutter_posts_redux/redux/app/app_actions.dart';
import 'package:flutter_posts_redux/redux/app/app_state.dart';
import 'package:flutter_posts_redux/redux/login/login_actions.dart';
import 'package:flutter_posts_redux/api/auth_api.dart';
import 'package:flutter_posts_redux/redux/posts/posts_actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Middleware<AppState>> createLoginMiddleware() {
  final logIn = _createLogInMiddleware();
  final logOut = _createLogOutMiddleware();

  return [
    new TypedMiddleware<AppState, LogIn>(logIn),
    new TypedMiddleware<AppState, LogOut>(logOut)
  ];
}

Middleware<AppState> _createLogInMiddleware() {
  return (Store<AppState> store, action, NextDispatcher next) async {

    if (store.state.loginState.isLoading) {
      return;
    }

    store.dispatch(LogInRequested());

    try {

      AuthApi authApi = AuthApi();
      var result = await authApi.loginEnum(action.username, action.password);

      if (result != null) {
        // store the login tokens
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('login', jsonEncode(serializers.serialize(result)));
        // login success
        store.dispatch(LogInSuccessful());
        store.dispatch(SessionAuthenticated());
        // load posts
        store.dispatch(LoadPosts());
        action.completer?.complete(null);
      }
    }
    catch (error) {
      store.dispatch(new LogInFail());
      action.completer?.complete(error);
    }

    next(action);
  };
}

Middleware<AppState> _createLogOutMiddleware() {
  return (Store<AppState> store, action, NextDispatcher next) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('login');

    store.dispatch(SessionUnAuthenticated());

    next(action);
  };
}