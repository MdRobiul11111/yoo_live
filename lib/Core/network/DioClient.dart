import 'package:dio/dio.dart';

import '../Error/Failure.dart';
import 'ApiResult.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    dio.options.baseUrl = 'https://yoo-live-q5fs.onrender.com/'; // Base URL for all requests
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.interceptors.add(LogInterceptor(requestBody: true,responseBody: true));
  }

  Future<ApiResult<T>> apiResponseHandler<T>(
      String path, {
        required T Function(dynamic json) parser,
        String method = 'GET',
        Map<String, dynamic>? queryParameters,
        dynamic data,
        Options? options,
      }) async {
    try {
      Response response;
      switch (method.toUpperCase()) {
        case 'GET':
          response = await dio.get(
            path,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case 'POST':
          response = await dio.post(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case 'PUT':
          response = await dio.put(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case 'DELETE':
          response = await dio.delete(
            path,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        default:
          throw ArgumentError('Unsupported HTTP method: $method');
      }

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if (response.data == null && T != dynamic) {
          return ApiSuccess(null as T, statusCode: response.statusCode);
        }
        return ApiSuccess(parser(response.data), statusCode: response.statusCode);
      } else {
        return ApiFailure(
          _mapStatusCodeToFailure(response.statusCode!, response.statusMessage),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      // Dio-specific error handling
      return ApiFailure(_mapDioExceptionToFailure(e));
    } catch (e) {
      // General unexpected errors
      return ApiFailure(const ServerFailure(message: 'An unexpected error occurred.'));
    }
  }

  Failure _mapDioExceptionToFailure(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return const NetworkFailure(message: 'Connection timed out.');
    } else if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.response?.data['message'] as String? ?? e.message;
      return _mapStatusCodeToFailure(statusCode, errorMessage);
    } else if (e.type == DioExceptionType.cancel) {
      return const ServerFailure(message: 'Request cancelled.');
    } else if (e.type == DioExceptionType.unknown) {
      if (e.message != null && e.message!.contains('SocketException')) {
        return const NetworkFailure(message: 'No internet connection.');
      }
      return const ServerFailure(message: 'An unknown network error occurred.');
    }
    return ServerFailure(message: e.message ?? 'An unexpected Dio error occurred.');
  }

  Failure _mapStatusCodeToFailure(int? statusCode, String? message) {
    switch (statusCode) {
      case 400:
        return ServerFailure(message: message ?? 'Bad Request.');
      case 401:
        return ServerFailure(message: message ?? 'Unauthorized.');
      case 403:
        return ServerFailure(message: message ?? 'Forbidden.');
      case 404:
        return ServerFailure(message: message ?? 'Not Found.');
      case 409:
        return ServerFailure(message: message ?? 'Conflict.');
      case 422:
        return ServerFailure(message: message ?? 'Unprocessable Entity (Validation Failed).');
      case 500:
        return ServerFailure(message: message ?? 'Internal Server Error.');
      case 502:
        return ServerFailure(message: message ?? 'Bad Gateway.');
      case 503:
        return ServerFailure(message: message ?? 'Service Unavailable.');
      default:
        return ServerFailure(message: message ?? 'Received invalid status code: $statusCode');
    }
  }
}


// Extension to add .when() or .fold() for sealed classes
extension ApiResultExtension<T> on ApiResult<T> {
  R when<R>(
      R Function(T data, int? statusCode) onSuccess,
      R Function(Failure failure, int? statusCode) onFailure,
      ) {
    if (this is ApiSuccess<T>) {
      final success = this as ApiSuccess<T>;
      return onSuccess(success.data, success.statusCode);
    } else if (this is ApiFailure<T>) {
      final failure = this as ApiFailure<T>;
      return onFailure(failure.failure, failure.statusCode);
    }
    throw StateError('Unknown ApiResult type');
  }
}