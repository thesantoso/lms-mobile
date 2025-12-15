abstract class AppException implements Exception {
  final String message;
  final int? statusCode;
  
  AppException(this.message, [this.statusCode]);
  
  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException([String message = 'Network error occurred'])
      : super(message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Unauthorized access'])
      : super(message, 401);
}

class ValidationException extends AppException {
  ValidationException(String message) : super(message, 400);
}

class NotFoundException extends AppException {
  NotFoundException([String message = 'Resource not found'])
      : super(message, 404);
}

class ServerException extends AppException {
  ServerException([String message = 'Server error occurred'])
      : super(message, 500);
}

class CacheException extends AppException {
  CacheException([String message = 'Cache error occurred']) : super(message);
}

class LocationException extends AppException {
  LocationException([String message = 'Location error occurred'])
      : super(message);
}

class PermissionException extends AppException {
  PermissionException([String message = 'Permission denied']) : super(message);
}
