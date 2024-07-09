import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/user_entity.dart';
import '../../constants/gaps.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/media/media_bloc.dart';
import '../../logic/user/user_bloc.dart';
import 'widgets/int_on_string_widget.dart';
import 'widgets/text_field_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController bioController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaBloc, MediaState>(
      listener: (context, mediastate) {
        if (mediastate is MediaFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(mediastate.error)));
        }
      },
      builder: (context, mediastate) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (usercontext, userstate) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Text(userstate.userEntity?.username ?? 'undefined'),
                    actions: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.menu)),
                    ],
                  ),
                  body: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                          ),
                          const IntOnStringWidget(integer: 6, mstr: 'posts'),
                          IntOnStringWidget(
                              integer:
                                  userstate.userEntity?.followerList?.length ??
                                      0,
                              mstr: 'Followers'),
                          IntOnStringWidget(
                              integer:
                                  userstate.userEntity?.followingList?.length ??
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height - 50,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      AppBar(
                                        title: const Text('Edit profile'),
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
                                                    .add(UpdateUserDataEvent(
                                                        userEntity: UserEntity(
                                                      username:
                                                          userNameController
                                                              .text,
                                                      name: nameController.text,
                                                      bio: bioController.text,
                                                      uid: state.userCredential
                                                          ?.user?.uid,
                                                      email: state
                                                          .userCredential
                                                          ?.user
                                                          ?.email,
                                                    )));
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(
                                                Icons.done,
                                                color: Colors.blue,
                                              ))
                                        ],
                                      ),
                                      const CircleAvatar(
                                        radius: 50,
                                      ),
                                      SizedBox(
                                        height: Gaps.smallest,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            context.read<MediaBloc>().add(
                                                UploadPictureFromGalleryEvent());
                                          },
                                          child: const Text(
                                            'Edit picture or avatar',
                                            style:
                                                TextStyle(color: Colors.blue),
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
                                            style:
                                                TextStyle(color: Colors.blue),
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
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}