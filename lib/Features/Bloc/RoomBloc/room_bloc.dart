import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoo_live/Constants/ApiConstants.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';
import 'package:yoo_live/Features/domain/Model/LeaveCallReponse.dart';
import 'package:yoo_live/Features/domain/Model/SingleRoomModelResponse.dart';
import 'package:yoo_live/Features/domain/Model/ToJoinCallResponseModel.dart';

import '../../../Core/Error/Failure.dart';
import '../../domain/Service/AgoraService.dart';
import '../../domain/Service/SocketService.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final AuthDataRepository authDataRepository;
  final AgoraService agoraService;
  final SocketService socketService;
  RoomLoaded? _lastLoaded;
  SharedPreferences sharedPreferences;

  RoomBloc(this.authDataRepository, this.agoraService,this.socketService,this.sharedPreferences) : super(RoomInitial()) {
    on<FetchSingleRoomDetailsEvent>(_fetchSingleRoomDetails);
    on<SwitchSeatEvent>(_switchSeatResponseModel);
    on<LeaveCallEvent>(_leaveCallEvent);
    on<JoinRoomEvent>(_joinRoomEvent);
    on<JoinAgoraChannelEvent>(_onJoinAgoraChannel);
    on<LeaveAgoraChannelEvent>(_onLeaveAgoraChannel);
    on<MuteLocalAudioEvent>(_onMuteLocalAudio);
    on<SendMessage>(_sendMessage);
  }

  Future<void> _fetchSingleRoomDetails(
      FetchSingleRoomDetailsEvent event,
      Emitter<RoomState> emit,
      ) async {
    emit(RoomLoading());

    final response = await authDataRepository.fetchSingleRoom(event.roomId);

    await response.fold(
          (error)  async{
        emit(RoomError(error.toString()));
      },
          (room) async {
        _lastLoaded=RoomLoaded(room);
        emit(_lastLoaded!);
      },
    );
  }

  Future<void> _switchSeatResponseModel(
      SwitchSeatEvent event,
      Emitter<RoomState> emit,
      ) async {
    emit(RoomLoading());
    final switchSeatResponse = await authDataRepository.switchSeat(
      event.roomId,
      event.seatNo,
    );
    await switchSeatResponse.fold(
            (error){
          print(error);
        },
            (seat) async{
          await _fetchSingleRoomDetails(FetchSingleRoomDetailsEvent(event.roomId), emit);
        });
  }

  Future<void> _leaveCallEvent(
      LeaveCallEvent event,
      Emitter<RoomState> emit,
      ) async {
    emit(RoomLoading());
    final leaveCallResponse = await authDataRepository.leaveCall(event.roomId);
    leaveCallResponse.fold(
          (error) {
        emit(LeaveRoomError(error.toString()));
      },
          (leaveCall) {
        emit(LeaveRoomSuccess(leaveCall));
        add(LeaveAgoraChannelEvent());
      },
    );
  }

  Future<void> _joinRoomEvent(
      JoinRoomEvent event,
      Emitter<RoomState> emit,
      ) async {
    emit(JoiningRoomLoading());
    final joinRoomResponse = await authDataRepository.joinCall(event.roomId);
    joinRoomResponse.fold(
          (error) {
        String errorMessage;
        if (error is ServerFailure) {
          errorMessage = error.message;
        } else if (error is NetworkFailure) {
          errorMessage = error.message;
        } else {
          errorMessage = 'An unknown error occurred.';
        }
        print(error);
        emit(RoomError(errorMessage));
      },
          (joinRoom) {
        emit(JoiningRoomLoaded(joinRoom));
        add(FetchSingleRoomDetailsEvent(event.roomId));

        final roomId = joinRoom.data?.roomId;
        final userId = joinRoom.data?.userId;
        if (roomId != null && roomId.isNotEmpty && userId != null) {
          add(JoinAgoraChannelEvent(roomId, userId));
        } else {
          emit(RoomError("Invalid room or user ID received from server."));
        }
      },
    );
  }

  FutureOr<void> _onJoinAgoraChannel(
      JoinAgoraChannelEvent event,
      Emitter<RoomState> emit,
      ) async {
    try {
      await agoraService.initialize();
      await agoraService.joinChannel(event.channelName, event.uid); // correct user id is also passing
      emit(RoomAgoraJoined());
    } catch (e) {
      emit(RoomError("Failed to join Agora channel: $e"));
    }
  }

  FutureOr<void> _onLeaveAgoraChannel(
      LeaveAgoraChannelEvent event,
      Emitter<RoomState> emit,
      ) async {
    try {
      await agoraService.leaveChannel();
      agoraService.dispose();
      emit(RoomAgoraLeft());
    } catch (e) {
      emit(RoomError("Failed to leave Agora channel: $e"));
    }
  }

  FutureOr<void> _onMuteLocalAudio(
      MuteLocalAudioEvent event,
      Emitter<RoomState> emit,
      ) async {
    try {
      await agoraService.muteLocalAudio(event.mute);
      //emit(RoomAudioMuted(event.mute));
    } catch (e) {
      print(e);
      // emit(RoomError("Failed to mute/unmute: $e"));
    }
  }
  Future<void> _sendMessage(SendMessage event, Emitter<RoomState> emit) async{
    final userId = sharedPreferences.getString(ApiConstants.UserServerId);
    print("user id ; $userId");
    socketService.sendMessage(event.roomId, event.message, userId??"");
  }
}
