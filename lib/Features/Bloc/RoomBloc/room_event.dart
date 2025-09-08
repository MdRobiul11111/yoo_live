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

class JoinAgoraChannelEvent extends RoomEvent {
  final String channelName;
  final int uid;

  const JoinAgoraChannelEvent(this.channelName, this.uid);
}

class LeaveAgoraChannelEvent extends RoomEvent {}

class MuteLocalAudioEvent extends RoomEvent {
  final bool mute;

  const MuteLocalAudioEvent(this.mute);
}

class AgoraVolumeChanged extends RoomEvent {

  const AgoraVolumeChanged();
  @override
  List<Object?> get props => [];
}




class SendMessage extends RoomEvent {
  final String roomId;
  final String message;

  const SendMessage(this.roomId,this.message,);

  @override
  List<Object?> get props => [roomId,message];
}


