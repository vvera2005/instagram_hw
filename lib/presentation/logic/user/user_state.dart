part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState({this.userEntity, this.error});
  final String? error;
  final UserEntity? userEntity;
  @override
  List<Object?> get props => [userEntity, error];
}

final class UserInitial extends UserState {}

final class UserDataUpdated extends UserState {
  const UserDataUpdated(UserEntity userEntity) : super(userEntity: userEntity);
}

final class UserDataLoading extends UserState {}

final class UserDataFailed extends UserState {
  const UserDataFailed(String error) : super(error: error);
}

final class UserDataLoaded extends UserState {
  const UserDataLoaded(UserEntity userEntity) : super(userEntity: userEntity);
}
