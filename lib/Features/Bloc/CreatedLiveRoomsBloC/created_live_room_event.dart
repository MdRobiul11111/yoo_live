part of 'created_live_room_bloc.dart';

abstract class CreatedLiveRoomEvent extends Equatable {
  const CreatedLiveRoomEvent();

  @override
  List<Object> get props => [];
}

class FetchCreatedLiveRooms extends CreatedLiveRoomEvent {}

class ConnectSocketEvent extends CreatedLiveRoomEvent {
  const ConnectSocketEvent();

  @override
  List<Object> get props => [];
}

class SetupSocket extends CreatedLiveRoomEvent {
  const SetupSocket();

  @override
  List<Object> get props => [];
}

class JoinSocketRoomEvent extends CreatedLiveRoomEvent{
  final String roomID;

  const JoinSocketRoomEvent(this.roomID);

  @override
  List<Object> get props => [roomID];
}
