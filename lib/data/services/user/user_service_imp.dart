import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';
import 'user_service.dart';

class UserServiceImp implements UserService {
  UserServiceImp(this.firebaseFirestore);

  final FirebaseFirestore firebaseFirestore;
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
}
