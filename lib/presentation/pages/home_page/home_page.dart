import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/post/post_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../widgets/post_widget.dart';
import '../../widgets/story_widget.dart';
import 'widgets/icon_in_left_side_of_text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<UserBloc>().add(const GetUsersEvent());
    context.read<PostBloc>().add(const GetAllPostsFromDbEvent());
    final uid = context.read<AuthBloc>().state.userCredential?.user?.uid ?? '';
    context.read<UserBloc>().add(GetUserDataByIDEvent(uid: uid));
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
      builder: (context, userstate) {
        if (userstate is UserDataLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Instagram'),
            actions: [
              IconButton(
                onPressed: () => showModalBottomSheet(
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppBar(
                          automaticallyImplyLeading: false,
                          title: const Text('Select Media'),
                          actions: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                        IconInLeftSideOfTextWidget(
                          myicon: Icons.video_collection_outlined,
                          text: 'Reel',
                          onPressed: () {},
                        ),
                        IconInLeftSideOfTextWidget(
                          myicon: Icons.square_outlined,
                          text: 'Post',
                          onPressed: () {
                            Navigator.pushNamed(context, '/add_post');
                          },
                        ),
                        IconInLeftSideOfTextWidget(
                          myicon: Icons.add_circle_outline_outlined,
                          text: 'Story',
                          onPressed: () {},
                        ),
                        IconInLeftSideOfTextWidget(
                          myicon: Icons.highlight_outlined,
                          text: 'Story highlight ',
                          onPressed: () {},
                        ),
                        IconInLeftSideOfTextWidget(
                          myicon: Icons.leak_remove_outlined,
                          text: 'Live ',
                          onPressed: () {},
                        ),
                        IconInLeftSideOfTextWidget(
                          myicon: Icons.menu_book,
                          text: 'Guide',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  context: context,
                ),
                icon: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/chat_home_page');
                },
                icon: const Icon(Icons.messenger_outline),
              ),
            ],
          ),
          body: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostDataFailed) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error ?? '')));
              }
            },
            builder: (context, poststate) {
              return ListView.builder(
                itemCount: (poststate.postsList?.length ?? 0) + 1,
                itemBuilder: (context, index) {
                  return index == 0
                      ? SizedBox(
                          height: 110,
                          child: userstate is UserDataLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: userstate.usersList?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return StoryWidget(
                                      username: userstate
                                              .usersList?[index].username ??
                                          'no name',
                                      profilePicture: userstate
                                          .usersList?[index].profilePicture,
                                    );
                                  },
                                ),
                        )
                      : poststate is PostDataLoading &&
                              userstate is UserDataLoading
                          ? const Center(child: CircularProgressIndicator())
                          : PostWidget(
                              username: userstate.usersList
                                      ?.where((element) =>
                                          element.uid ==
                                          poststate.postsList?[index - 1].uid)
                                      .firstOrNull
                                      ?.username ??
                                  'no username',
                              porfilePhoto: userstate.usersList
                                  ?.where((element) =>
                                      element.uid ==
                                      poststate.postsList?[index - 1].uid)
                                  .firstOrNull
                                  ?.profilePicture,
                              postPhoto:
                                  poststate.postsList?[index - 1].postPicture,
                              description:
                                  poststate.postsList?[index - 1].description,
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    '/users_profile_page',
                                    arguments:
                                        poststate.postsList?[index - 1].uid);
                              },
                            );
                },
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  color: Colors.white,
                ),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                label: 'Search',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.movie_creation_outlined,
                  color: Colors.white,
                ),
                label: 'Reels',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.heart_broken,
                  color: Colors.white,
                ),
                label: 'Likes',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/profile_page');
                  },
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.white,
                  ),
                ),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
