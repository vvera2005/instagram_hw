import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/user_entity.dart';
import '../../constants/gaps.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/media/media_bloc.dart';
import '../../logic/post/post_bloc.dart';
import '../../logic/user/user_bloc.dart';
import 'widgets/int_on_string_widget.dart';
import 'widgets/text_field_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    if (mounted && context.read<UserBloc>().state.userEntity == null) {
      final uid =
          context.read<AuthBloc>().state.userCredential?.user?.uid ?? '';
      context.read<UserBloc>().add(GetUserDataByIDEvent(uid: uid));
      context.read<PostBloc>().add(GetAllPostsFromDbEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaBloc, MediaState>(
      listener: (context, mediastate) {
        if (mediastate is MediaFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(mediastate.error ?? '')));
        }
      },
      builder: (context, mediastate) {
        return BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostDataFailed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error ?? '')));
            }
          },
          builder: (context, postState) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (usercontext, userstate) {
                final postsList = postState.postsList
                    ?.where((post) => post.uid == userstate.userEntity?.uid)
                    .toList();
                final nameController =
                    TextEditingController(text: userstate.userEntity?.name);

                final userNameController =
                    TextEditingController(text: userstate.userEntity?.username);

                final bioController =
                    TextEditingController(text: userstate.userEntity?.bio);
                return BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authstate) {
                    return Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        title:
                            Text(userstate.userEntity?.username ?? 'undefined'),
                        actions: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.add)),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.menu)),
                        ],
                      ),
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: userstate.userEntity != null
                                    ? null
                                    : Colors.white,
                                backgroundImage: userstate.userEntity != null
                                    ? NetworkImage(
                                        userstate.userEntity!.profilePicture ??
                                            '')
                                    : null,
                              ),
                              const IntOnStringWidget(
                                  integer: 6, mstr: 'posts'),
                              IntOnStringWidget(
                                  integer: userstate
                                          .userEntity?.followerList?.length ??
                                      0,
                                  mstr: 'Followers'),
                              IntOnStringWidget(
                                  integer: userstate
                                          .userEntity?.followingList?.length ??
                                      0,
                                  mstr: 'Followwing'),
                            ],
                          ),
                          Text(
                            userstate.userEntity?.name ?? ' no name',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            userstate.userEntity?.bio ?? ' no bio',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                50,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              AppBar(
                                                title:
                                                    const Text('Edit profile'),
                                                leading: IconButton(
                                                  icon: const Icon(Icons.close),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                actions: [
                                                  IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<UserBloc>()
                                                            .add(
                                                                UpdateUserDataEvent(
                                                                    userEntity:
                                                                        UserEntity(
                                                              username:
                                                                  userNameController
                                                                      .text,
                                                              name:
                                                                  nameController
                                                                      .text,
                                                              bio: bioController
                                                                  .text,
                                                              uid: authstate
                                                                  .userCredential
                                                                  ?.user
                                                                  ?.uid,
                                                              email: authstate
                                                                  .userCredential
                                                                  ?.user
                                                                  ?.email,
                                                            )));
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.done,
                                                        color: Colors.blue,
                                                      )),
                                                ],
                                              ),
                                              CircleAvatar(
                                                backgroundColor:
                                                    userstate.userEntity != null
                                                        ? null
                                                        : Colors.white,
                                                backgroundImage: userstate
                                                            .userEntity
                                                            ?.profilePicture !=
                                                        null
                                                    ? CachedNetworkImageProvider(
                                                        userstate.userEntity!
                                                            .profilePicture!)
                                                    : null,
                                                radius: 50,
                                              ),
                                              SizedBox(
                                                height: Gaps.smallest,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.white,
                                                      context: context,
                                                      builder: (context) {
                                                        return SizedBox(
                                                          height: 200,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child:
                                                              Column(children: [
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  final media = context
                                                                      .read<
                                                                          MediaBloc>()
                                                                      .state
                                                                      .fileImage;
                                                                  context.read<UserBloc>().add(UploadProfilePhotoEvent(
                                                                      uid: authstate
                                                                              .userCredential
                                                                              ?.user
                                                                              ?.uid ??
                                                                          '',
                                                                      file: media!
                                                                          .file));
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Save',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )),
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  context
                                                                      .read<
                                                                          MediaBloc>()
                                                                      .add(
                                                                          UploadPictureFromGalleryEvent());
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Upload from Gallery',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        MediaBloc>()
                                                                    .add(
                                                                        UploadPictureFromCameraEvent());
                                                              },
                                                              child: const Text(
                                                                'Upload from Cammera',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ]),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Edit picture or avatar',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  )),
                                              SizedBox(
                                                height: Gaps.medium,
                                              ),
                                              TextFieldWidget(
                                                controller: nameController,
                                                hintText: 'Name',
                                              ),
                                              TextFieldWidget(
                                                controller: userNameController,
                                                hintText: 'Username',
                                              ),
                                              TextFieldWidget(
                                                controller: bioController,
                                                hintText: 'Bio',
                                              ),
                                              const Text('Add link'),
                                              TextButton(
                                                  onPressed: () {},
                                                  child: const Text(
                                                      'Switch to professional account ',
                                                      style: TextStyle(
                                                          color: Colors.blue))),
                                              TextButton(
                                                  onPressed: () {},
                                                  child: const Text(
                                                    'Personal information settings',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Text('Edit Profile'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                onPressed: () {},
                                child: const Text('Share profile'),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: IconButton(
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    color: Colors.black,
                                    onPressed: () {},
                                  ))
                            ],
                          ),
                          SizedBox(height: Gaps.extraLarge),
                          const Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.grid_on_outlined,
                                size: 30,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              Icon(
                                Icons.person_pin_rounded,
                                size: 30,
                                color: Theme.of(context).colorScheme.onSurface,
                              )
                            ],
                          ),
                          SizedBox(height: Gaps.large),
                          Expanded(
                            child: postState.postsList == null ||
                                    postState.postsList!.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No posts yet',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                    ),
                                    itemCount: postsList?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        child: postsList?[index].postPicture !=
                                                null
                                            ? CachedNetworkImage(
                                                imageUrl: postsList?[index]
                                                        .postPicture ??
                                                    '',
                                                fit: BoxFit.cover,
                                              )
                                            : const Text(
                                                'No Posts Yet',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                      );
                                    },
                                  ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
