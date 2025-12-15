import '../../../../core/constants/app_constants.dart';

class User {
  final String id;
  final String schoolId;
  final String name;
  final String email;
  final UserRole role;
  final String? profileImage;
  final Map<String, dynamic>? metadata;
  
  User({
    required this.id,
    required this.schoolId,
    required this.name,
    required this.email,
    required this.role,
    this.profileImage,
    this.metadata,
  });
  
  bool get isStudent => role == UserRole.student;
  bool get isTeacher => role == UserRole.teacher;
  bool get isParent => role == UserRole.parent;
  bool get isAdmin => role == UserRole.admin;
}
