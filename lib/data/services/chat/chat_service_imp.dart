import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../models/chat_model.dart';
import '../../models/message_model.dart';
import 'chat_sevice.dart';

class ChatServiceImp implements ChatService {
  ChatServiceImp(this._firebaseFirestore, this._firebaseDatabase);

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseDatabase _firebaseDatabase;

  // Future<bool> chaeckChatExits(String uid1, String uid2) async {
  //   final uids = [uid1, uid2];
  //   uids.sort();
  //   final chatId = uids.fold('', (id, uid) => '$id$uid');
  //   final result = _firebaseFirestore.collection('chat').doc(chatId).get;
  //   if (result != null) {
  //     return true;
  //   }
  //   return false;
  // }
  @override
  Future<void> createNewChatroom(String uid1, String uid2) async {
    final uids = [uid1, uid2];
    uids.sort();
    final chatId = uids.fold('', (id, uid) => '$id$uid');
    final docRef = _firebaseFirestore.collection('chat').doc(chatId);
    final docSnapshot =
        await _firebaseFirestore.collection('chat').doc(chatId).get();
    if (docSnapshot.exists) {
      await docRef.update(ChatModel(
        chatId: chatId,
        participantsId: uids,
      ).toJson());
    } else {
      await docRef.set(ChatModel(
        chatId: chatId,
        participantsId: uids,
      ).toJson());
    }
  }

  @override
  Future<void> sendMessage(
      String uid1, String uid2, MessageModel? message) async {
    final uids = [uid1, uid2];
    uids.sort();
    final chatId = uids.fold('', (id, uid) => '$id$uid');
    await _firebaseFirestore.collection('chat').doc(chatId).update({
      'lastMessage': message?.toJson(),
    });

    await _firebaseDatabase
        .ref('messages')
        .child(chatId)
        .push()
        .set(message?.toJson());
  }
}
