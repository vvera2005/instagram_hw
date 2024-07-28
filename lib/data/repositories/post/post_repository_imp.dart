import 'dart:io';

import '../../../domain/entity/comment_entity.dart';
import '../../../domain/entity/post_entity.dart';
import '../../../domain/repositories/post/post_repository.dart';
import '../../models/post_model.dart';
import '../../services/post/post_service.dart';

class PostRepositoryImp implements PostRepository {
  PostRepositoryImp(this.postService);

  final PostService postService;
  @override
  Future<void> deletePostFromDb(String postId) async {
    await postService.deletePostFromDb(postId);
  }

  @override
  Future<PostEntity> getPostByIdFromDb(String postId) async {
    return postService.getPostByIdFromDb(postId);
  }

  @override
  Stream<List<PostEntity>> getPostsFromDB() async* {
    await for (final List<PostModel> models in postService.getPostsFromDB()) {
      yield models.map((e) => PostEntity.fromModel(e)).toList();
    }
  }

  @override
  Future<void> savePostTODb(PostEntity postEntity) async {
    await postService.savePostTODb(postEntity.toModel());
  }

  @override
  Future<void> updatePostInDb(PostEntity postEntity) async {
    await postService.updatePostInDb(postEntity.toModel());
  }

  @override
  Future<void> uploadPostPictureToDb(String postid, File file) async {
    await postService.uploadPostPictureToDb(postid, file);
  }

  @override
  Future<void> sendComment(String postId, CommentEntity? comment) async {
    await postService.sendComment(postId, comment?.toModel());
  }

  @override
  Stream<List<CommentEntity>> getComments(String postId) async* {
    await for (final comment in postService.getComments(postId)) {
      yield comment.map((e) => CommentEntity.fromModel(e)).toList();
    }
  }
}
