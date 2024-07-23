// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      content: json['content'] as String?,
      senderId: json['senderId'] as String?,
      messageId: json['messageId'] as String?,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      chatUser: json['chatUser'] == null
          ? null
          : ChatUser.fromJson(json['chatUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'content': instance.content,
      'messageId': instance.messageId,
      'dateTime': instance.dateTime?.toIso8601String(),
      'chatUser': instance.chatUser,
    };
