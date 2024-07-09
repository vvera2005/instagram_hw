import 'dart:async';
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
  }
  final UserRepsitory userRepsitory;
  FutureOr<void> _mapUpdateUserDataEventToState(
      UpdateUserDataEvent event, Emitter<UserState> emit) {
    try {
      emit(UserDataLoading());
      userRepsitory.saveUserToDb(event.userEntity);
      emit(UserDataUpdated(event.userEntity));
    } catch (e) {
      emit(UserDataFailed(e.toString()));
    }
  }

  FutureOr<void> _mapGetUserDataEventToState(
      GetUserDataEvent event, Emitter<UserState> emit) async{
    try {
      emit(UserDataLoading());
    final userEntity = await userRepsitory.getUserFromDb(event.uid);
      emit(UserDataUpdated(userEntity));
    } catch (e) {
      emit(UserDataFailed(e.toString()));
    }
  }
}
