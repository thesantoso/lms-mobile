class Assignment {
  final String id;
  final String courseId;
  final String courseName;
  final String title;
  final String description;
  final DateTime dueDate;
  final int maxScore;
  final String? attachmentUrl;
  
  Assignment({
    required this.id,
    required this.courseId,
    required this.courseName,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.maxScore,
    this.attachmentUrl,
  });
}

class Submission {
  final String id;
  final String assignmentId;
  final String studentId;
  final String studentName;
  final DateTime submittedAt;
  final String? fileUrl;
  final String? comment;
  final SubmissionStatus status;
  final int? score;
  final String? feedback;
  
  Submission({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.studentName,
    required this.submittedAt,
    this.fileUrl,
    this.comment,
    required this.status,
    this.score,
    this.feedback,
  });
}

enum SubmissionStatus {
  submitted,
  graded,
  late,
  pending;
  
  String get value => name;
}
