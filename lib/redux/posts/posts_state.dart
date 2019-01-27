import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_posts_redux/model/posts.dart';

part 'posts_state.g.dart';

abstract class PostsState implements Built<PostsState, PostsStateBuilder> {

  BuiltList<Post> get list;
  bool get isLoading;

  @nullable
  String get error;

  factory PostsState() {
    return _$PostsState._(
        list: BuiltList<Post>(),
        isLoading: false
    );
  }

  PostsState._();
  static Serializer<PostsState> get serializer => _$postsStateSerializer;
}