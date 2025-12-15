import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/assignment_model.dart';

abstract class AssignmentRemoteDataSource {
  Future<List<AssignmentModel>> getAssignments({
    String? courseId,
    String? studentId,
  });
  Future<AssignmentModel> getAssignmentById(String assignmentId);
  Future<AssignmentModel> createAssignment({
    required String courseId,
    required String title,
    required String description,
    required DateTime dueDate,
    required int maxScore,
    String? attachmentPath,
  });
  Future<SubmissionModel> submitAssignment({
    required String assignmentId,
    required String filePath,
    String? comment,
  });
  Future<List<SubmissionModel>> getSubmissions(String assignmentId);
  Future<SubmissionModel> gradeSubmission({
    required String submissionId,
    required int score,
    String? feedback,
  });
}

class AssignmentRemoteDataSourceImpl implements AssignmentRemoteDataSource {
  final DioClient client;
  
  AssignmentRemoteDataSourceImpl(this.client);
  
  @override
  Future<List<AssignmentModel>> getAssignments({
    String? courseId,
    String? studentId,
  }) async {
    final queryParams = <String, dynamic>{};
    if (courseId != null) queryParams['courseId'] = courseId;
    if (studentId != null) queryParams['studentId'] = studentId;
    
    final response = await client.get(
      ApiEndpoints.assignments,
      queryParameters: queryParams,
    );
    
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => AssignmentModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
  
  @override
  Future<AssignmentModel> getAssignmentById(String assignmentId) async {
    final response =
        await client.get('${ApiEndpoints.assignments}/$assignmentId');
    return AssignmentModel.fromJson(response.data as Map<String, dynamic>);
  }
  
  @override
  Future<AssignmentModel> createAssignment({
    required String courseId,
    required String title,
    required String description,
    required DateTime dueDate,
    required int maxScore,
    String? attachmentPath,
  }) async {
    final data = {
      'courseId': courseId,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'maxScore': maxScore,
    };
    
    FormData? formData;
    if (attachmentPath != null) {
      formData = FormData.fromMap({
        ...data,
        'attachment': await MultipartFile.fromFile(attachmentPath),
      });
    }
    
    final response = await client.post(
      ApiEndpoints.assignments,
      data: formData ?? data,
    );
    
    return AssignmentModel.fromJson(response.data as Map<String, dynamic>);
  }
  
  @override
  Future<SubmissionModel> submitAssignment({
    required String assignmentId,
    required String filePath,
    String? comment,
  }) async {
    final formData = FormData.fromMap({
      'assignmentId': assignmentId,
      'file': await MultipartFile.fromFile(filePath),
      if (comment != null) 'comment': comment,
    });
    
    final response = await client.post(
      ApiEndpoints.submissions,
      data: formData,
    );
    
    return SubmissionModel.fromJson(response.data as Map<String, dynamic>);
  }
  
  @override
  Future<List<SubmissionModel>> getSubmissions(String assignmentId) async {
    final response = await client.get(
      ApiEndpoints.submissions,
      queryParameters: {'assignmentId': assignmentId},
    );
    
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => SubmissionModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
  
  @override
  Future<SubmissionModel> gradeSubmission({
    required String submissionId,
    required int score,
    String? feedback,
  }) async {
    final response = await client.post(
      ApiEndpoints.grades,
      data: {
        'submissionId': submissionId,
        'score': score,
        if (feedback != null) 'feedback': feedback,
      },
    );
    
    return SubmissionModel.fromJson(response.data as Map<String, dynamic>);
  }
}
