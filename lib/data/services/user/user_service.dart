import 'dart:io';

import '../../models/user_model.dart';

abstract class UserService {
  Future<void> saveUserToDb(UserModel userModel);
  Future<UserModel> getUserByIdFromDb(String uid);
  Future<void> uploadProfilePicture(String userId, File file);
  Stream<List<UserModel>> getUsersFromDB();
  Future<void> follow(String uid, String followingId);
}
