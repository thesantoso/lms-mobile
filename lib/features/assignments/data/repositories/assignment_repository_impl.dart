import '../../domain/entities/assignment.dart';
import '../../domain/repositories/assignment_repository.dart';
import '../datasources/assignment_datasource.dart';

class AssignmentRepositoryImpl implements AssignmentRepository {
  final AssignmentRemoteDataSource remoteDataSource;
  
  AssignmentRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<List<Assignment>> getAssignments({
    String? courseId,
    String? studentId,
  }) async {
    return await remoteDataSource.getAssignments(
      courseId: courseId,
      studentId: studentId,
    );
  }
  
  @override
  Future<Assignment> getAssignmentById(String assignmentId) async {
    return await remoteDataSource.getAssignmentById(assignmentId);
  }
  
  @override
  Future<Assignment> createAssignment({
    required String courseId,
    required String title,
    required String description,
    required DateTime dueDate,
    required int maxScore,
    String? attachmentPath,
  }) async {
    return await remoteDataSource.createAssignment(
      courseId: courseId,
      title: title,
      description: description,
      dueDate: dueDate,
      maxScore: maxScore,
      attachmentPath: attachmentPath,
    );
  }
  
  @override
  Future<Submission> submitAssignment({
    required String assignmentId,
    required String filePath,
    String? comment,
  }) async {
    return await remoteDataSource.submitAssignment(
      assignmentId: assignmentId,
      filePath: filePath,
      comment: comment,
    );
  }
  
  @override
  Future<List<Submission>> getSubmissions(String assignmentId) async {
    return await remoteDataSource.getSubmissions(assignmentId);
  }
  
  @override
  Future<Submission> gradeSubmission({
    required String submissionId,
    required int score,
    String? feedback,
  }) async {
    return await remoteDataSource.gradeSubmission(
      submissionId: submissionId,
      score: score,
      feedback: feedback,
    );
  }
}
