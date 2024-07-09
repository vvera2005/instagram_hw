import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../domain/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginGoogleEvent>(_mapLoginGoogleEventToState);
  }
  final AuthRepository authRepository;

  FutureOr<void> _mapLoginGoogleEventToState(
      LoginGoogleEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoginGoogleLoading());
      final userCredential = await authRepository.signInWithGoogle();
      emit(LoginGoogleLoaded(userCredential));
    } on FirebaseAuthException catch (e) {
      emit(LoginGoogleFailed(e.message ?? e.code));
    } catch (e) {
      emit(LoginGoogleFailed(e.toString()));
    }
  }
}
