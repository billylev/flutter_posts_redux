// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Session> _$sessionSerializer = new _$SessionSerializer();

class _$SessionSerializer implements StructuredSerializer<Session> {
  @override
  final Iterable<Type> types = const [Session, _$Session];
  @override
  final String wireName = 'Session';

  @override
  Iterable serialize(Serializers serializers, Session object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'access_token',
      serializers.serialize(object.access_token,
          specifiedType: const FullType(String)),
      'refresh_token',
      serializers.serialize(object.refresh_token,
          specifiedType: const FullType(String)),
      'expires_in',
      serializers.serialize(object.expires_in,
          specifiedType: const FullType(int)),
    ];
    if (object.error != null) {
      result
        ..add('error')
        ..add(serializers.serialize(object.error,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Session deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SessionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'access_token':
          result.access_token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'refresh_token':
          result.refresh_token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expires_in':
          result.expires_in = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'error':
          result.error = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Session extends Session {
  @override
  final String access_token;
  @override
  final String refresh_token;
  @override
  final int expires_in;
  @override
  final String error;

  factory _$Session([void updates(SessionBuilder b)]) =>
      (new SessionBuilder()..update(updates)).build();

  _$Session._(
      {this.access_token, this.refresh_token, this.expires_in, this.error})
      : super._() {
    if (access_token == null) {
      throw new BuiltValueNullFieldError('Session', 'access_token');
    }
    if (refresh_token == null) {
      throw new BuiltValueNullFieldError('Session', 'refresh_token');
    }
    if (expires_in == null) {
      throw new BuiltValueNullFieldError('Session', 'expires_in');
    }
  }

  @override
  Session rebuild(void updates(SessionBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionBuilder toBuilder() => new SessionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Session &&
        access_token == other.access_token &&
        refresh_token == other.refresh_token &&
        expires_in == other.expires_in &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, access_token.hashCode), refresh_token.hashCode),
            expires_in.hashCode),
        error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Session')
          ..add('access_token', access_token)
          ..add('refresh_token', refresh_token)
          ..add('expires_in', expires_in)
          ..add('error', error))
        .toString();
  }
}

class SessionBuilder implements Builder<Session, SessionBuilder> {
  _$Session _$v;

  String _access_token;
  String get access_token => _$this._access_token;
  set access_token(String access_token) => _$this._access_token = access_token;

  String _refresh_token;
  String get refresh_token => _$this._refresh_token;
  set refresh_token(String refresh_token) =>
      _$this._refresh_token = refresh_token;

  int _expires_in;
  int get expires_in => _$this._expires_in;
  set expires_in(int expires_in) => _$this._expires_in = expires_in;

  String _error;
  String get error => _$this._error;
  set error(String error) => _$this._error = error;

  SessionBuilder();

  SessionBuilder get _$this {
    if (_$v != null) {
      _access_token = _$v.access_token;
      _refresh_token = _$v.refresh_token;
      _expires_in = _$v.expires_in;
      _error = _$v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Session other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Session;
  }

  @override
  void update(void updates(SessionBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Session build() {
    final _$result = _$v ??
        new _$Session._(
            access_token: access_token,
            refresh_token: refresh_token,
            expires_in: expires_in,
            error: error);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
