import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entity/user_entity.dart';
import '../../../domain/repositories/user/user_repsitory.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.userRepsitory) : super(UserInitial()) {
    on<UpdateUserDataEvent>(_mapUpdateUserDataEventToState);
    on<GetUserDataByIDEvent>(_mapGetUserDataEventToState);
    on<GetOtherUserDataByIDEvent>(_mapGetOtherUserDataByIdEventToState);
    on<UploadProfilePhotoEvent>(_mapUploadProfilePhotoEventToState);
    on<GetUsersEvent>(_mapGetUsersEventToState);
    on<FollowEvent>(_mapFollowEventToState);
  }
  final UserRepsitory userRepsitory;

  FutureOr<void> _mapUpdateUserDataEventToState(
      UpdateUserDataEvent event, Emitter<UserState> emit) {
    try {
      emit(UserDataLoading(state));
      userRepsitory.saveUserToDb(event.userEntity);
      emit(UserDataUpdated(state, event.userEntity));
    } catch (e) {
      emit(UserDataFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapGetUserDataEventToState(
      GetUserDataByIDEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserDataLoading(state));
      final userEntity = await userRepsitory.getUserFromDb(event.uid);
      emit(UserDataUpdated(state, userEntity));
    } catch (e) {
      emit(UserDataFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapUploadProfilePhotoEventToState(
      UploadProfilePhotoEvent event, Emitter<UserState> emit) {
    try {
      emit(UserDataLoading(state));
      userRepsitory.uploadProfilePicture(event.uid, event.file);
      emit(UserDataLoaded(state, state.userEntity));
    } catch (e) {
      emit(UserDataFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapGetUsersEventToState(
      GetUsersEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserDataLoading(state));

      await for (final List<UserEntity> users
          in userRepsitory.getUsersFromDB()) {
        emit(AllUsersDataLoaded(state, users));
      }
    } catch (error) {
      emit(UserDataFailed(state, error.toString()));
    }
  }

  FutureOr<void> _mapGetOtherUserDataByIdEventToState(
      GetOtherUserDataByIDEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserDataLoading(state));
      final userEntity = await userRepsitory.getUserFromDb(event.uid);
      emit(OtherUserDataLoaded(state, userEntity));
    } catch (e) {
      emit(UserDataFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapFollowEventToState(
      FollowEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserDataLoading(state));
      await userRepsitory.follow(event.uid, event.folloingId);
      emit(UserDataUpdated(state, state.userEntity));
    } catch (e) {
      emit(UserDataFailed(state, e.toString()));
    }
  }
}
