import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

class MarkAttendanceUseCase {
  final AttendanceRepository repository;
  
  MarkAttendanceUseCase(this.repository);
  
  Future<Attendance> call({
    required double latitude,
    required double longitude,
    required String photoPath,
  }) {
    return repository.markAttendance(
      latitude: latitude,
      longitude: longitude,
      photoPath: photoPath,
    );
  }
}

class GetAttendanceHistoryUseCase {
  final AttendanceRepository repository;
  
  GetAttendanceHistoryUseCase(this.repository);
  
  Future<List<Attendance>> call({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return repository.getAttendanceHistory(
      userId: userId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

class GetCurrentLocationUseCase {
  final AttendanceRepository repository;
  
  GetCurrentLocationUseCase(this.repository);
  
  Future<LocationData> call() {
    return repository.getCurrentLocation();
  }
}

class CheckGeofenceUseCase {
  final AttendanceRepository repository;
  
  CheckGeofenceUseCase(this.repository);
  
  Future<bool> call({
    required double userLat,
    required double userLng,
    required double schoolLat,
    required double schoolLng,
    required double radiusInMeters,
  }) {
    return repository.isWithinGeofence(
      userLat: userLat,
      userLng: userLng,
      schoolLat: schoolLat,
      schoolLng: schoolLng,
      radiusInMeters: radiusInMeters,
    );
  }
}
