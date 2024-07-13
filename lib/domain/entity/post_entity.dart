import 'dart:core';

import '../../data/models/post_model.dart';

class PostEntity {
  const PostEntity({this.uid, this.postPicture, this.description, this.postId});

  factory PostEntity.fromModel(PostModel model) => PostEntity(
        uid: model.uid,
        postPicture: model.postPicture,
        description: model.description,
      );

  PostModel toModel() {
    return PostModel(
      postId: postId,
      uid: uid,
      postPicture: postPicture,
      description: description,
    );
  }

  final String? uid;
  final String? postId;
  final String? postPicture;
  final String? description;
}
