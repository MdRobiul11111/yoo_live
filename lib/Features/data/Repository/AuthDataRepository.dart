import 'package:dartz/dartz.dart';
import 'package:yoo_live/Core/Error/Failure.dart';
import 'package:yoo_live/Core/network/DioClient.dart';
import 'package:yoo_live/Features/data/Entity/UserEntity.dart';
import 'package:yoo_live/Features/domain/DataSource/AuthDataSource.dart';
import 'package:yoo_live/Features/domain/Model/AuthProfile.dart';
import 'package:yoo_live/Features/domain/Model/SearchProfileResponse.dart';
import 'package:yoo_live/Features/domain/Model/SingleRoomModelResponse.dart';
import 'package:yoo_live/Features/domain/Model/TokenResponse.dart';

import '../../domain/Model/CreatedLiveRoomReponse.dart';
import '../../domain/Model/CreatingRoomResponse.dart';

abstract class AuthDataRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  Future<Either<Failure, UserEntity>> signInWithFaceBook();

  Future<Either<Failure, AuthProfile>> fetchProfileDetails();

  Future<Either<Failure, TokenResponse>> fetchNewAccessToken();

  Future<Either<Failure, SearchProfileResponse>> fetchSearchProfile(
    String query,
  );

  Future<Either<Failure, CreatedLiveRoomResponse>> fetchListOfRooms();
  Future<Either<Failure, CreatingRoomResponse>> createRoom(DataForRoom dataForRoom);
  Future<Either<Failure, SingleRoomResponse>> fetchSingleRoom(String roomId);

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

  @override
  Future<Either<Failure, CreatedLiveRoomResponse>> fetchListOfRooms() async{
    final searchResponse = await authDataSource.fetchListOfRooms();
    return searchResponse.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    );
  }

  @override
  Future<Either<Failure, CreatingRoomResponse>> createRoom(DataForRoom dataForRoom) {
    return authDataSource.createRoom(dataForRoom).then((value) => value.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    ));
  }

  @override
  Future<Either<Failure, SingleRoomResponse>> fetchSingleRoom(String roomId) async{
    final roomModelResponse = await authDataSource.fetchSingleRoom(roomId);
    return roomModelResponse.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    );
  }
}
