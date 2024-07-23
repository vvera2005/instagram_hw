import 'dart:core';

import '../../data/models/chat_model.dart';
import 'message_entity.dart';

class ChatEntity {
  const ChatEntity({this.chatId, this.participantsId, this.lastMessage});

  factory ChatEntity.fromModel(ChatModel model) => ChatEntity(
        chatId: model.chatId,
        participantsId: model.participantsId,
        lastMessage: model.lastMessage != null
            ? MessageEntity.fromModel(model.lastMessage!)
            : null,
      );

  ChatModel toModel() {
    return ChatModel(
      chatId: chatId,
      participantsId: participantsId,
      lastMessage: lastMessage?.toModel(),
    );
  }

  final String? chatId;
  final List<String>? participantsId;
  final MessageEntity? lastMessage;
}
