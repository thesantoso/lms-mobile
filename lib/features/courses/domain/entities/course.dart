class Course {
  final String id;
  final String schoolId;
  final String name;
  final String description;
  final String teacherId;
  final String teacherName;
  final String? thumbnailUrl;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> studentIds;
  
  Course({
    required this.id,
    required this.schoolId,
    required this.name,
    required this.description,
    required this.teacherId,
    required this.teacherName,
    this.thumbnailUrl,
    required this.startDate,
    required this.endDate,
    required this.studentIds,
  });
}

class Material {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final MaterialType type;
  final String fileUrl;
  final DateTime uploadedAt;
  
  Material({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.type,
    required this.fileUrl,
    required this.uploadedAt,
  });
}

enum MaterialType {
  pdf,
  video,
  document,
  image,
  link;
  
  String get value => name;
}
