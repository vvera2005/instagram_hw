import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../models/chat_model.dart';
import 'chat_sevice.dart';

class ChatServiceImp implements ChatService {
  ChatServiceImp(this._firebaseFirestore, this._firebaseDatabase);

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseDatabase _firebaseDatabase;

  MapEntry<String, dynamic> _convertObjectToMap(Object? key, Object? value) {
    if (key == 'user') {
      return MapEntry<String, dynamic>(
          key.toString(),
          (value as Map<Object?, Object?>?)?.map(
            (key, value) => MapEntry<String, dynamic>(key.toString(), value),
          ));
    }
    return MapEntry<String, dynamic>(key.toString(), value);
  }

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
      String uid1, String uid2, ChatMessage? message) async {
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

  @override
  Stream<List<Map<String, dynamic>>> getMessages(String chatId) async* {
    await for (final event
        in _firebaseDatabase.ref('messages').child(chatId).onValue) {
      final snapshot = event.snapshot;
      if (snapshot.value == null) {
        yield [];
      }

      final messagesMap = snapshot.children.toList();
      yield messagesMap
          .map(
            (e) =>
                (e.value as Map<Object?, Object?>?)
                    ?.map((key, value) => _convertObjectToMap(key, value)) ??
                <String, dynamic>{},
          )
          .toList();
    }
  }
}
   
      
