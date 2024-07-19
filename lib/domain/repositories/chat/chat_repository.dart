import '../../entity/message_entity.dart';

abstract class ChatRepository{
  Future<void> createNewChatroom(String uid1, String uid2);
  Future<void> sendMessage(String uid1, String uid2, MessageEntity? message);
}