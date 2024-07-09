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

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('uid', instance.uid);
  writeNotNull('username', instance.username);
  writeNotNull('name', instance.name);
  writeNotNull('bio', instance.bio);
  writeNotNull('profilePicture', instance.profilePicture);
  writeNotNull('followerList', instance.followerList);
  writeNotNull('followingList', instance.followingList);
  return val;
}
