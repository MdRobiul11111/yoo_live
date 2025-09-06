import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';
import 'package:yoo_live/Features/domain/Model/JoinedCallResponseModel.dart';
import 'package:yoo_live/Features/domain/Model/LeaveCallReponse.dart';
import 'package:yoo_live/Features/domain/Model/SingleRoomModelResponse.dart';
import 'package:yoo_live/Features/domain/Model/ToJoinCallResponseModel.dart';

import '../../../widget/presentation/audio_live_host_view_widget/audio_room_page.dart';
import '../../domain/Service/AgoraService.dart';

part 'room_event.dart';

part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final AuthDataRepository authDataRepository;
  final AgoraService agoraService;
  RoomLoaded? _lastLoaded;

  RoomBloc(this.authDataRepository, this.agoraService) : super(RoomInitial()) {
    on<FetchSingleRoomDetailsEvent>(_fetchSingleRoomDetails);
    on<SwitchSeatEvent>(_switchSeatResponseModel);
    on<LeaveCallEvent>(_leaveCallEvent);
    on<JoinRoomEvent>(_joinRoomEvent);

    on<JoinAgoraChannelEvent>(_onJoinAgoraChannel);
    on<LeaveAgoraChannelEvent>(_onLeaveAgoraChannel);
    on<MuteLocalAudioEvent>(_onMuteLocalAudio);
    on<AgoraVolumeChanged>(_onAgoraVolumeChanged);
    
    // // subscribe to the agora streams
    // _volumeSub = agoraService.volumeStream.listen((volumes) {
    //   add(AgoraVolumeChanged(volumes));
    // });
  }

  Future<void> _onAgoraVolumeChanged(AgoraVolumeChanged event, Emitter<RoomState> emit) async {


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
        print(error);
        emit(JoiningRoomError(error.toString()));
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
      emit(RoomAudioMuted(event.mute));
    } catch (e) {
      emit(RoomError("Failed to mute/unmute: $e"));
    }
  }
}
