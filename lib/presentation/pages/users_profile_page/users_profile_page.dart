import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/gaps.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/media/media_bloc.dart';
import '../../logic/post/post_bloc.dart';
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
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostDataFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error ?? '')));
        }
      },
      builder: (context, postState) {
        return BlocConsumer<MediaBloc, MediaState>(
          listener: (context, mediastate) {
            if (mediastate is MediaFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(mediastate.error ?? '')));
            }
          },
          builder: (context, mediastate) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (usercontext, userstate) {
                final postsList = postState.postsList
                    ?.where((post) => post.uid == userstate.otherUserEntity?.uid)
                    .toList();
                return BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authstate) {
                    return Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        title: Text(
                            userstate.otherUserEntity?.username ?? 'undefined'),
                        actions: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.add)),
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
                                backgroundColor:
                                    userstate.otherUserEntity != null
                                        ? null
                                        : Colors.white,
                                backgroundImage:
                                    userstate.otherUserEntity != null
                                        ? CachedNetworkImageProvider(userstate
                                            .otherUserEntity!.profilePicture!)
                                        : null,
                              ),
                              const IntOnStringWidget(
                                  integer: 6, mstr: 'posts'),
                              IntOnStringWidget(
                                  integer: userstate.otherUserEntity
                                          ?.followerList?.length ??
                                      0,
                                  mstr: 'Followers'),
                              IntOnStringWidget(
                                  integer: userstate.otherUserEntity
                                          ?.followingList?.length ??
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
                                onPressed: () {
                                  context.read<UserBloc>().add(FollowEvent(
                                      uid: userstate.userEntity?.uid ?? '',
                                      folloingId: widget.uid));
                                },
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
                          SizedBox(height: Gaps.extraLarge),
                          const Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.grid_on_outlined,
                                size: 30,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              Icon(
                                Icons.person_pin_rounded,
                                size: 30,
                                color: Theme.of(context).colorScheme.onSurface,
                              )
                            ],
                          ),
                          SizedBox(height: Gaps.large),
                          Expanded(
                            child: postState.postsList == null ||
                                    postState.postsList!.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No posts yet',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                    ),
                                    itemCount: postsList?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        child: postsList?[index].postPicture !=
                                                null
                                            ? CachedNetworkImage(
                                                imageUrl: postsList?[index]
                                                        .postPicture ??
                                                    '',
                                                fit: BoxFit.cover,
                                              )
                                            : const Text(
                                                'No Posts Yet',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                      );
                                    },
                                  ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
