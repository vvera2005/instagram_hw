import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.username, this.description});
  final String username;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 15,
              backgroundColor: Colors.pink,
            ),
            SizedBox(
              width: 12,
            ),
            Text(username),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 400,
          height: 400,
          color: Colors.pink,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.heart_broken)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.comment_rounded)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.ios_share)),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.flag))
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(description ?? "No description"),
      ],
    );
  }
}
