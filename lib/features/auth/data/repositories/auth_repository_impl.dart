import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  
  @override
  Future<User> login({
    required String schoolId,
    required String email,
    required String password,
  }) async {
    final response = await remoteDataSource.login(
      schoolId: schoolId,
      email: email,
      password: password,
    );
    
    await localDataSource.cacheToken(response.token);
    await localDataSource.cacheRefreshToken(response.refreshToken);
    await localDataSource.cacheSchoolId(schoolId);
    await localDataSource.cacheUser(response.user);
    
    return response.user;
  }
  
  @override
  Future<void> logout() async {
    await localDataSource.clearCache();
  }
  
  @override
  Future<User?> getCurrentUser() async {
    return await localDataSource.getCachedUser();
  }
  
  @override
  Future<String?> getToken() async {
    return await localDataSource.getCachedToken();
  }
  
  @override
  Future<bool> isAuthenticated() async {
    final token = await localDataSource.getCachedToken();
    return token != null && token.isNotEmpty;
  }
}
