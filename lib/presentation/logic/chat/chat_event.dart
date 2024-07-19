part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class CreateChatRoomEvent extends ChatEvent {
  const CreateChatRoomEvent({required this.uid1, required this.uid2});

  final String? uid1;
  final String? uid2;
}

class SendMessageEvent extends ChatEvent {
  const SendMessageEvent(
      {required this.uid1, required this.mesage, required this.uid2});

  final String? uid1;
  final String? uid2;
  final MessageEntity? mesage;
}
