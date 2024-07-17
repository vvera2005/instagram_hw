import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';
import 'chat_sevice.dart';

class ChatServiceImp implements ChatSevice {
  ChatServiceImp(this._firebaseFirestore);

 

  final FirebaseFirestore _firebaseFirestore;

  Stream<List<UserModel>> getUsersStream() {
    return _firebaseFirestore.collection('users').snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            final user = UserModel.fromJson(doc.data());
            return user;
          },
        ).toList();
      },
    );
  }
}
