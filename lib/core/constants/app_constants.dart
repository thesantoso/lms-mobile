class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://api.lms-school.com';
  static const String apiVersion = '/api/v1';
  
  // Storage Keys
  static const String keyToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keySchoolId = 'school_id';
  static const String keyUserRole = 'user_role';
  
  // Geofence Configuration
  static const double attendanceRadius = 100.0; // meters
  
  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  
  // Pagination
  static const int defaultPageSize = 20;
}

class ApiEndpoints {
  // Auth
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  
  // Attendance
  static const String markAttendance = '/attendance/mark';
  static const String getAttendance = '/attendance';
  
  // Courses
  static const String courses = '/courses';
  
  // Materials
  static const String materials = '/materials';
  
  // Assignments
  static const String assignments = '/assignments';
  static const String submissions = '/submissions';
  
  // Grades
  static const String grades = '/grades';
  
  // Payments
  static const String payments = '/payments';
}

enum UserRole {
  student,
  teacher,
  parent,
  admin;
  
  String get value => name;
  
  static UserRole fromString(String role) {
    return UserRole.values.firstWhere(
      (e) => e.name.toLowerCase() == role.toLowerCase(),
      orElse: () => UserRole.student,
    );
  }
}
