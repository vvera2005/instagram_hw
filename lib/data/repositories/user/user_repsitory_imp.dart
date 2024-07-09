import '../../../domain/entity/user_entity.dart';
import '../../../domain/repositories/user/user_repsitory.dart';
import '../../services/user/user_service.dart';

class UserRepsitoryImp implements UserRepsitory {
  UserRepsitoryImp(this.userService);

  final UserService userService;
  @override
  Future<void> saveUserToDb(UserEntity userEntity) async {
    userService.saveUserToDb(userEntity.toModel());
  }

  @override
  Future<UserEntity> getUserFromDb(String uid) async{
    return UserEntity.fromModel(await userService.getUserFromDb(uid));
  }
}
