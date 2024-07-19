// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      chatId: json['chatId'] as String?,
      participantsId: (json['participantsId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastMessage: json['lastMessage'] == null
          ? null
          : MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'chatId': instance.chatId,
      'participantsId': instance.participantsId,
      'lastMessage': instance.lastMessage,
    };
