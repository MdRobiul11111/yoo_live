part of 'create_room_bloc.dart';


abstract class CreateRoomEvent extends Equatable{

  const CreateRoomEvent();

  @override
  List<Object?> get props => [];

}

class CreateRoom extends CreateRoomEvent{
  final DataForRoom dataForRoom;

  const CreateRoom(this.dataForRoom);

  @override
  List<Object?> get props => [dataForRoom];

}

class FetchProfileDetails extends CreateRoomEvent{
  const FetchProfileDetails();

  @override
  List<Object?> get props => [];
}