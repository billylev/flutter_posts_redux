import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:flutter_posts_redux/model/posts.dart';
import 'package:flutter_posts_redux/model/session.dart';
import 'package:flutter_posts_redux/redux/login/login_state.dart';
import 'package:flutter_posts_redux/redux/posts/posts_state.dart';
import 'package:built_collection/built_collection.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  LoginState,
  Session,
  Posts,
  Post,
  PostsState
])
final Serializers serializers =
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
