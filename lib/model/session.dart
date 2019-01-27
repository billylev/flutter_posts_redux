import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'session.g.dart';

abstract class Session implements Built<Session, SessionBuilder> {

  String get access_token; // ignore: non_constant_identifier_names
  String get refresh_token;
  int get expires_in;

  @nullable
  String get error;

  factory Session([updates(SessionBuilder b)]) = _$Session;

  Session._();
  static Serializer<Session> get serializer => _$sessionSerializer;
}