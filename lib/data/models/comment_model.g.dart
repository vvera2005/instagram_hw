// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      comment: json['comment'] as String?,
      postId: json['postId'] as String?,
      uid: json['uid'] as String?,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'uid': instance.uid,
      'comment': instance.comment,
    };
