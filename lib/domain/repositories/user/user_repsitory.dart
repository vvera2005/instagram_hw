import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../entity/user_entity.dart';

abstract class UserRepsitory {
  Future<void> saveUserToDb(UserEntity userEntity);
  Future<UserEntity> getUserFromDb(String uid);
  Future<void> uploadProfilePicture(String userId, File file);
 Stream<List<UserEntity>> getUsersFromDB();

}
