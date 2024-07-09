import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/user_model.dart';
import 'user_service.dart';

class UserServiceImp implements UserService {
  UserServiceImp(this.firebaseFirestore, this.firebaseStorage);

  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  @override
  Future<void> saveUserToDb(UserModel userModel) async {
    firebaseFirestore
        .collection('users')
        .doc(userModel.uid)
        .update(userModel.toJson());
  }

  @override
  Future<UserModel> getUserFromDb(String uid) async {
    final snapshot = await firebaseFirestore.collection('users').doc(uid).get();
    final userData = UserModel.fromJson(snapshot.data() ?? {});

    return userData;
  }

  @override
  Future<void> uploadProfilePicture(String uid, File file) async {
    final ref = firebaseStorage
        .ref('usersPhotos/')
        .child(Timestamp.now().millisecondsSinceEpoch.toString());

    await ref.putFile(file);

    final downloadUrl = await ref.getDownloadURL();

    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .update({'profilePicture': downloadUrl});
  }
}
