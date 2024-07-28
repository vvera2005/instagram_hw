import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/comment_entity.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends CommentEntity {
  CommentModel({
    super.comment, super.postId, super.uid
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
