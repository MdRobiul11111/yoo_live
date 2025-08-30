part of 'created_live_room_bloc.dart';

abstract class CreatedLiveRoomEvent extends Equatable{

  const CreatedLiveRoomEvent();

  @override
  List<Object> get props => [];
}

class FetchCreatedLiveRooms extends CreatedLiveRoomEvent{}
