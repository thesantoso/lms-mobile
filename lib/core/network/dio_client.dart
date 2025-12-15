import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

class DioClient {
  late final Dio _dio;
  final SharedPreferences _prefs;
  
  DioClient(this._prefs) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl + AppConstants.apiVersion,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );
  }
  
  void _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = _prefs.getString(AppConstants.keyToken);
    final schoolId = _prefs.getString(AppConstants.keySchoolId);
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    if (schoolId != null) {
      options.headers['X-School-Id'] = schoolId;
    }
    
    handler.next(options);
  }
  
  void _onError(DioException error, ErrorInterceptorHandler handler) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException('Connection timeout');
      case DioExceptionType.badResponse:
        _handleStatusCode(error.response?.statusCode);
      case DioExceptionType.cancel:
        throw NetworkException('Request cancelled');
      default:
        throw NetworkException('Network error occurred');
    }
  }
  
  void _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 401:
        throw UnauthorizedException();
      case 404:
        throw NotFoundException();
      case 400:
        throw ValidationException('Invalid request');
      case 500:
      case 502:
      case 503:
        throw ServerException();
      default:
        throw ServerException('Unknown error occurred');
    }
  }
  
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      _handleDioException(e);
      rethrow;
    }
  }
  
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      _handleDioException(e);
      rethrow;
    }
  }
  
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      _handleDioException(e);
      rethrow;
    }
  }
  
  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.delete(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      _handleDioException(e);
      rethrow;
    }
  }
  
  void _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException('Connection timeout');
      case DioExceptionType.badResponse:
        _handleStatusCode(error.response?.statusCode);
      case DioExceptionType.cancel:
        throw NetworkException('Request cancelled');
      default:
        throw NetworkException('Network error occurred');
    }
  }
}
