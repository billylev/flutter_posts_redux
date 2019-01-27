import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_posts_redux/redux/login/login_state.dart';
import 'package:flutter_posts_redux/redux/posts/posts_state.dart';

part 'app_state.g.dart';

enum SessionState {Uninitialized, Authenticated, UnAuthenticated}

abstract class AppState implements Built<AppState, AppStateBuilder> {
  SessionState get sessionState;
  LoginState get loginState;
  PostsState get postsState;

  factory AppState() {
    return _$AppState._(
        sessionState: SessionState.Uninitialized,
        loginState: LoginState(),
        postsState: PostsState()
    );
  }

  AppState._();
  static Serializer<AppState> get serializer => _$appStateSerializer;

}
