import '../../entity/user_entity.dart';

abstract class UserRepsitory {
  Future<void> saveUserToDb(UserEntity userEntity);
  Future<UserEntity> getUserFromDb(String uid);
}
