import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/comment_entity.dart';
import '../logic/post/post_bloc.dart';
import '../logic/user/user_bloc.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(
      {super.key,
      required this.username,
      required this.userState,
      // required this.postState,
      this.postId,
      this.description,
      this.porfilePhoto,
      this.postPhoto,
      this.onPressed});
  final String username;
  final String? description;
  final String? porfilePhoto;
  final String? postPhoto;
  final String? postId;
  final UserState userState;
  // final PostState postState;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.pink,
              backgroundImage: porfilePhoto != null
                  ? CachedNetworkImageProvider(porfilePhoto!)
                  : null,
            ),
            const SizedBox(
              width: 12,
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                username,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 400,
          height: 400,
          color: Colors.pink,
          child: postPhoto != null
              ? CachedNetworkImage(imageUrl: postPhoto!)
              : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
                IconButton(
                    onPressed: () {
                      context
                          .read<PostBloc>()
                          .add(GetCommentEvent(postId: postId ?? ''));
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return BlocConsumer<PostBloc, PostState>(
                            listener: (context, state) {},
                            builder: (context, postState) {
                              return Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: <Widget>[
                                      AppBar(
                                        title: const Text('Comments'),
                                        leading: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.arrow_back),
                                        ),
                                        actions: const [Icon(Icons.message)],
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount:
                                              postState.commentEntity?.length ??
                                                  0,
                                          itemBuilder: (context, index) {
                                            final user = userState.usersList
                                                ?.where(
                                                  (element) =>
                                                      element.uid ==
                                                      postState
                                                          .commentEntity?[index]
                                                          .uid,
                                                )
                                                .firstOrNull;
                                            final comment =
                                                postState.commentEntity?[index];
                                            return ListTile(
                                              title: Text(user?.username ?? ''),
                                              subtitle:
                                                  Text(comment?.comment ?? ''),
                                              leading: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.white,
                                                backgroundImage: user
                                                            ?.profilePicture !=
                                                        null
                                                    ? CachedNetworkImageProvider(
                                                        user!.profilePicture!)
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: controller,
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                context.read<PostBloc>().add(
                                                    SendCommentEvent(
                                                        postId: postId ?? '',
                                                        comment: CommentEntity(
                                                            postId: postId,
                                                            uid: userState
                                                                .userEntity
                                                                ?.uid,
                                                            comment: controller
                                                                .text)));
                                                controller.text = '';
                                              },
                                              icon: const Icon(Icons.send))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.comment_rounded)),
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
