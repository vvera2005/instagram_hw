import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../models/chat_model.dart';
import 'chat_sevice.dart';

class ChatServiceImp implements ChatService {
  ChatServiceImp(this._firebaseFirestore, this._firebaseDatabase);

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseDatabase _firebaseDatabase;

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
  Stream<List<Map<String, dynamic>>> getMessages(String chatId) {
    return _firebaseDatabase.ref('messages').child(chatId).onValue.map((event) {
      final snapshot = event.snapshot;
      if (snapshot.value == null) {
        return [];
      }

      final messagesMap = (snapshot.value! as Map).cast<String, dynamic>();
      return messagesMap.entries.map((entry) {
        final value = (entry.value as Map).cast<String, dynamic>();
        return value;
      }).toList();
    });
  }

  // @override
  // Future<List<MessageModel>> getMessages(String chatId) async {
  //   final event = await _firebaseDatabase.ref('messages').child(chatId).once();
  //   return event.snapshot.children
  //       .map(
  //         (e) => MessageModel.fromJson(
  //           Map<String, dynamic>.from(
  //             e.value as Map<dynamic, dynamic>? ?? <String, dynamic>{},
  //           ),
  //         ),
  //       )
  //       .toList();
  // }

  // Stream<List<MessageModel>> onChildAdded(String chatId) async* {
  //   final data = _firebaseDatabase.ref('messages').child(chatId).onChildAdded;
  //   await for (final event in data) {
  //     event.snapshot.children
  //         .map(
  //           (e) => MessageModel.fromJson(
  //             (Map<String, dynamic>.from(
  //               e.value as Map<dynamic, dynamic>? ?? <String, dynamic>{},
  //             ))
  //               ..addAll({'messageId': e.key}),
  //           ),
  //         )
  //         .toList();
  //   }
  // }

  // Future<void> getNewMessages(String chatId) async {
  //   final messagesRef = FirebaseDatabase.instance.ref('messages').child(chatId);
  //   messagesRef.onChildAdded.listen((event) {

  //   });
  // }
}


//  _firebaseDatabase
//         .ref('messages')
//         .child(chatId)
//         .onChildAdded
//         .listen((event) => event.snapshot.children
//             .map(
//               (e) => MessageModel.fromJson(
//                 (Map<String, dynamic>.from(
//                   e.value as Map<dynamic, dynamic>? ?? <String, dynamic>{},
//                 ))
//                   ..addAll({'messageId': e.key}),
//               ),
//             )
//             .toList());
