import '../Error/Failure.dart';

sealed class ApiResult<T> {
  const ApiResult();
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  final int? statusCode; // Can include statusCode if needed
  const ApiSuccess(this.data, {this.statusCode});
}

class ApiFailure<T> extends ApiResult<T> {
  final Failure failure;
  final int? statusCode; // Can include statusCode if needed
  const ApiFailure(this.failure, {this.statusCode});
}
