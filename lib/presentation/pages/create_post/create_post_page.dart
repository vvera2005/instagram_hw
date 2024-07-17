import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entity/post_entity.dart';
import '../../constants/gaps.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/media/media_bloc.dart';
import '../../logic/post/post_bloc.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, poststate) {
        if (poststate is MediaFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(poststate.error ?? ''),
            ),
          );
        }
      },
      builder: (context, poststate) {
        return BlocConsumer<MediaBloc, MediaState>(
          listener: (context, mediaState) {
            if (mediaState is MediaFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(mediaState.error ?? ''),
                ),
              );
            }
          },
          builder: (context, mediaState) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text('Select Media'),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      final postId = const Uuid().v6();
                      context.read<PostBloc>().add(SavePostToDbEvent(
                              postEntity: PostEntity(
                            postId: postId,
                            description: _descriptionController.text,
                            uid: context
                                    .read<AuthBloc>()
                                    .state
                                    .userCredential
                                    ?.user
                                    ?.uid ??
                                '',
                          )));
                      context.read<PostBloc>().add(UploadPostPhotoEvent(
                          postId: postId, file: mediaState.fileImage!.file));
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.done),
                  )
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Gaps.large, vertical: Gaps.large),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<MediaBloc>()
                              .add(UploadPictureFromGalleryEvent());
                        },
                        child: SizedBox(
                          height: 550,
                          // color: Colors.white,
                          child: Image.network(
                              'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg'),
                        ),
                      ),
                      SizedBox(height: Gaps.largest),
                      const Text(
                        'Description',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write a description',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
