part of 'create_room_bloc.dart';


abstract class CreateRoomState {}

class CreateRoomInitial extends CreateRoomState {}
class CreateRoomLoading extends CreateRoomState {}
class CreateRoomSuccess extends CreateRoomState {
  CreatingRoomResponse creatingRoomResponse;

  CreateRoomSuccess(this.creatingRoomResponse);

  @override
  List<Object?> get props => [creatingRoomResponse];
}

class CreateRoomFailure extends CreateRoomState {
  final String message;
  CreateRoomFailure(this.message);
  @override
  List<Object?> get props => [message];
}


