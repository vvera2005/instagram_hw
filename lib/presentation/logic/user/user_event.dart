part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

final class UpdateUserDataEvent extends UserEvent {
  const UpdateUserDataEvent({required this.userEntity});

  final UserEntity userEntity;
}

final class GetUserDataByIDEvent extends UserEvent {
  const GetUserDataByIDEvent({required this.uid});
  final String uid;
}

final class GetOtherUserDataByIDEvent extends UserEvent {
  const GetOtherUserDataByIDEvent({required this.uid});
  final String uid;
}

final class GetUsersEvent extends UserEvent {
  const GetUsersEvent();
}

class UploadProfilePhotoEvent extends UserEvent {
  const UploadProfilePhotoEvent({required this.uid, required this.file});

  final String uid;
  final File file;
}
