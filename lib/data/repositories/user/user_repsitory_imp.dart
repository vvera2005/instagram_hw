import 'dart:io';

import '../../../domain/entity/user_entity.dart';
import '../../../domain/repositories/user/user_repsitory.dart';
import '../../models/user_model.dart';
import '../../services/user/user_service.dart';

class UserRepsitoryImp implements UserRepsitory {
  UserRepsitoryImp(this.userService);

  final UserService userService;
  @override
  Future<void> saveUserToDb(UserEntity userEntity) async {
    userService.saveUserToDb(userEntity.toModel());
  }

  @override
  Future<UserEntity> getUserFromDb(String uid) async {
    return UserEntity.fromModel(await userService.getUserByIdFromDb(uid));
  }

  @override
  Future<void> uploadProfilePicture(String userId, File file) {
    return userService.uploadProfilePicture(userId, file);
  }

  @override
  Stream<List<UserEntity>> getUsersFromDB() async* {
    await for (final List<UserModel> models in userService.getUsersFromDB()) {
      yield models.map((e) => UserEntity.fromModel(e)).toList();
      
    }
    
  }
}
