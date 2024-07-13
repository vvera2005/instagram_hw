import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme/app_theme_imp.dart';
import 'core/routes/routes.dart';
import 'data/repositories/auth/auth_repository_imp.dart';
import 'data/repositories/media/media_repository_imp.dart';
import 'data/repositories/post/post_repository_imp.dart';
import 'data/repositories/user/user_repsitory_imp.dart';
import 'data/services/auth/auth_service.dart';
import 'data/services/auth/auth_service_imp.dart';
import 'data/services/media/media_service.dart';
import 'data/services/media/media_service_imp.dart';
import 'data/services/post/post_service.dart';
import 'data/services/post/post_service_imp.dart';
import 'data/services/user/user_service.dart';
import 'data/services/user/user_service_imp.dart';
import 'domain/repositories/auth/auth_repository.dart';
import 'domain/repositories/media/media_repository.dart';
import 'domain/repositories/post/post_repository.dart';
import 'domain/repositories/user/user_repsitory.dart';
import 'presentation/logic/auth/auth_bloc.dart';
import 'presentation/logic/media/media_bloc.dart';
import 'presentation/logic/post/post_bloc.dart';
import 'presentation/logic/theme/theme_cubit.dart';
import 'presentation/logic/user/user_bloc.dart';
import 'presentation/pages/googlelogin/google_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyB_7MJ-tH2xCsaF-w6auD-5IjzRvtLqmUY',
      appId: '1:944177542429:android:d846b23b3cc9de2dde1df4',
      messagingSenderId: '',
      projectId: 'instagram-1dda6',
      storageBucket: 'gs://instagram-1dda6.appspot.com',
    ),
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthService>(
            create: (context) => AuthServiceImp(firestore)),
        RepositoryProvider<PostService>(
            create: (context) => PostServiceImp(firebaseFirestore: firestore, firebaseStorage: firebaseStorage)),
        RepositoryProvider<MediaService>(
            create: (context) => MediaServiceImp()),
        RepositoryProvider<AuthRepository>(
            create: (context) =>
                AuthRepositoryImp(RepositoryProvider.of<AuthService>(context))),
        RepositoryProvider<PostRepository>(
            create: (context) =>
                PostRepositoryImp(RepositoryProvider.of<PostService>(context))),
        RepositoryProvider<UserService>(
            create: (context) => UserServiceImp(firestore, firebaseStorage)),
        RepositoryProvider<UserRepsitory>(
            create: (context) =>
                UserRepsitoryImp(RepositoryProvider.of<UserService>(context))),
        RepositoryProvider<MediaRepository>(
            create: (context) => MediaRepositoryImp(
                RepositoryProvider.of<MediaService>(context))),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeModeCubit>(
            create: (context) => ThemeModeCubit(),
          ),
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider<MediaBloc>(
            create: (context) =>
                MediaBloc(RepositoryProvider.of<MediaRepository>(context)),
          ),
          BlocProvider<UserBloc>(
            create: (context) =>
                UserBloc(RepositoryProvider.of<UserRepsitory>(context)),
          ),
          BlocProvider<PostBloc>(
            create: (context) =>
                PostBloc(RepositoryProvider.of<PostRepository>(context)),
          ),
        ],
        child: BlocBuilder<ThemeModeCubit, ThemeModeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.generateRoute,
              title: 'Flutter Demo',
              themeMode: state.themeMode,
              theme: AppThemeData(context: context).lighTheme,
              darkTheme: AppThemeData(context: context).darkTheme,
              home: const GoogleLogin(),
            );
          },
        ),
      ),
    );
  }
}
