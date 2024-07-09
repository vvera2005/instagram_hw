import 'dart:io';

import '../../entity/user_entity.dart';

abstract class UserRepsitory {
  Future<void> saveUserToDb(UserEntity userEntity);
  Future<UserEntity> getUserFromDb(String uid);
  Future<void> uploadProfilePicture(String userId, File file);

}
