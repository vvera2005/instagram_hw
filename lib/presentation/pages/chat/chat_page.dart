import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/message_entity.dart';
import '../../logic/chat/chat_bloc.dart';
import '../../logic/user/user_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.uid});
  final String uid;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error ?? '')));
        }
      },
      builder: (context, chatState) {
        return BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserDataFailed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error ?? '')));
            }
          },
          builder: (context, userState) {
            final currrentUser = ChatUser(
                id: userState.userEntity?.uid ?? '',
                profileImage: userState.userEntity?.profilePicture,
                firstName: userState.userEntity?.username ?? 'no name');

            final otherUser = ChatUser(
                id: widget.uid,
                profileImage: userState.usersList
                    ?.where(
                      (element) => element.uid == widget.uid,
                    )
                    .first
                    .profilePicture,
                firstName: userState.usersList
                    ?.where(
                      (element) => element.uid == widget.uid,
                    )
                    .first
                    .name);

            return Scaffold(
              appBar: AppBar(
                title: Text(otherUser.firstName ?? 'no name'),
              ),
              body: DashChat(
                messageOptions:
                    const MessageOptions(showCurrentUserAvatar: true),
                inputOptions: const InputOptions(
                    inputTextStyle: TextStyle(color: Colors.black)),
                currentUser: currrentUser,
                onSend: (data) {
                  final message = data;
                  context.read<ChatBloc>().add(SendMessageEvent(
                      uid1: userState.userEntity?.uid ?? 'vera',
                      mesage: message,
                      uid2: widget.uid));
                },
                messages: chatState.messages ??
                    [
                      ChatMessage(
                          user: currrentUser,
                          createdAt: DateTime.now(),
                          text: 'Of eli chexav')
                    ],
              ),
            );
          },
        );
      },
    );
  }
}
