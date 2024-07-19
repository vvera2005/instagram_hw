import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatTileWidget extends StatelessWidget {
  const ChatTileWidget({super.key, this.imgUrl, required this.username, this.onPressed});
  final String? imgUrl;
  final String username;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            imgUrl != null ? CachedNetworkImageProvider(imgUrl!) : null,
        backgroundColor: Colors.white,
        child: imgUrl == null
            ? Text(username[0])
            : null,
      ),
      onTap: onPressed,
      title: Text(username),
    );
  }
}
