part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable{

  const RoomEvent();

  @override
  List<Object?> get props => [];
}

class FetchSingleRoomDetailsEvent extends RoomEvent{
  final String roomId;

  const FetchSingleRoomDetailsEvent(this.roomId);

  @override
  List<Object?> get props => [roomId];
}


class SwitchSeatEvent extends RoomEvent{
  final String roomId;
  final int seatNo;

  const SwitchSeatEvent(this.roomId,this.seatNo);

  @override
  List<Object?> get props => [roomId,seatNo];
}


class LeaveCallEvent extends RoomEvent{
  final String roomId;

  const LeaveCallEvent(this.roomId);

  @override
  List<Object?> get props => [roomId];
}


class JoinRoomEvent extends RoomEvent{
  final String roomId;

  const JoinRoomEvent(this.roomId);

  @override
  List<Object?> get props => [roomId];
}



