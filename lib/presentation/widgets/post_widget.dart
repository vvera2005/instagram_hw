import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(
      {super.key,
      required this.username,
      this.description,
      this.porfilePhoto,
      this.postPhoto});
  final String username;
  final String? description;
  final String? porfilePhoto;
  final String? postPhoto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.pink,
              backgroundImage:
                  porfilePhoto != null ? NetworkImage(porfilePhoto!) : null,
            ),
            const SizedBox(
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
          child: postPhoto != null ? Image.network(postPhoto!) : null,
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
        Text(description ?? 'No description'),
      ],
    );
  }
}
