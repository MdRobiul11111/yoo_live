part of 'created_live_room_bloc.dart';


abstract class CreatedLiveRoomState extends Equatable {
  const CreatedLiveRoomState();
  @override
  List<Object> get props => [];
}

class CreatedLiveRoomInitial extends CreatedLiveRoomState {}
class CreatedLiveRoomLoading extends CreatedLiveRoomState {}
class CreatedLiveRoomLoaded extends CreatedLiveRoomState {
  final CreatedLiveRoomResponse rooms;
  final SliderResponse sliderResponse;

  const CreatedLiveRoomLoaded({required this.rooms,required this.sliderResponse});
  @override
  List<Object> get props => [rooms];
}

class CreatedLiveRoomError extends CreatedLiveRoomState {
  final String message;
  const CreatedLiveRoomError({required this.message});
  @override
  List<Object> get props => [message];
}