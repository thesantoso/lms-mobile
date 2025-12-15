import '../../domain/entities/course.dart';

class CourseModel extends Course {
  CourseModel({
    required super.id,
    required super.schoolId,
    required super.name,
    required super.description,
    required super.teacherId,
    required super.teacherName,
    super.thumbnailUrl,
    required super.startDate,
    required super.endDate,
    required super.studentIds,
  });
  
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      schoolId: json['schoolId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      teacherId: json['teacherId'] as String,
      teacherName: json['teacherName'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      studentIds: (json['studentIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schoolId': schoolId,
      'name': name,
      'description': description,
      'teacherId': teacherId,
      'teacherName': teacherName,
      'thumbnailUrl': thumbnailUrl,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'studentIds': studentIds,
    };
  }
}

class MaterialModel extends Material {
  MaterialModel({
    required super.id,
    required super.courseId,
    required super.title,
    required super.description,
    required super.type,
    required super.fileUrl,
    required super.uploadedAt,
  });
  
  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: MaterialType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MaterialType.document,
      ),
      fileUrl: json['fileUrl'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'type': type.name,
      'fileUrl': fileUrl,
      'uploadedAt': uploadedAt.toIso8601String(),
    };
  }
}
