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




