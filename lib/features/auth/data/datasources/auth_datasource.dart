import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login({
    required String schoolId,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient client;
  
  AuthRemoteDataSourceImpl(this.client);
  
  @override
  Future<LoginResponse> login({
    required String schoolId,
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      ApiEndpoints.login,
      data: {
        'schoolId': schoolId,
        'email': email,
        'password': password,
      },
    );
    
    return LoginResponse.fromJson(response.data as Map<String, dynamic>);
  }
}

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<void> cacheToken(String token);
  Future<void> cacheRefreshToken(String refreshToken);
  Future<void> cacheSchoolId(String schoolId);
  Future<UserModel?> getCachedUser();
  Future<String?> getCachedToken();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;
  
  AuthLocalDataSourceImpl(this.prefs);
  
  @override
  Future<void> cacheUser(UserModel user) async {
    await prefs.setString('cached_user', jsonEncode(user.toJson()));
    await prefs.setString(AppConstants.keyUserId, user.id);
    await prefs.setString(AppConstants.keyUserRole, user.role.value);
  }
  
  @override
  Future<void> cacheToken(String token) async {
    await prefs.setString(AppConstants.keyToken, token);
  }
  
  @override
  Future<void> cacheRefreshToken(String refreshToken) async {
    await prefs.setString(AppConstants.keyRefreshToken, refreshToken);
  }
  
  @override
  Future<void> cacheSchoolId(String schoolId) async {
    await prefs.setString(AppConstants.keySchoolId, schoolId);
  }
  
  @override
  Future<UserModel?> getCachedUser() async {
    final userJson = prefs.getString('cached_user');
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
    }
    return null;
  }
  
  @override
  Future<String?> getCachedToken() async {
    return prefs.getString(AppConstants.keyToken);
  }
  
  @override
  Future<void> clearCache() async {
    await prefs.remove('cached_user');
    await prefs.remove(AppConstants.keyToken);
    await prefs.remove(AppConstants.keyRefreshToken);
    await prefs.remove(AppConstants.keyUserId);
    await prefs.remove(AppConstants.keySchoolId);
    await prefs.remove(AppConstants.keyUserRole);
  }
}
