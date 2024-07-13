import 'dart:io';

import '../../models/post_model.dart';

abstract class PostService {
  Future<void> savePostTODb(PostModel postModel);
  Future<void> updatePostInDb(PostModel postModel);
  Future<void> deletePostFromDb(String postid);
  Future<PostModel> getPostByIdFromDb(String postid);
  Stream<List<PostModel>> getPostsFromDB();
  Future<void> uploadPostPictureToDb(String postid, File file);
}
