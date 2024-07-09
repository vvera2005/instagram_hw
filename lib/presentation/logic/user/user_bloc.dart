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
    on<GetUserDataEvent>(_mapGetUserDataEventToState);
    on<UploadProfilePhotoEvent>(_mapUploadProfilePhotoEventToState);
  }
  final UserRepsitory userRepsitory;

  FutureOr<void> _mapUpdateUserDataEventToState(
      UpdateUserDataEvent event, Emitter<UserState> emit) {
    try {
      emit(UserDataLoading(state));
      userRepsitory.saveUserToDb(event.userEntity);
      emit(UserDataUpdated(event.userEntity));
    } catch (e) {
      emit(UserDataFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapGetUserDataEventToState(
      GetUserDataEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserDataLoading(state));
      final userEntity = await userRepsitory.getUserFromDb(event.uid);
      emit(UserDataUpdated(userEntity));
    } catch (e) {
      emit(UserDataFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapUploadProfilePhotoEventToState(
      UploadProfilePhotoEvent event, Emitter<UserState> emit) {
    try {
      emit(UserDataLoading(state));
      userRepsitory.uploadProfilePicture(event.uid, event.file);
      emit(UserDataLoaded(state.userEntity));
    } catch (e) {
      emit(UserDataFailed(state, e.toString()));
    }
  }
}
