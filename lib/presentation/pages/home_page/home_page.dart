import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../widgets/post_widget.dart';
import '../../widgets/story_widget.dart';

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
          return const CircularProgressIndicator();
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text('Instagram'),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.messenger_outline),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return index == 0
                    ? SizedBox(
                        height: 100,
                        child: userstate is UserDataLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: userstate.usersList?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return StoryWidget(
                                    username:
                                        userstate.usersList?[index].username ??
                                            'no name',
                                    profilePicture: userstate
                                        .usersList?[index].profilePicture,
                                  );
                                },
                              ),
                      )
                    : const PostWidget(username: 'username');
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
                  label: 'likes',
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
            ));
      },
    );
  }
}
