import 'package:json_annotation/json_annotation.dart';

import 'message_model.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  ChatModel({
    this.chatId,
    this.participantsId,
    this.lastMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  final String? chatId;
  final List<String>? participantsId;
  final MessageModel? lastMessage;

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
