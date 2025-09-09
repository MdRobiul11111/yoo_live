import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';
import 'package:yoo_live/Features/domain/Model/CreatedLiveRoomReponse.dart';
import 'package:yoo_live/Features/domain/Model/SliderResponse.dart';

part 'created_live_room_event.dart';
part 'created_live_room_state.dart';

class CreatedLiveRoomBloc
    extends Bloc<CreatedLiveRoomEvent, CreatedLiveRoomState> {
  final AuthDataRepository authDataRepository;

  CreatedLiveRoomBloc(this.authDataRepository)
    : super(CreatedLiveRoomInitial()) {
    on<CreatedLiveRoomEvent>(_createdLiveRoomEvent);
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
}
