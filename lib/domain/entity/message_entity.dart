import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/message_model.dart';
import '../../data/models/post_model.dart';

class MessageEntity {
  const MessageEntity({
    this.senderId,
    this.content,
    
  });

  factory MessageEntity.fromModel(MessageModel model) => MessageEntity(
    senderId: model.senderId,
    content: model.content,
  );

  MessageModel toModel() {
    return MessageModel(
      senderId: senderId,
      content: content,
    );
  }

  final String? senderId;
  final String? content;
}
