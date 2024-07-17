import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/media/media_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../profile_page/widgets/int_on_string_widget.dart';

class UsersProfilePage extends StatefulWidget {
  const UsersProfilePage({super.key, required this.uid});
  final String uid;
  @override
  State<UsersProfilePage> createState() => _UsersProfilePageState();
}

class _UsersProfilePageState extends State<UsersProfilePage> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<UserBloc>().add(GetOtherUserDataByIDEvent(uid: widget.uid));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaBloc, MediaState>(
      listener: (context, mediastate) {
        if (mediastate is MediaFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(mediastate.error ?? '')));
        }
      },
      builder: (context, mediastate) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (usercontext, userstate) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authstate) {
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Text(
                        userstate.otherUserEntity?.username ?? 'undefined'),
                    actions: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.menu)),
                    ],
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: userstate.otherUserEntity != null
                                ? null
                                : Colors.white,
                            backgroundImage: userstate.otherUserEntity != null
                                ? NetworkImage(
                                    userstate.otherUserEntity!.profilePicture ??
                                        '')
                                : null,
                          ),
                          const IntOnStringWidget(integer: 6, mstr: 'posts'),
                          IntOnStringWidget(
                              integer: userstate
                                      .otherUserEntity?.followerList?.length ??
                                  0,
                              mstr: 'Followers'),
                          IntOnStringWidget(
                              integer: userstate
                                      .otherUserEntity?.followingList?.length ??
                                  0,
                              mstr: 'Followwing'),
                        ],
                      ),
                      Text(
                        userstate.otherUserEntity?.name ?? ' no name',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        userstate.otherUserEntity?.bio ?? ' no bio',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {},
                            child: const Text('Follow'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {},
                            child: const Text('Message'),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {},
                              child: IconButton(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                color: Colors.black,
                                onPressed: () {},
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
