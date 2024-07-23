import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/gaps.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/chat/chat_bloc.dart';
import '../../logic/user/user_bloc.dart';
import 'widgets/chat_tile_widget.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  @override
  void initState() {
    super.initState();
    if (mounted && context.read<UserBloc>().state.userEntity == null) {
      final uid =
          context.read<AuthBloc>().state.userCredential?.user?.uid ?? '';
      context.read<UserBloc>().add(GetUserDataByIDEvent(uid: uid));
    }
  }

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
        final usersList = userState.usersList
            ?.where(
              (element) => element.uid != userState.userEntity?.uid,
            )
            .toList();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              userState.userEntity?.username ?? 'no username',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: SafeArea(
              child: Padding(
                  padding: EdgeInsets.all(Gaps.large),
                  child: ListView.builder(
                    itemCount: usersList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ChatTileWidget(
                        username: usersList?[index].username ?? 'nu username',
                        imgUrl: usersList?[index].profilePicture,
                        onPressed: () {
                          final uids = [
                            userState.userEntity?.uid,
                            usersList?[index].uid
                          ];
                          uids.sort();
                          final chatId = uids.fold('', (id, uid) => '$id$uid');
                          context.read<ChatBloc>().add(CreateChatRoomEvent(
                              uid1: userState.userEntity?.uid,
                              uid2: usersList?[index].uid));
                          context
                              .read<ChatBloc>()
                              .add(GetMessagesEvent(chatId: chatId));
                          Navigator.of(context).pushNamed('/chat_page',
                              arguments: usersList?[index].uid);
                        },
                      );
                    },
                  ))),
        );
      },
    );
  }
}
