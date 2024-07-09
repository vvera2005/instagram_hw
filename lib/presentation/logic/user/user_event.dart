part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class UpdateUserDataEvent extends UserEvent {
  const UpdateUserDataEvent({required this.userEntity});

  final UserEntity userEntity;
}

final class GetUserDataEvent extends UserEvent {
  const GetUserDataEvent({required this.uid});
  final String uid;
}