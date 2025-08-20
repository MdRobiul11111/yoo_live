import 'package:dartz/dartz.dart';
import 'package:yoo_live/Core/Error/Failure.dart';
import 'package:yoo_live/Core/network/DioClient.dart';
import 'package:yoo_live/Features/data/Entity/UserEntity.dart';
import 'package:yoo_live/Features/domain/DataSource/AuthDataSource.dart';
import 'package:yoo_live/Features/domain/Model/AuthProfile.dart';
import 'package:yoo_live/Features/domain/Model/SearchProfileResponse.dart';
import 'package:yoo_live/Features/domain/Model/TokenResponse.dart';

abstract class AuthDataRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  Future<Either<Failure, UserEntity>> signInWithFaceBook();

  Future<Either<Failure, AuthProfile>> fetchProfileDetails();

  Future<Either<Failure, TokenResponse>> fetchNewAccessToken();

  Future<Either<Failure, SearchProfileResponse>> fetchSearchProfile(
    String query,
  );
}

class AuthDataRepositoryImpl extends AuthDataRepository {
  final AuthDataSource authDataSource;

  AuthDataRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final userModel = await authDataSource.signInWithGoogle();
      return right(userModel);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFaceBook() async {
    try {
      final userModel = await authDataSource.signInWithFacebook();
      return right(userModel);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthProfile>> fetchProfileDetails() async {
    final result = await authDataSource.fetchProfileDetails();
    return result.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    );
  }

  @override
  Future<Either<Failure, TokenResponse>> fetchNewAccessToken() async {
    final result = await authDataSource.fetchNewAccessTokenWithRefreshToken();
    return result.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    );
  }

  @override
  Future<Either<Failure, SearchProfileResponse>> fetchSearchProfile(
    String query,
  ) async {
    final searchResponse = await authDataSource.fetchSearchProfile(query);
    return searchResponse.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    );
  }
}
