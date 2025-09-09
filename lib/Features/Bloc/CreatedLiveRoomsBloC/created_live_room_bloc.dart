import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoo_live/Constants/ApiConstants.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';
import 'package:yoo_live/Features/domain/Model/CreatedLiveRoomReponse.dart';
import 'package:yoo_live/Features/domain/Model/SliderResponse.dart';
import 'package:yoo_live/Features/domain/Service/SocketService.dart';

part 'created_live_room_event.dart';
part 'created_live_room_state.dart';

class CreatedLiveRoomBloc
    extends Bloc<CreatedLiveRoomEvent, CreatedLiveRoomState> {
  final AuthDataRepository authDataRepository;
  final SocketService socketService;
  final SharedPreferences sharedPreferences;

  CreatedLiveRoomBloc(
    this.authDataRepository,
    this.socketService,
    this.sharedPreferences,
  ) : super(CreatedLiveRoomInitial()) {
    on<CreatedLiveRoomEvent>(_createdLiveRoomEvent);
    on<ConnectSocketEvent>(_onConnectSocket);
    on<SetupSocket>(_onSetupSocket);
    on<JoinSocketRoomEvent>(_onJoinRoomEvent);
  }

  FutureOr<void> _createdLiveRoomEvent(
    CreatedLiveRoomEvent event,
    Emitter<CreatedLiveRoomState> emit,
  ) async {
    emit(CreatedLiveRoomLoading());

    final eitherSliderResponse = await authDataRepository.fetchSlider();
    await eitherSliderResponse.fold<Future<void>>(
      (error) async {
        emit(CreatedLiveRoomError(message: error.toString()));
      },
      (slider) async {
        final eitherCreatedLiveRoomResponse =
            await authDataRepository.fetchListOfRooms();

        eitherCreatedLiveRoomResponse.fold(
          (roomError) {
            emit(CreatedLiveRoomError(message: roomError.toString()));
          },
          (liveRooms) {
            emit(
              CreatedLiveRoomLoaded(rooms: liveRooms, sliderResponse: slider),
            );
          },
        );
      },
    );
  }

  Future<void> _onConnectSocket(
    ConnectSocketEvent event,
    Emitter<CreatedLiveRoomState> emit,
  ) async {
    try {
      await socketService.connect();
      add(SetupSocket());
    } catch (e) {
      emit(CreatedLiveRoomError(message: "Failed to connect socket: $e"));
    }
  }

  Future<void> _onSetupSocket(
    SetupSocket event,
    Emitter<CreatedLiveRoomState> emit,
  ) async {
    final userId = sharedPreferences.getString(ApiConstants.UserServerId);
    print("userId from setup socket $userId");
    try {
      socketService.setup(userId!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _onJoinRoomEvent(
    JoinSocketRoomEvent event,
    Emitter<CreatedLiveRoomState> emit,
  ) async {
    try {
      socketService.joinRoomEvent(event.roomID);
    } catch (e) {
      print(e.toString());
    }
  }
}
