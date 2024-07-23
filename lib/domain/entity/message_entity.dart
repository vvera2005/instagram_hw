import 'dart:core';
import 'package:dash_chat_2/dash_chat_2.dart';

import '../../data/models/message_model.dart';

class MessageEntity {
  const MessageEntity({
    this.senderId,
    this.content,
    this.messageId,
    this.dateTime,
    this.chatUser,
  });

  factory MessageEntity.fromModel(MessageModel model) => MessageEntity(
        senderId: model.senderId,
        content: model.content,
        dateTime: model.dateTime,
        chatUser: model.chatUser,
        messageId: model.messageId,
      );

  MessageModel toModel() {
    return MessageModel(
      senderId: senderId,
      content: content,
      chatUser: chatUser,
      dateTime: dateTime,
      messageId: messageId,
    );
  }

  ChatMessage toChatMessage() {
    return ChatMessage(
        user: chatUser ?? ChatUser(id: '', firstName: 'chka'),
        createdAt: dateTime ?? DateTime.now(),
        text: content ?? 'chi ynkni context');
  }

  final String? senderId;
  final String? content;
  final String? messageId;
  final DateTime? dateTime;
  final ChatUser? chatUser;
}
