import 'package:dio/dio.dart';
import 'package:yoo_live/Core/network/DioClient.dart';
import 'package:yoo_live/Features/domain/DataSource/AuthDataSource.dart';
import 'package:yoo_live/Features/domain/DataSource/LocalDataSource.dart';

class AuthInterceptor extends Interceptor {
  final LocalDataSource localDataSource;
  final AuthDataSource authDataSource;
  final Dio dio;
  bool _isRefreshing = false;

  AuthInterceptor(this.localDataSource, this.dio, this.authDataSource);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 400) {
      // Prevent multiple concurrent refresh attempts
      if (_isRefreshing) {
        return handler.next(err);
      }

      _isRefreshing = true;
      print("error : fetching new token");

      try {
        final tokenResponse =
            await authDataSource.fetchNewAccessTokenWithRefreshToken();

        await tokenResponse.when((data, success) async {
          await localDataSource.setNewAccessToken(data.data?.accessToken ?? "");
          final newRequest = err.requestOptions;
          newRequest.headers['Authorization'] =
              'Bearer ${data.data?.accessToken}';
          final response = await dio.fetch(newRequest);
          handler.resolve(response);
        }, (failure, statusCode) => {handler.next(err)});
      } catch (e) {
        return handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    } else {
      return handler.next(err);
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final int expiryMilliSec = 900;
      final issuedAt = await localDataSource.getIssuedAt();

      if (issuedAt != null) {
        final expireTime = issuedAt.add(Duration(seconds: expiryMilliSec));

        // Check if token is going to expire in next 2 minutes
        if (DateTime.now().isAfter(
          expireTime.subtract(const Duration(minutes: 2)),
        )) {
          // Prevent multiple concurrent refresh attempts
          if (_isRefreshing) {
            // If already refreshing, use current token and let the request proceed
            final token = await localDataSource.getAccessToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            handler.next(options);
            return;
          }

          _isRefreshing = true;
          print("OnRequest : fetching new token");

          try {
            final tokenResponse =
                await authDataSource.fetchNewAccessTokenWithRefreshToken();

            await tokenResponse.when(
              (data, success) async {
                await localDataSource.setNewAccessToken(
                  data.data?.accessToken ?? "",
                );
                options.headers['Authorization'] =
                    'Bearer ${data.data?.accessToken}';
              },
              (failure, statusCode) {
                handler.reject(
                  DioException(
                    requestOptions: options,
                    error: "Token refresh failed",
                  ),
                );
                return;
              },
            );
          } finally {
            _isRefreshing = false;
          }
        } else {
          // Token is still valid
          final token = await localDataSource.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
      } else {
        // No issuedAt found, try to get current token
        final token = await localDataSource.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      }

      handler.next(options);
    } catch (e) {
      print("Error in onRequest: $e");
      handler.next(options);
    }
  }
}
