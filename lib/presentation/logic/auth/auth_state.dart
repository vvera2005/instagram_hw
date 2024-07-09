part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState({this.error, this.userCredential});
  final String? error;
  final UserCredential? userCredential;

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class LoginGoogleLoading extends AuthState {}

final class LoginGoogleLoaded extends AuthState {
  const LoginGoogleLoaded(UserCredential userCredential)
      : super(userCredential: userCredential);
}

final class LoginGoogleFailed extends AuthState {
  const LoginGoogleFailed(String error) : super(error: error);
}
