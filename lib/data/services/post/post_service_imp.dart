import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/comment_model.dart';
import '../../models/message_model.dart';
import '../../models/post_model.dart';
import 'post_service.dart';

class PostServiceImp implements PostService {
  PostServiceImp({
    required this.firebaseFirestore,
    required this.firebaseStorage,
    required this.firebaseDatabase,
  });

  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseDatabase firebaseDatabase;
  @override
  Future<void> savePostTODb(PostModel postModel) async {
    await firebaseFirestore
        .collection('posts')
        .doc(postModel.postId)
        .set(postModel.toJson());
  }

  @override
  Future<void> updatePostInDb(PostModel postModel) async {
    await firebaseFirestore
        .collection('posts')
        .doc(postModel.postId)
        .update(postModel.toJson());
  }

  @override
  Future<void> deletePostFromDb(String postId) async {
    await firebaseFirestore.collection('posts').doc(postId).delete();
  }

  @override
  Future<PostModel> getPostByIdFromDb(String postId) async {
    final snapshot =
        await firebaseFirestore.collection('posts').doc(postId).get();
    final postData = PostModel.fromJson(snapshot.data() ?? {});

    return postData;
  }

  @override
  Stream<List<PostModel>> getPostsFromDB() async* {
    final snapshot = firebaseFirestore.collection('posts').snapshots();

    await for (final mysnapshot in snapshot) {
      final posts =
          mysnapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
      yield posts;
    }
  }

  @override
  Future<void> uploadPostPictureToDb(String postid, File file) async {
    final ref = firebaseStorage
        .ref('postPhotos/')
        .child(Timestamp.now().millisecondsSinceEpoch.toString());

    await ref.putFile(file);

    final downloadUrl = await ref.getDownloadURL();

    await firebaseFirestore
        .collection('posts')
        .doc(postid)
        .update({'postPicture': downloadUrl});
  }

  @override
  Future<void> sendComment(String postId, CommentModel? comment) async {
    await firebaseDatabase
        .ref('comments')
        .child(postId)
        .push()
        .set(comment?.toJson());
  }

  @override
  Stream<List<CommentModel>> getComments(String postId) async* {
    await for (final event
        in firebaseDatabase.ref('comments').child(postId).onValue) {
      final snapshot = event.snapshot;
      if (snapshot.value == null) {
        yield [];
      }

      final commentsMap = snapshot.children.toList();
      final comments = commentsMap
          .map((entry) => (entry.value! as Map<Object?, Object?>)
              .map((key, value) => MapEntry(key.toString(), value)))
          .toList();

      yield comments
          .map(
            (e) => CommentModel.fromJson(e),
          )
          .toList();
    }
  }
}
