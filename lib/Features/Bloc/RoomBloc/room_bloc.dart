import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoo_live/Constants/ApiConstants.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';
import 'package:yoo_live/Features/domain/Model/LeaveCallReponse.dart';
import 'package:yoo_live/Features/domain/Model/RoomMessageModel.dart';
import 'package:yoo_live/Features/domain/Model/SingleRoomModelResponse.dart';
import 'package:yoo_live/Features/domain/Model/SocketMessageModel.dart';
import 'package:yoo_live/Features/domain/Model/SocketUserJoinedCall.dart';
import 'package:yoo_live/Features/domain/Model/SocketUserLeaveCall.dart';
import 'package:yoo_live/Features/domain/Model/SocketUserSwitchSeat.dart';
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
  StreamSubscription? streamSubscription;

  RoomBloc(
    this.authDataRepository,
    this.agoraService,
    this.socketService,
    this.sharedPreferences,
  ) : super(RoomInitial()) {
    on<FetchSingleRoomDetailsEvent>(_fetchSingleRoomDetails);
    on<SwitchSeatEvent>(_switchSeatResponseModel);
    on<LeaveCallEvent>(_leaveCallEvent);
    on<JoinRoomEvent>(_joinRoomEvent);
    on<JoinAgoraChannelEvent>(_onJoinAgoraChannel);
    on<LeaveAgoraChannelEvent>(_onLeaveAgoraChannel);
    on<MuteLocalAudioEvent>(_onMuteLocalAudio);
    on<SendMessage>(_sendMessage);
    on<SocketUserJoinCallEvent>(_onSocketUserJoinedCall);
    on<SockerUserLeaveCallEvent>(_onSocketUserLeaveCall);
    on<SocketSeatSwitchEvent>(_socketSeatSwitchEvent);
    on<NewMessageReceived>(_onNewMessageReceived);
    on<ExistingMessageReceived>(_onExistingMessageReceived);

    streamSubscription = socketService.userJoinedCallStream.listen((user) {
      add(SocketUserJoinCallEvent(user));
    });

    streamSubscription = socketService.userLeaveCallStream.listen((user) {
      add(SockerUserLeaveCallEvent(user));
    });

    streamSubscription = socketService.userSwitchSeatStream.listen((user) {
      add(SocketSeatSwitchEvent(user));
    });

    streamSubscription = socketService.messageStream.listen((message) {
      add(NewMessageReceived(message));
    });
  }

  Future<void> _fetchSingleRoomDetails(
    FetchSingleRoomDetailsEvent event,
    Emitter<RoomState> emit,
  ) async {
    emit(RoomLoading());

    final response = await authDataRepository.fetchSingleRoom(event.roomId);
    add(ExistingMessageReceived(event.roomId));

    await response.fold(
      (error) async {
        emit(RoomError(error.toString()));
      },
      (room) async {
        final userId = sharedPreferences.getString(ApiConstants.UserServerId);
        final initialMessages = RoomMessagesModel(data: []);
        _lastLoaded = RoomLoaded(room, userId, initialMessages);
        emit(_lastLoaded!);
      },
    );
  }

  Future<void> _switchSeatResponseModel(
    SwitchSeatEvent event,
    Emitter<RoomState> emit,
  ) async {
    final switchSeatResponse = await authDataRepository.switchSeat(
      event.roomId,
      event.seatNo,
    );
    await switchSeatResponse.fold((error) {
      print(error);
    }, (seat) async {});
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
      await agoraService.joinChannel(
        event.channelName,
        event.uid,
      ); // correct user id is also passing
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

  Future<void> _sendMessage(SendMessage event, Emitter<RoomState> emit) async {
    final userId = sharedPreferences.getString(ApiConstants.UserServerId);
    print("user id ; $userId");
    socketService.sendMessage(event.roomId, event.message, userId ?? "");
  }

  void _onSocketUserJoinedCall(
    SocketUserJoinCallEvent event,
    Emitter<RoomState> emit,
  ) {
    if (state is RoomLoaded) {
      final currentState = state as RoomLoaded;
      final currentMembers =
          currentState.singleRoomResponse.data!.joinedMembers!;

      final isMemberAlreadyPresent = currentMembers.any(
        (member) => member.sId == event.socketUserJoinedCall.id,
      );
      if (isMemberAlreadyPresent) return;

      final newJoinedMember = JoinedMembers(
        sId: event.socketUserJoinedCall.id,
        userId: event.socketUserJoinedCall.userId,
        role: event.socketUserJoinedCall.role,
        seatNo: event.socketUserJoinedCall.seatNo,
        status: event.socketUserJoinedCall.status,
        name: event.socketUserJoinedCall.name,
        profileImage: event.socketUserJoinedCall.profileImage,
        callLeftAt: null,
      );
      final updatedMembers = List<JoinedMembers>.from(currentMembers)
        ..add(newJoinedMember);
      final updateData = currentState.singleRoomResponse.data!.copyWith(
        joinedMembers: updatedMembers,
        callMemberCount: updatedMembers.length,
      );
      final updatedSingleRoomResponse = currentState.singleRoomResponse
          .copyWith(data: updateData);
      emit(
        RoomLoaded(
          updatedSingleRoomResponse,
          event.socketUserJoinedCall.id,
          currentState.roomMessagesModel,
        ),
      );
    }
  }

  void _onSocketUserLeaveCall(
    SockerUserLeaveCallEvent event,
    Emitter<RoomState> emit,
  ) {
    if (state is RoomLoaded) {
      final currentState = state as RoomLoaded;
      final currentMembers =
          currentState.singleRoomResponse.data!.joinedMembers!;
      final updatedMembers =
          currentMembers
              .where((member) => member.sId != event.socketUserLeaveCall.id)
              .toList();

      final updatedData = currentState.singleRoomResponse.data!.copyWith(
        joinedMembers: updatedMembers,
        callMemberCount: updatedMembers.length,
      );
      final updatedSingleRoomResponse = currentState.singleRoomResponse
          .copyWith(data: updatedData);

      emit(
        RoomLoaded(
          updatedSingleRoomResponse,
          event.socketUserLeaveCall.id,
          currentState.roomMessagesModel,
        ),
      );
    }
  }

  void _socketSeatSwitchEvent(
    SocketSeatSwitchEvent event,
    Emitter<RoomState> emit,
  ) {
    if (state is RoomLoaded) {
      final currentState = state as RoomLoaded;
      final currentMembers =
          currentState.singleRoomResponse.data!.joinedMembers!;
      final updatedMembers =
          currentMembers.map((member) {
            if (member.userId == event.socketUserSwitchSeat.userId) {
              return member.copyWith(seatNo: event.socketUserSwitchSeat.seatNo);
            }
            return member;
          }).toList();
      if (updatedMembers.length == currentMembers.length) {
        final updatedData = currentState.singleRoomResponse.data!.copyWith(
          joinedMembers: updatedMembers,
        );
        final updatedSingleRoomResponse = currentState.singleRoomResponse
            .copyWith(data: updatedData);
        print("id from bloc : ${event.socketUserSwitchSeat.id}");
        emit(
          RoomLoaded(
            updatedSingleRoomResponse,
            event.socketUserSwitchSeat.id,
            currentState.roomMessagesModel,
          ),
        );
      }
    }
  }

  void _onNewMessageReceived(
    NewMessageReceived event,
    Emitter<RoomState> emit,
  ) {
    if (state is RoomLoaded) {
      final currentState = state as RoomLoaded;
      final currentMessages = currentState.roomMessagesModel.data ?? [];

      final socketMessageData = event.socketMessageModel;

      final isMessageAlreadyPresent = currentMessages.any(
        (message) => message.sId == socketMessageData.sId,
      );
      if (isMessageAlreadyPresent) {
        return;
      }

      final newMessage = RoomMessageData(
        sId: socketMessageData.sId,
        roomId: socketMessageData.roomId,
        content: socketMessageData.content,
        userId: socketMessageData.userId,
        email: socketMessageData.email,
        name: socketMessageData.name,
        profileImage: socketMessageData.profileImage,
        createdAt: socketMessageData.createdAt,
      );

      final updatedMessages = [newMessage, ...currentMessages];
      final updatedRoomMessagesModel = RoomMessagesModel(data: updatedMessages);
      emit(currentState.copyWith(roomMessagesModel: updatedRoomMessagesModel));
    }
  }

  FutureOr<void> _onExistingMessageReceived(
    ExistingMessageReceived event,
    Emitter<RoomState> emit,
  ) async {
    final messageResponse = await authDataRepository.fetchRoomMessages(
      event.roomId,
    );
    messageResponse.fold(
      (error) {
        print(error);
      },
      (data) {
        if (state is RoomLoaded) {
          final currentState = state as RoomLoaded;
          final roomMessagesModel = RoomMessagesModel(data: data.data);
          emit(currentState.copyWith(roomMessagesModel: roomMessagesModel));
        }
      },
    );
  }
}
