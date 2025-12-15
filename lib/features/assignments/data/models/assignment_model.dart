import '../../domain/entities/assignment.dart';

class AssignmentModel extends Assignment {
  AssignmentModel({
    required super.id,
    required super.courseId,
    required super.courseName,
    required super.title,
    required super.description,
    required super.dueDate,
    required super.maxScore,
    super.attachmentUrl,
  });
  
  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      courseName: json['courseName'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      maxScore: json['maxScore'] as int,
      attachmentUrl: json['attachmentUrl'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'courseName': courseName,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'maxScore': maxScore,
      'attachmentUrl': attachmentUrl,
    };
  }
}

class SubmissionModel extends Submission {
  SubmissionModel({
    required super.id,
    required super.assignmentId,
    required super.studentId,
    required super.studentName,
    required super.submittedAt,
    super.fileUrl,
    super.comment,
    required super.status,
    super.score,
    super.feedback,
  });
  
  factory SubmissionModel.fromJson(Map<String, dynamic> json) {
    return SubmissionModel(
      id: json['id'] as String,
      assignmentId: json['assignmentId'] as String,
      studentId: json['studentId'] as String,
      studentName: json['studentName'] as String,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      fileUrl: json['fileUrl'] as String?,
      comment: json['comment'] as String?,
      status: SubmissionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => SubmissionStatus.pending,
      ),
      score: json['score'] as int?,
      feedback: json['feedback'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assignmentId': assignmentId,
      'studentId': studentId,
      'studentName': studentName,
      'submittedAt': submittedAt.toIso8601String(),
      'fileUrl': fileUrl,
      'comment': comment,
      'status': status.name,
      'score': score,
      'feedback': feedback,
    };
  }
}
