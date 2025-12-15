import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';
import '../datasources/course_datasource.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource remoteDataSource;
  
  CourseRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<List<Course>> getCourses({String? teacherId, String? studentId}) async {
    return await remoteDataSource.getCourses(
      teacherId: teacherId,
      studentId: studentId,
    );
  }
  
  @override
  Future<Course> getCourseById(String courseId) async {
    return await remoteDataSource.getCourseById(courseId);
  }
  
  @override
  Future<List<Material>> getCourseMaterials(String courseId) async {
    return await remoteDataSource.getCourseMaterials(courseId);
  }
  
  @override
  Future<Material> uploadMaterial({
    required String courseId,
    required String title,
    required String description,
    required String filePath,
    required MaterialType type,
  }) async {
    return await remoteDataSource.uploadMaterial(
      courseId: courseId,
      title: title,
      description: description,
      filePath: filePath,
      type: type,
    );
  }
}
