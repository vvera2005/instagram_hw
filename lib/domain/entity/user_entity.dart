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

  final String? email;
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
  final String? profilePicture;
  final List<String>? followerList;
  final List<String>? followingList;
}
