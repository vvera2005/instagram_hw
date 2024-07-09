import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../widgets/post_widget.dart';
import '../../widgets/story_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const StoryWidget(username: 'username');
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
  }
}
