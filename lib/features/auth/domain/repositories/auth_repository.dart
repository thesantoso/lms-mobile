import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login({
    required String schoolId,
    required String email,
    required String password,
  });
  
  Future<void> logout();
  
  Future<User?> getCurrentUser();
  
  Future<String?> getToken();
  
  Future<bool> isAuthenticated();
}
