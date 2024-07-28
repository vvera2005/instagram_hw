part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState({
    this.userEntity,
    this.error,
    this.usersList,
    this.otherUserEntity,
  });
  final String? error;
  final UserEntity? userEntity;
  final UserEntity? otherUserEntity;
  final List<UserEntity>? usersList;
  @override
  List<Object?> get props => [userEntity, error, userEntity];
}

final class UserInitial extends UserState {}

final class UserDataUpdated extends UserState {
  UserDataUpdated(UserState initialState, UserEntity? userEntity)
      : super(
          userEntity: userEntity,
          usersList: initialState.usersList,
          otherUserEntity: initialState.otherUserEntity
        );
}

final class UserDataLoading extends UserState {
  UserDataLoading(UserState initialState)
      : super(
            userEntity: initialState.userEntity,
            usersList: initialState.usersList);
}

final class UserDataFailed extends UserState {
  UserDataFailed(UserState initialState, String error)
      : super(
            userEntity: initialState.userEntity,
            error: error,
            usersList: initialState.usersList);
}

final class UserDataLoaded extends UserState {
  UserDataLoaded(UserState initialState, UserEntity? userEntity)
      : super(userEntity: userEntity, usersList: initialState.usersList);
}

final class AllUsersDataLoaded extends UserState {
  AllUsersDataLoaded(UserState initialState, List<UserEntity>? usersList)
      : super(usersList: usersList, userEntity: initialState.userEntity);
}

final class OtherUserDataLoaded extends UserState {
  OtherUserDataLoaded(UserState initialState, UserEntity? userEntity)
      : super(otherUserEntity: userEntity, usersList: initialState.usersList);
}
