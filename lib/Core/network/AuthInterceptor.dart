import 'package:dio/dio.dart';
import 'package:yoo_live/Features/domain/DataSource/AuthDataSource.dart';
import 'package:yoo_live/Features/domain/DataSource/LocalDataSource.dart';

class AuthInterceptor extends Interceptor{

  final LocalDataSource localDataSource;
  final AuthDataSource authDataSource;

  final Dio dio;
  bool _isRefreshing = false;

  AuthInterceptor(this.localDataSource, this.dio,this.authDataSource);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    //
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    //
  }

  Future<void> _refreshTokenIfNeeded() async {
    if (_isRefreshing) return;
    _isRefreshing = true;
    try {
      await authDataSource.fetchRefreshToken();
    } catch (e) {
      // Token refresh failed, user will need to re-authenticate
    } finally {
      _isRefreshing = false;
    }
  }

}