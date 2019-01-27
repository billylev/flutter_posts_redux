import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'posts.g.dart';

abstract class Posts implements Built<Posts, PostsBuilder> {

  BuiltList<Post> get data;

  factory Posts([updates(PostsBuilder b)]) = _$Posts;

  Posts._();
  static Serializer<Posts> get serializer => _$postsSerializer;
}

abstract class Post implements Built<Post, PostBuilder> {

  String get id;
  String get title;
  String get description;

  @nullable
  String get error;

  factory Post([updates(PostBuilder b)]) = _$Post;

  Post._();
  static Serializer<Post> get serializer => _$postSerializer;
}
