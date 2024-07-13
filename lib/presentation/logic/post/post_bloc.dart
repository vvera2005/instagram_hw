import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entity/post_entity.dart';
import '../../../domain/repositories/post/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this.postRepository) : super(PostInitial()) {
    on<SavePostToDbEvent>(_mapSavePostToDbEventToState);
    on<UpdatePostInDbEvent>(_mapUpdatePostInDbEventToState);
    on<DeletePostFromDbEvent>(_mapDeletePostFromDbEventToState);
    on<GetAllPostsFromDbEvent>(_mapGetAllPostsFromDbEventToState);
    on<GetPostByIdFromDbEvent>(_mapGetPostByIdFromDbEventToState);
    on<UploadPostPhotoEvent>(_mapUploadPostPhotoToDbToState);
  }

  final PostRepository postRepository;

  FutureOr<void> _mapSavePostToDbEventToState(
      SavePostToDbEvent event, Emitter<PostState> emit) async {
    try {
      emit(PostDataLoading(state));
      await postRepository.savePostTODb(event.postEntity);
      emit(PostDataLoaded(state, event.postEntity));
    } catch (e) {
      emit(PostDataFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapUpdatePostInDbEventToState(
      UpdatePostInDbEvent event, Emitter<PostState> emit) async {
    try {
      emit(PostDataLoading(state));
      await postRepository.updatePostInDb(event.postEntity);
      emit(PostDataLoaded(state, event.postEntity));
    } catch (e) {
      emit(PostDataFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapDeletePostFromDbEventToState(
      DeletePostFromDbEvent event, Emitter<PostState> emit) async {
    try {
      emit(PostDataLoading(state));
      await postRepository.deletePostFromDb(event.postId);
      emit(PostDataDeleted(state));
    } catch (e) {
      emit(PostDataFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapGetAllPostsFromDbEventToState(
      GetAllPostsFromDbEvent event, Emitter<PostState> emit) async {
    try {
      emit(PostDataLoading(state));
      await for (final List<PostEntity> posts
          in postRepository.getPostsFromDB()) {
        emit(AllPostsDataLoaded(state, posts));
      }
    } catch (e) {
      emit(PostDataFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapGetPostByIdFromDbEventToState(
      GetPostByIdFromDbEvent event, Emitter<PostState> emit) async {
    try {
      emit(PostDataLoading(state));
      final postEntity = await postRepository.getPostByIdFromDb(event.postId);
      emit(PostDataLoaded(state, postEntity));
    } catch (e) {
      emit(PostDataFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapUploadPostPhotoToDbToState(
      UploadPostPhotoEvent event, Emitter<PostState> emit) {
         try {
      emit(PostDataLoading(state));
      postRepository.uploadPostPictureToDb(event.postId, event.file);
      emit(PostDataLoaded(state, state.postEntity));
    } catch (e) {
      emit(PostDataFailed(state, e.toString()));
    }
      }
}