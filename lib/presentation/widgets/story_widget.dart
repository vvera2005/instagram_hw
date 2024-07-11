import 'dart:io';

import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({super.key, required this.username, this.profilePicture});
  final String username;
  final String? profilePicture;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
           CircleAvatar(
            radius: 30,
            backgroundColor: Colors.pink,
            backgroundImage: profilePicture != null ? NetworkImage(profilePicture ?? '') : null,
          ),
          Text(username),
        ],
      ),
    );
  }
}
