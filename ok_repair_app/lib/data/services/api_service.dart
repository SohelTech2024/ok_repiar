import 'package:dio/dio.dart';
import 'package:ok_repair_app/config/environment.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token if available
          // options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onError: (error, handler) {
          // Handle errors globally
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw Exception('Connection timeout');
      case DioExceptionType.sendTimeout:
        throw Exception('Send timeout');
      case DioExceptionType.receiveTimeout:
        throw Exception('Receive timeout');
      case DioExceptionType.badCertificate:
        throw Exception('Bad certificate');
      case DioExceptionType.badResponse:
        throw Exception('Bad response: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        throw Exception('Request cancelled');
      case DioExceptionType.connectionError:
        throw Exception('Connection error');
      case DioExceptionType.unknown:
        throw Exception('Unknown error: ${error.message}');
    }
  }
}