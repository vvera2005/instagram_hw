import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  MessageModel({
    this.content,
    this.senderId,
    this.messageId,
    this.dateTime,
    this.chatUser,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  final String? senderId;
  final String? content;
  final String? messageId;
  final DateTime? dateTime;
  final ChatUser? chatUser;
}
