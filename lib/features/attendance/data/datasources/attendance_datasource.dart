import 'dart:io';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/attendance_model.dart';
import '../../domain/entities/attendance.dart';

abstract class AttendanceRemoteDataSource {
  Future<AttendanceModel> markAttendance({
    required double latitude,
    required double longitude,
    required String photoPath,
  });
  
  Future<List<AttendanceModel>> getAttendanceHistory({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  });
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final DioClient client;
  
  AttendanceRemoteDataSourceImpl(this.client);
  
  @override
  Future<AttendanceModel> markAttendance({
    required double latitude,
    required double longitude,
    required String photoPath,
  }) async {
    final formData = FormData.fromMap({
      'latitude': latitude,
      'longitude': longitude,
      'photo': await MultipartFile.fromFile(
        photoPath,
        filename: 'attendance_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ),
    });
    
    final response = await client.post(
      ApiEndpoints.markAttendance,
      data: formData,
    );
    
    return AttendanceModel.fromJson(response.data as Map<String, dynamic>);
  }
  
  @override
  Future<List<AttendanceModel>> getAttendanceHistory({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final queryParams = <String, dynamic>{
      'userId': userId,
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    };
    
    final response = await client.get(
      ApiEndpoints.getAttendance,
      queryParameters: queryParams,
    );
    
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => AttendanceModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

abstract class LocationService {
  Future<LocationData> getCurrentLocation();
  Future<bool> isWithinGeofence({
    required double userLat,
    required double userLng,
    required double schoolLat,
    required double schoolLng,
    required double radiusInMeters,
  });
}

class LocationServiceImpl implements LocationService {
  @override
  Future<LocationData> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException('Location services are disabled');
    }
    
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw PermissionException('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      throw PermissionException(
          'Location permissions are permanently denied');
    }
    
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    
    return LocationData(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
  
  @override
  Future<bool> isWithinGeofence({
    required double userLat,
    required double userLng,
    required double schoolLat,
    required double schoolLng,
    required double radiusInMeters,
  }) async {
    final distance = _calculateDistance(
      userLat,
      userLng,
      schoolLat,
      schoolLng,
    );
    
    return distance <= radiusInMeters;
  }
  
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadius = 6371000.0; // meters
    
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }
  
  double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
