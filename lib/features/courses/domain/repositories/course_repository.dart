import '../entities/course.dart';

abstract class CourseRepository {
  Future<List<Course>> getCourses({String? teacherId, String? studentId});
  Future<Course> getCourseById(String courseId);
  Future<List<Material>> getCourseMaterials(String courseId);
  Future<Material> uploadMaterial({
    required String courseId,
    required String title,
    required String description,
    required String filePath,
    required MaterialType type,
  });
}
