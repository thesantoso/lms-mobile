import '../entities/attendance.dart';

abstract class AttendanceRepository {
  Future<Attendance> markAttendance({
    required double latitude,
    required double longitude,
    required String photoPath,
  });
  
  Future<List<Attendance>> getAttendanceHistory({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  Future<LocationData> getCurrentLocation();
  
  Future<bool> isWithinGeofence({
    required double userLat,
    required double userLng,
    required double schoolLat,
    required double schoolLng,
    required double radiusInMeters,
  });
}
