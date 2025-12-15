import '../entities/assignment.dart';

abstract class AssignmentRepository {
  Future<List<Assignment>> getAssignments({String? courseId, String? studentId});
  Future<Assignment> getAssignmentById(String assignmentId);
  Future<Assignment> createAssignment({
    required String courseId,
    required String title,
    required String description,
    required DateTime dueDate,
    required int maxScore,
    String? attachmentPath,
  });
  Future<Submission> submitAssignment({
    required String assignmentId,
    required String filePath,
    String? comment,
  });
  Future<List<Submission>> getSubmissions(String assignmentId);
  Future<Submission> gradeSubmission({
    required String submissionId,
    required int score,
    String? feedback,
  });
}
