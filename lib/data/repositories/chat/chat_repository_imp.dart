import 'package:dash_chat_2/dash_chat_2.dart';

import '../../../domain/repositories/chat/chat_repository.dart';
import '../../services/chat/chat_sevice.dart';

class ChatRepositoryImp implements ChatRepository {
  ChatRepositoryImp(this._chatService);

  final ChatService _chatService;
  @override
  Future<void> createNewChatroom(String uid1, String uid2) async {
    await _chatService.createNewChatroom(uid1, uid2);
  }

  @override
  Future<void> sendMessage(
      String uid1, String uid2, ChatMessage? message) async {
    await _chatService.sendMessage(uid1, uid2, message);
  }

  @override
  Stream<List<ChatMessage>> getMessages(String chatId) async* {
    await for (final List<Map<String, dynamic>> data
        in _chatService.getMessages(chatId)) {
      yield data
          .map(
            (e) => ChatMessage.fromJson(e),
          )
          .toList();
    }
  }
}
