import 'dart:io';

import '../../models/user_model.dart';

abstract class UserService {
  Future<void> saveUserToDb(UserModel userModel);
  Future<UserModel> getUserFromDb(String uid);
  Future<void> uploadProfilePicture(String userId, File file);
}
