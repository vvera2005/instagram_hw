import 'package:dash_chat_2/dash_chat_2.dart';

abstract class ChatService {
  Future<void> createNewChatroom(String uid1, String uid2);
  Future<void> sendMessage(String uid1, String uid2, ChatMessage? message);
  Stream<List<Map<String, dynamic>>> getMessages(String chatId);
}
