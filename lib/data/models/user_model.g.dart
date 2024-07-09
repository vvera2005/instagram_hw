// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      username: json['username'] as String?,
      name: json['name'] as String?,
      bio: json['bio'] as String?,
      profilePicture: json['profilePicture'] as String?,
      followerList: (json['followerList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      followingList: (json['followingList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      uid: json['uid'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'uid': instance.uid,
      'username': instance.username,
      'name': instance.name,
      'bio': instance.bio,
      'profilePicture': instance.profilePicture,
      'followerList': instance.followerList,
      'followingList': instance.followingList,
    };
