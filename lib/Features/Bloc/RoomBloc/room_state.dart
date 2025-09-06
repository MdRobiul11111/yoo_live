part of 'room_bloc.dart';

abstract class RoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final SingleRoomResponse singleRoomResponse;

  RoomLoaded(this.singleRoomResponse);

  @override
  List<Object?> get props => [singleRoomResponse];
}

class RoomError extends RoomState {
  final String errorMessage;

  RoomError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class LeaveRoomError extends RoomState {
  final String errorMessage;

  LeaveRoomError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class LeaveRoomSuccess extends RoomState {
  final LeaveCallResponse leaveCallResponse;

  LeaveRoomSuccess(this.leaveCallResponse);

  @override
  List<Object?> get props => [leaveCallResponse];
}

class JoiningRoomLoading extends RoomState {}

class JoiningRoomLoaded extends RoomState {
  final ToJoinCallResponseModel toJoinCallResponseModel;

  JoiningRoomLoaded(this.toJoinCallResponseModel);

  @override
  List<Object?> get props => [toJoinCallResponseModel];
}

class JoiningRoomError extends RoomState {
  final String errorMessage;

  JoiningRoomError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}


class RoomAgoraJoined extends RoomState {}

class RoomAgoraLeft extends RoomState {}

class RoomAudioMuted extends RoomState {
  final bool isMuted;

  RoomAudioMuted(this.isMuted);
}

class UserSpeakingState extends RoomState {
  final Map<int, int> speakingUsers; // uid -> volume

  UserSpeakingState(this.speakingUsers);
}
