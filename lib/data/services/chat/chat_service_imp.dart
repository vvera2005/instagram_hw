import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_sevice.dart';

class ChatServiceImp implements ChatSevice {
  ChatServiceImp(this._firebaseFirestore);

 

  final FirebaseFirestore _firebaseFirestore;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firebaseFirestore.collection('users').snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            final user = doc.data();
            return user;
          },
        ).toList();
      },
    );
  }
}
