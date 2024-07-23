import 'package:dash_chat_2/dash_chat_2.dart';

import '../../entity/message_entity.dart';

abstract class ChatRepository {
  Future<void> createNewChatroom(String uid1, String uid2);
  Future<void> sendMessage(String uid1, String uid2, ChatMessage? message);
  Stream<List<ChatMessage>> getMessages(String chatId);
}
