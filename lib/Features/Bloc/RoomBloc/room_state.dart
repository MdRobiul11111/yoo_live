part of 'room_bloc.dart';


abstract class RoomState {}

class RoomInitial extends RoomState {}
class RoomLoading extends RoomState {}
class RoomLoaded extends RoomState{
  SingleRoomResponse singleRoomResponse;

  RoomLoaded(this.singleRoomResponse);

  @override
  List<Object?> get props => [singleRoomResponse];
}
class RoomError extends RoomState{
  String errorMessage;

  RoomError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
