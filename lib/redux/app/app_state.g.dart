// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'sessionState',
      serializers.serialize(object.sessionState,
          specifiedType: const FullType(SessionState)),
      'loginState',
      serializers.serialize(object.loginState,
          specifiedType: const FullType(LoginState)),
      'postsState',
      serializers.serialize(object.postsState,
          specifiedType: const FullType(PostsState)),
    ];

    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'sessionState':
          result.sessionState = serializers.deserialize(value,
              specifiedType: const FullType(SessionState)) as SessionState;
          break;
        case 'loginState':
          result.loginState.replace(serializers.deserialize(value,
              specifiedType: const FullType(LoginState)) as LoginState);
          break;
        case 'postsState':
          result.postsState.replace(serializers.deserialize(value,
              specifiedType: const FullType(PostsState)) as PostsState);
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final SessionState sessionState;
  @override
  final LoginState loginState;
  @override
  final PostsState postsState;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.sessionState, this.loginState, this.postsState})
      : super._() {
    if (sessionState == null) {
      throw new BuiltValueNullFieldError('AppState', 'sessionState');
    }
    if (loginState == null) {
      throw new BuiltValueNullFieldError('AppState', 'loginState');
    }
    if (postsState == null) {
      throw new BuiltValueNullFieldError('AppState', 'postsState');
    }
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        sessionState == other.sessionState &&
        loginState == other.loginState &&
        postsState == other.postsState;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, sessionState.hashCode), loginState.hashCode),
        postsState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('sessionState', sessionState)
          ..add('loginState', loginState)
          ..add('postsState', postsState))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  SessionState _sessionState;
  SessionState get sessionState => _$this._sessionState;
  set sessionState(SessionState sessionState) =>
      _$this._sessionState = sessionState;

  LoginStateBuilder _loginState;
  LoginStateBuilder get loginState =>
      _$this._loginState ??= new LoginStateBuilder();
  set loginState(LoginStateBuilder loginState) =>
      _$this._loginState = loginState;

  PostsStateBuilder _postsState;
  PostsStateBuilder get postsState =>
      _$this._postsState ??= new PostsStateBuilder();
  set postsState(PostsStateBuilder postsState) =>
      _$this._postsState = postsState;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _sessionState = _$v.sessionState;
      _loginState = _$v.loginState?.toBuilder();
      _postsState = _$v.postsState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              sessionState: sessionState,
              loginState: loginState.build(),
              postsState: postsState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'loginState';
        loginState.build();
        _$failedField = 'postsState';
        postsState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
