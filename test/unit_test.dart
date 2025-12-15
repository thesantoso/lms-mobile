import 'package:flutter_test/flutter_test.dart';
import 'package:lms_mobile/core/constants/app_constants.dart';
import 'package:lms_mobile/features/auth/domain/entities/user.dart';

void main() {
  group('User Entity Tests', () {
    test('User should be created with required fields', () {
      // Arrange & Act
      final user = User(
        id: '123',
        schoolId: 'school-1',
        name: 'John Doe',
        email: 'john@example.com',
        role: UserRole.student,
      );
      
      // Assert
      expect(user.id, '123');
      expect(user.schoolId, 'school-1');
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.role, UserRole.student);
    });
    
    test('User role helpers should return correct values', () {
      // Arrange
      final student = User(
        id: '1',
        schoolId: 'school-1',
        name: 'Student',
        email: 'student@test.com',
        role: UserRole.student,
      );
      
      final teacher = User(
        id: '2',
        schoolId: 'school-1',
        name: 'Teacher',
        email: 'teacher@test.com',
        role: UserRole.teacher,
      );
      
      // Assert
      expect(student.isStudent, true);
      expect(student.isTeacher, false);
      expect(teacher.isTeacher, true);
      expect(teacher.isStudent, false);
    });
  });
  
  group('UserRole Tests', () {
    test('UserRole.fromString should parse role correctly', () {
      expect(UserRole.fromString('student'), UserRole.student);
      expect(UserRole.fromString('teacher'), UserRole.teacher);
      expect(UserRole.fromString('parent'), UserRole.parent);
      expect(UserRole.fromString('admin'), UserRole.admin);
    });
    
    test('UserRole.fromString should handle case insensitive', () {
      expect(UserRole.fromString('STUDENT'), UserRole.student);
      expect(UserRole.fromString('Teacher'), UserRole.teacher);
    });
    
    test('UserRole.fromString should default to student for unknown role', () {
      expect(UserRole.fromString('unknown'), UserRole.student);
    });
  });
  
  group('AppConstants Tests', () {
    test('API endpoints should be properly defined', () {
      expect(ApiEndpoints.login, '/auth/login');
      expect(ApiEndpoints.markAttendance, '/attendance/mark');
      expect(ApiEndpoints.courses, '/courses');
    });
    
    test('Attendance radius should be 100 meters', () {
      expect(AppConstants.attendanceRadius, 100.0);
    });
  });
}
