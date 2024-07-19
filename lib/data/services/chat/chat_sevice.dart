import '../../models/message_model.dart';

abstract class ChatService {
  Future<void> createNewChatroom(String uid1, String uid2);
  Future<void> sendMessage(String uid1, String uid2, MessageModel? message);
}
