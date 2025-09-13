import 'package:dartz/dartz.dart';
import 'package:yoo_live/Core/Error/Failure.dart';
import 'package:yoo_live/Core/network/DioClient.dart';
import 'package:yoo_live/Features/data/Entity/UserEntity.dart';
import 'package:yoo_live/Features/domain/DataSource/AuthDataSource.dart';
import 'package:yoo_live/Features/domain/Model/AuthProfile.dart';
import 'package:yoo_live/Features/domain/Model/JoinedCallResponseModel.dart';
import 'package:yoo_live/Features/domain/Model/LeaveCallReponse.dart';
import 'package:yoo_live/Features/domain/Model/MuteMemberResponse.dart';
import 'package:yoo_live/Features/domain/Model/RoomMessageModel.dart';
import 'package:yoo_live/Features/domain/Model/SearchProfileResponse.dart';
import 'package:yoo_live/Features/domain/Model/SingleRoomModelResponse.dart';
import 'package:yoo_live/Features/domain/Model/ToJoinCallResponseModel.dart';
import 'package:yoo_live/Features/domain/Model/TokenResponse.dart';

import '../../domain/Model/CreatedLiveRoomReponse.dart';
import '../../domain/Model/CreatingRoomResponse.dart';
import '../../domain/Model/SliderResponse.dart';
import '../../domain/Model/SwitchSeatResponse.dart';

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
  Future<Either<Failure, ToJoinCallResponseModel>> joinCall(String roomId);
  Future<Either<Failure, LeaveCallResponse>> leaveCall(String roomId);
  Future<Either<Failure, SwitchSeatResponse>> switchSeat(String roomId,int seatNo);
  Future<Either<Failure, MuteMemberResponse>> muteMember(String roomId, String userId, bool isMute);
  Future<Either<Failure, JoinedCallReponseModel>> joinedCallResponse(String roomId, String status);
  Future<Either<Failure, SliderResponse>> fetchSlider();
  Future<Either<Failure, RoomMessagesModel>> fetchRoomMessages(String roomId);


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

  @override
  Future<Either<Failure, ToJoinCallResponseModel>> joinCall(String roomId) async{
    final joinCallResponse = await authDataSource.joinCall(roomId);
    return joinCallResponse.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    );
  }

  @override
  Future<Either<Failure, JoinedCallReponseModel>> joinedCallResponse(String roomId, String status) async{
    final joinedCallResponse = await authDataSource.joinedCallResponse(roomId, status);
    return joinedCallResponse.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    );
  }

  @override
  Future<Either<Failure, LeaveCallResponse>> leaveCall(String roomId) async{
    final leaveCallResponse = await authDataSource.leaveCall(roomId);
    return leaveCallResponse.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    );
  }

  @override
  Future<Either<Failure, MuteMemberResponse>> muteMember(String roomId, String userId, bool isMute) async{
    final muteMemberResponse = await authDataSource.muteMember(roomId, userId, isMute);
    return muteMemberResponse.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    );
  }

  @override
  Future<Either<Failure, SwitchSeatResponse>> switchSeat(String roomId,int seatNo) async{
    final switchSeatResponse = await authDataSource.switchSeat(roomId, seatNo);
    return switchSeatResponse.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    );
  }

  @override
  Future<Either<Failure, SliderResponse>> fetchSlider() {
    return authDataSource.fetchSlider().then((value) => value.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    ));
  }

  @override
  Future<Either<Failure, RoomMessagesModel>> fetchRoomMessages(String roomId) {
    return authDataSource.fetchRoomMessages(roomId).then((value) => value.when(
          (data, success) => Right(data),
          (failure, statusCode) => Left(failure),
    ));
  }
}
