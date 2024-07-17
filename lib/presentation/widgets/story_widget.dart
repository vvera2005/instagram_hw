import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget(
      {super.key, required this.username, this.profilePicture, this.onPressed});
  final String username;
  final String? profilePicture;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.pink,
          backgroundImage: profilePicture != null
              ? CachedNetworkImageProvider(
                  profilePicture!,
                )
              : null,
          child: profilePicture == null ? Text(username[0]) : null,
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              username,
              style: const TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
