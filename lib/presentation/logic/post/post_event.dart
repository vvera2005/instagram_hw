part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

final class SavePostToDbEvent extends PostEvent {
  const SavePostToDbEvent({required this.postEntity});

  final PostEntity postEntity;
}

final class UpdatePostInDbEvent extends PostEvent {
  const UpdatePostInDbEvent({required this.postEntity});

  final PostEntity postEntity;
}

final class DeletePostFromDbEvent extends PostEvent {
  const DeletePostFromDbEvent({required this.postId});

  final String postId;
}

final class GetPostByIdFromDbEvent extends PostEvent {
  const GetPostByIdFromDbEvent({required this.postId});

  final String postId;
}

final class GetAllPostsFromDbEvent extends PostEvent {
  const GetAllPostsFromDbEvent();
}

final class UploadPostPhotoEvent extends PostEvent {
  const UploadPostPhotoEvent({required this.postId, required this.file});

  final String postId;
  final File file;
}

final class SendCommentEvent extends PostEvent {
  const SendCommentEvent({required this.postId, required this.comment});

  final String postId;
  final CommentEntity comment;
}

final class GetCommentEvent extends PostEvent {
  const GetCommentEvent({required this.postId});

  final String postId;
}
