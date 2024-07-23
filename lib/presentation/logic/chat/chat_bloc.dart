import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/message_entity.dart';
import '../../../domain/repositories/chat/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._chatRepository) : super(ChatInitial()) {
    on<CreateChatRoomEvent>(_mapCreateChatRoomEventToState);
    on<SendMessageEvent>(_mapSendMessageEventToState);
    on<GetMessagesEvent>(_mapGetMessagesEventToState);
  }
  final ChatRepository _chatRepository;
  FutureOr<void> _mapCreateChatRoomEventToState(
      CreateChatRoomEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading(state));
      await _chatRepository.createNewChatroom(
          event.uid1 ?? 'knk', event.uid2 ?? 'kuk');
      emit(MessageSent(state));
    } catch (e) {
      emit(ChatFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapSendMessageEventToState(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading(state));
      await _chatRepository.sendMessage(
          event.uid1 ?? 'klkk', event.uid2 ?? ',s,dcn', event.mesage);
      emit(MessageSent(state));
    } catch (e) {
      emit(ChatFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapGetMessagesEventToState(
      GetMessagesEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading(state));
      await for (final List<ChatMessage> messages
          in _chatRepository.getMessages(event.chatId ?? '')) {
        emit(ChatLoaded(state, messages));
      }
    } catch (e) {
      emit(ChatFailed(state, e.toString()));
    }
  }
}
