part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState({
    this.postEntity,
    this.postsList,
    this.error,
  });
  final PostEntity? postEntity;
  final List<PostEntity>? postsList;
  final String? error;
  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

final class PostDataLoaded extends PostState {
  PostDataLoaded(PostState initialState, PostEntity? postEntity)
      : super(postEntity: postEntity, postsList: initialState.postsList);
}

final class AllPostsDataLoaded extends PostState {
  AllPostsDataLoaded(PostState initialState, List<PostEntity>? postsList)
      : super(postsList: postsList, postEntity: initialState.postEntity);
}

final class PostDataFailed extends PostState {
  PostDataFailed(PostState initialState, String error)
      : super(
            postEntity: initialState.postEntity,
            error: error,
            postsList: initialState.postsList);
}

final class PostDataLoading extends PostState {
  PostDataLoading(PostState initialState)
      : super(
            postEntity  : initialState.postEntity ,
            postsList: initialState.postsList);
}

final class PostDataDeleted extends PostState {
  PostDataDeleted(PostState initialState)
      : super(
            postEntity  : initialState.postEntity ,
            postsList: initialState.postsList);
}

final class PostDataUpdated extends PostState {
   PostDataUpdated(PostState initialState,PostEntity  ? postEntity  ) : super(postEntity: postEntity, postsList: initialState.postsList);
}
