import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  
  LoginUseCase(this.repository);
  
  Future<User> call({
    required String schoolId,
    required String email,
    required String password,
  }) {
    if (schoolId.isEmpty) {
      throw Exception('School ID is required');
    }
    if (email.isEmpty) {
      throw Exception('Email is required');
    }
    if (password.isEmpty) {
      throw Exception('Password is required');
    }
    
    return repository.login(
      schoolId: schoolId,
      email: email,
      password: password,
    );
  }
}

class LogoutUseCase {
  final AuthRepository repository;
  
  LogoutUseCase(this.repository);
  
  Future<void> call() {
    return repository.logout();
  }
}

class GetCurrentUserUseCase {
  final AuthRepository repository;
  
  GetCurrentUserUseCase(this.repository);
  
  Future<User?> call() {
    return repository.getCurrentUser();
  }
}

class CheckAuthUseCase {
  final AuthRepository repository;
  
  CheckAuthUseCase(this.repository);
  
  Future<bool> call() {
    return repository.isAuthenticated();
  }
}
