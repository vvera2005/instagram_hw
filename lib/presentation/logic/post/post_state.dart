part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState({
    this.postEntity,
    this.commentEntity,
    this.postsList,
    this.error,
  });
  final PostEntity? postEntity;
  final List<CommentEntity>? commentEntity;
  final List<PostEntity>? postsList;
  final String? error;
  @override
  List<Object?> get props => [postEntity, commentEntity, postsList, error];
}

final class PostInitial extends PostState {}

final class PostDataLoaded extends PostState {
  PostDataLoaded(PostState initialState, PostEntity? postEntity)
      : super(
            postEntity: postEntity,
            postsList: initialState.postsList,
            commentEntity: initialState.commentEntity);
}

final class AllPostsDataLoaded extends PostState {
  AllPostsDataLoaded(PostState initialState, List<PostEntity>? postsList)
      : super(
            postsList: postsList,
            postEntity: initialState.postEntity,
            commentEntity: initialState.commentEntity);
}

final class PostDataFailed extends PostState {
  PostDataFailed(PostState initialState, String error)
      : super(
            postEntity: initialState.postEntity,
            error: error,
            postsList: initialState.postsList,
            commentEntity: initialState.commentEntity);
}

final class PostDataLoading extends PostState {
  PostDataLoading(PostState initialState)
      : super(
            postEntity: initialState.postEntity,
            postsList: initialState.postsList,
            commentEntity: initialState.commentEntity);
}

final class PostDataDeleted extends PostState {
  PostDataDeleted(PostState initialState)
      : super(
            postEntity: initialState.postEntity,
            postsList: initialState.postsList,
            commentEntity: initialState.commentEntity);
}

final class PostDataUpdated extends PostState {
  PostDataUpdated(PostState initialState, PostEntity? postEntity)
      : super(
            postEntity: postEntity,
            postsList: initialState.postsList,
            commentEntity: initialState.commentEntity);
}

final class CommentListLoaded extends PostState {
  CommentListLoaded(PostState initialState, List<CommentEntity>? commentEntity)
      : super(
            postEntity: initialState.postEntity,
            postsList: initialState.postsList,
            commentEntity: commentEntity);
}

final class CommentSent extends PostState {
  CommentSent(PostState initialState, List<CommentEntity>? commentEntity)
      : super(
            postEntity: initialState.postEntity,
            postsList: initialState.postsList,
            commentEntity: commentEntity);
}
