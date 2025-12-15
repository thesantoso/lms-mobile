import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_datasource.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;
  final LocationService locationService;
  
  AttendanceRepositoryImpl({
    required this.remoteDataSource,
    required this.locationService,
  });
  
  @override
  Future<Attendance> markAttendance({
    required double latitude,
    required double longitude,
    required String photoPath,
  }) async {
    return await remoteDataSource.markAttendance(
      latitude: latitude,
      longitude: longitude,
      photoPath: photoPath,
    );
  }
  
  @override
  Future<List<Attendance>> getAttendanceHistory({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getAttendanceHistory(
      userId: userId,
      startDate: startDate,
      endDate: endDate,
    );
  }
  
  @override
  Future<LocationData> getCurrentLocation() async {
    return await locationService.getCurrentLocation();
  }
  
  @override
  Future<bool> isWithinGeofence({
    required double userLat,
    required double userLng,
    required double schoolLat,
    required double schoolLng,
    required double radiusInMeters,
  }) async {
    return await locationService.isWithinGeofence(
      userLat: userLat,
      userLng: userLng,
      schoolLat: schoolLat,
      schoolLng: schoolLng,
      radiusInMeters: radiusInMeters,
    );
  }
}
