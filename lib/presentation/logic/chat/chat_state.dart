part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState({
    this.messages,
    this.error,
  });
  final List<MessageEntity>? messages;
  final String? error;
  @override
  List<Object?> get props => [messages, error];
}

final class ChatInitial extends ChatState {}

final class MessageSent extends ChatState {
  MessageSent(ChatState initialState) : super(messages: initialState.messages);
}

final class ChatLoading extends ChatState {
  ChatLoading(ChatState initialState) : super(messages: initialState.messages);
}

final class ChatLoaded extends ChatState {
  ChatLoaded(ChatState initialState, List<MessageEntity>? messages)
      : super(messages: messages);
}

final class ChatFailed extends ChatState {
  ChatFailed(ChatState initialState, String? error)
      : super(messages: initialState.messages, error: error);
}
