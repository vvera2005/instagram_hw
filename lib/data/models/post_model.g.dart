// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      description: json['description'] as String?,
      uid: json['uid'] as String?,
      postPicture: json['postPicture'] as String?,
      postId: json['postId'] as String?,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'postId': instance.postId,
      'postPicture': instance.postPicture,
      'description': instance.description,
    };
