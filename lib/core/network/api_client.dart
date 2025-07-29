import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rick_and_morty/core/error/api_exception.dart';

class ApiClient {
  final Dio _dio;
  String get baseUrl => _baseUrl;
  static const _baseUrl = "https://rickandmortyapi.com/api/";

  factory ApiClient() => instance;
  static final ApiClient instance = ApiClient._instance();
  ApiClient._instance() : _dio = Dio(BaseOptions(baseUrl: _baseUrl));

  Future<Response> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await _dio.get(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (_) {
      throw ApiException(message: 'Неизвестная ошибка. Попробуйте позже.');
    }
  }

  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (_) {
      throw ApiException(message: 'Неизвестная ошибка. Попробуйте позже.');
    }
  }

  Future<Response> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (_) {
      throw ApiException(message: 'Неизвестная ошибка. Попробуйте позже.');
    }
  }

  static ApiException _handleDioError(DioException e) {
    final statusCode = e.response?.statusCode;

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ApiException(
        statusCode: statusCode,
        message: "Время ожидания истекло. Повторите позже.",
      );
    } else if (e.type == DioExceptionType.badResponse) {
      return ApiException(
        statusCode: statusCode,
        message: 'Ошибка на стороне сервера. Повторите позже.',
      );
    } else if (e.type == DioExceptionType.cancel) {
      return ApiException(
        statusCode: statusCode,
        message: 'Запрос был отменён.',
      );
    } else if (e.error is SocketException) {
      return ApiException(
        statusCode: statusCode,
        message: 'Нет подключения к интернету.',
      );
    } else {
      return ApiException(
        statusCode: statusCode,
        message: 'Упс... что-то пошло не так.',
      );
    }
  }
}
