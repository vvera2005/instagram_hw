import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/message_model.dart';
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
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserDataFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error ?? '')));
        }
      },
      builder: (context, userState) {
        return Scaffold(
          appBar: AppBar(
            title: Text('xc'),
          ),
          body: DashChat(
            typingUsers: [],
            messageOptions: const MessageOptions(showCurrentUserAvatar: true),
            inputOptions: const InputOptions(alwaysShowSend: true),
            currentUser: ChatUser(
                id: userState.userEntity?.uid ?? '',
                profileImage: userState.userEntity?.profilePicture,
                firstName: userState.userEntity?.username ?? 'no name'),
            onSend: (data) {
              final message = MessageModel(
                senderId: userState.userEntity?.uid ?? '',
                content: data.text,
              );
              context.read<ChatBloc>().add(SendMessageEvent(
                  uid1: userState.userEntity?.uid ?? 'vera',
                  mesage: message,
                  uid2: widget.uid));
            },
            messages: [],
          ),
        );
      },
    );
  }
}
