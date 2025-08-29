import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';
import 'package:yoo_live/Features/domain/Model/SingleRoomModelResponse.dart';

import '../../../widget/presentation/audio_live_host_view_widget/audio_room_page.dart';

part 'room_event.dart';

part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final AuthDataRepository authDataRepository;

  RoomBloc(this.authDataRepository) : super(RoomInitial()) {
    on<FetchSingleRoomDetailsEvent>(_fetchSingleRoomDetails);
  }

  FutureOr<void> _fetchSingleRoomDetails(
    FetchSingleRoomDetailsEvent event,
    Emitter<RoomState> emit,
  ) async {
    emit(RoomLoading());
    final response = await authDataRepository.fetchSingleRoom(event.roomId);
    response.fold(
            (error) => emit(RoomError(error.toString())),
            (room) => emit(RoomLoaded(room))
    );
  }
}
