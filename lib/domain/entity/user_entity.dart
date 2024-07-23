import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/models/user_model.dart';

class UserEntity {
  UserEntity(
      {this.username,
      this.name,
      this.bio,
      this.profilePicture,
      this.followerList,
      this.followingList,
      this.email,
      this.uid});

  factory UserEntity.fromModel(UserModel userModel) => UserEntity(
        email: userModel.email,
        username: userModel.username,
        name: userModel.name,
        uid: userModel.uid,
        bio: userModel.bio,
        profilePicture: userModel.profilePicture,
        followerList: userModel.followerList,
        followingList: userModel.followingList,
      );
  UserModel toModel() => UserModel(
        email: email,
        uid: uid,
        bio: bio,
        profilePicture: profilePicture,
        followerList: followerList,
        followingList: followingList,
        username: username,
        name: name,
      );
  ChatUser toChatUser() {
    return ChatUser(
      id: uid ?? '',
      profileImage: profilePicture,
      firstName: name,
    );
  }

  @JsonKey(includeIfNull: false)
  final String? email;
  @JsonKey(includeIfNull: false)
  final String? uid;
  @JsonKey(includeIfNull: false)
  final String? username;
  @JsonKey(includeIfNull: false)
  final String? name;
  @JsonKey(includeIfNull: false)
  final String? bio;
  @JsonKey(includeIfNull: false)
  final String? profilePicture;
  @JsonKey(includeIfNull: false)
  final List<String>? followerList;
  @JsonKey(includeIfNull: false)
  final List<String>? followingList;
}
