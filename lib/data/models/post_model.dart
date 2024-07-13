import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/post_entity.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends PostEntity {
  PostModel({
    super.description,
    super.uid,
    super.postPicture,
    super.postId,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
