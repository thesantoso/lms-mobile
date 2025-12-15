import '../../domain/entities/attendance.dart';

class AttendanceModel extends Attendance {
  AttendanceModel({
    required super.id,
    required super.userId,
    required super.schoolId,
    required super.timestamp,
    required super.latitude,
    required super.longitude,
    super.photoUrl,
    required super.status,
    super.remarks,
  });
  
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      schoolId: json['schoolId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      photoUrl: json['photoUrl'] as String?,
      status: AttendanceStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AttendanceStatus.present,
      ),
      remarks: json['remarks'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'schoolId': schoolId,
      'timestamp': timestamp.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'photoUrl': photoUrl,
      'status': status.name,
      'remarks': remarks,
    };
  }
}
