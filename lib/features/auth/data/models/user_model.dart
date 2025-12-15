import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.schoolId,
    required super.name,
    required super.email,
    required super.role,
    super.profileImage,
    super.metadata,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      schoolId: json['schoolId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: UserRole.fromString(json['role'] as String),
      profileImage: json['profileImage'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schoolId': schoolId,
      'name': name,
      'email': email,
      'role': role.value,
      'profileImage': profileImage,
      'metadata': metadata,
    };
  }
}

class LoginResponse {
  final String token;
  final String refreshToken;
  final UserModel user;
  
  LoginResponse({
    required this.token,
    required this.refreshToken,
    required this.user,
  });
  
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
