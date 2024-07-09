import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/repositories/auth/auth_repository.dart';
import '../../services/auth/auth_service.dart';

class AuthRepositoryImp implements AuthRepository {
  AuthRepositoryImp(this.authService);
  AuthService authService;
  @override
  Future<UserCredential> signInWithGoogle() async {
    return authService.signInWithGoogle();
  }
}
