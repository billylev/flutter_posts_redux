import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_state.g.dart';

abstract class LoginState implements Built<LoginState, LoginStateBuilder> {

  bool get isLoading;

  factory LoginState() {
    return _$LoginState._(
        isLoading: false
    );
  }

  LoginState._();
  static Serializer<LoginState> get serializer => _$loginStateSerializer;
}