import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';
import 'package:yoo_live/Features/domain/Model/AuthProfile.dart';
import '../../domain/Model/CreatingRoomResponse.dart';

part 'create_room_event.dart';
part 'create_room_state.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  final AuthDataRepository authDataRepository;

  CreateRoomBloc(this.authDataRepository) : super(CreateRoomInitial()) {
    on<CreateRoom>(_onCreateRoom);
  }

  FutureOr<void> _onCreateRoom(CreateRoom event, Emitter<CreateRoomState> emit) async{
    emit(CreateRoomLoading());
    final response = await authDataRepository.createRoom(event.dataForRoom);
    response.fold(
      (failure) => emit(CreateRoomFailure('$failure')),
      (data) => emit(CreateRoomSuccess(data)),
    );
  }
}
