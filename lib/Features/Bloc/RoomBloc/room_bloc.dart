import 'dart:async';

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

part 'room_event.dart';

part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final AuthDataRepository authDataRepository;

  RoomBloc(this.authDataRepository) : super(RoomInitial()) {
    on<FetchSingleRoomDetailsEvent>(_fetchSingleRoomDetails);
    on<SwitchSeatEvent>(_switchSeatResponseModel);
    on<LeaveCallEvent>(_leaveCallEvent);
    on<JoinRoomEvent>(_joinRoomEvent);
  }

  Future<void> _fetchSingleRoomDetails(FetchSingleRoomDetailsEvent event,
      Emitter<RoomState> emit,) async {
    emit(RoomLoading());

    final response = await authDataRepository.fetchSingleRoom(event.roomId);

    await response.fold(
          (error) async {
        emit(RoomError(error.toString()));
      },
          (room) async {
        final joinedCallResponse = await authDataRepository.joinedCallResponse(
          event.roomId,
          "IN_CALL",
        );

        joinedCallResponse.fold(
              (error) => emit(JoinedRoomStateError(error.toString())),
              (joinedCallResponseModel) =>
              emit(RoomLoaded(room, joinedCallResponseModel)),
        );
      },
    );
  }

  Future<void> _switchSeatResponseModel(SwitchSeatEvent event, Emitter<RoomState> emit) async{
    emit(RoomLoading());
    final switchSeatResponse = await authDataRepository.switchSeat(event.roomId, event.seatNo);
    await switchSeatResponse.fold(
            (error){
              print(error);
            },
            (seat) async{
             await _fetchSingleRoomDetails(FetchSingleRoomDetailsEvent(event.roomId), emit);
            });
  }

  Future<void> _leaveCallEvent(LeaveCallEvent event, Emitter<RoomState> emit) async{
    emit(RoomLoading());
    final leaveCallResponse = await authDataRepository.leaveCall(event.roomId);
    leaveCallResponse.fold(
            (error){
              emit(LeaveRoomError(error.toString()));
            },
            (leaveCall){
               emit(LeaveRoomSuccess(leaveCall));
            }
    );
  }

  Future<void> _joinRoomEvent(JoinRoomEvent event, Emitter<RoomState> emit) async{
    final joinRoomResponse = await authDataRepository.joinCall(event.roomId);
    joinRoomResponse.fold(
            (error){
              print(error);
            },
            (joinRoom){
              print(joinRoom);
            });
  }
}