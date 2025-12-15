import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/course_model.dart';
import '../../domain/entities/course.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseModel>> getCourses({String? teacherId, String? studentId});
  Future<CourseModel> getCourseById(String courseId);
  Future<List<MaterialModel>> getCourseMaterials(String courseId);
  Future<MaterialModel> uploadMaterial({
    required String courseId,
    required String title,
    required String description,
    required String filePath,
    required MaterialType type,
  });
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final DioClient client;
  
  CourseRemoteDataSourceImpl(this.client);
  
  @override
  Future<List<CourseModel>> getCourses({
    String? teacherId,
    String? studentId,
  }) async {
    final queryParams = <String, dynamic>{};
    if (teacherId != null) queryParams['teacherId'] = teacherId;
    if (studentId != null) queryParams['studentId'] = studentId;
    
    final response = await client.get(
      ApiEndpoints.courses,
      queryParameters: queryParams,
    );
    
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => CourseModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
  
  @override
  Future<CourseModel> getCourseById(String courseId) async {
    final response = await client.get('${ApiEndpoints.courses}/$courseId');
    return CourseModel.fromJson(response.data as Map<String, dynamic>);
  }
  
  @override
  Future<List<MaterialModel>> getCourseMaterials(String courseId) async {
    final response = await client.get(
      ApiEndpoints.materials,
      queryParameters: {'courseId': courseId},
    );
    
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => MaterialModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
  
  @override
  Future<MaterialModel> uploadMaterial({
    required String courseId,
    required String title,
    required String description,
    required String filePath,
    required MaterialType type,
  }) async {
    final formData = FormData.fromMap({
      'courseId': courseId,
      'title': title,
      'description': description,
      'type': type.name,
      'file': await MultipartFile.fromFile(filePath),
    });
    
    final response = await client.post(
      ApiEndpoints.materials,
      data: formData,
    );
    
    return MaterialModel.fromJson(response.data as Map<String, dynamic>);
  }
}
