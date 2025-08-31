part of 'room_bloc.dart';

abstract class RoomState {}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  SingleRoomResponse singleRoomResponse;
  JoinedCallReponseModel joinedCallReponseModel;

  RoomLoaded(this.singleRoomResponse,this.joinedCallReponseModel);

  @override
  List<Object?> get props => [singleRoomResponse];
}

class RoomError extends RoomState {
  String errorMessage;

  RoomError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class JoinedRoomStateLoading extends RoomState {}

class JoinedRoomStateLoaded extends RoomState {
  JoinedCallReponseModel joinedCallResponseModel;

  JoinedRoomStateLoaded(this.joinedCallResponseModel);

  @override
  List<Object?> get props => [joinedCallResponseModel];
}


class JoinedRoomStateError extends RoomState {
  String errorMessage;

  JoinedRoomStateError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class LeaveRoomError extends RoomState {
  String errorMessage;

  LeaveRoomError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}


class LeaveRoomSuccess extends RoomState {
  LeaveCallResponse leaveCallResponse;

  LeaveRoomSuccess(this.leaveCallResponse);

  @override
  List<Object?> get props => [leaveCallResponse];
}