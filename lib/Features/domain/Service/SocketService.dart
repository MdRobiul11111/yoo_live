import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:yoo_live/Constants/ApiConstants.dart';
import 'package:yoo_live/Features/domain/Model/SocketMessageModel.dart';
import 'package:yoo_live/Features/domain/Model/SocketUserJoinedCall.dart';

import '../Model/SocketUserLeaveCall.dart';
import '../Model/SocketUserSwitchSeat.dart';

enum SocketConnectionStatus {
  disconnected,
  connecting,
  connected,
  error,
}

class SocketService {
  static const String _baseUrl = 'https://yoo-live.onrender.com';
  
  IO.Socket? _socket;
  SocketConnectionStatus _connectionStatus = SocketConnectionStatus.disconnected;
  
  SocketConnectionStatus get connectionStatus => _connectionStatus;
  bool get isConnected => _connectionStatus == SocketConnectionStatus.connected;

  //SocketUserJoinCall
  final StreamController<SocketUserJoinedCall> _userJoinedCallController = StreamController<SocketUserJoinedCall>.broadcast();
  Stream<SocketUserJoinedCall> get userJoinedCallStream => _userJoinedCallController.stream;

  //SocketUserLeaveCall
  final StreamController<SocketUserLeaveCall> _userLeaveCallController = StreamController<SocketUserLeaveCall>.broadcast();
  Stream<SocketUserLeaveCall> get userLeaveCallStream => _userLeaveCallController.stream;

  //socketUserSwitchSeat
  final StreamController<SocketUserSwitchSeat> _userSwitchSeatController = StreamController<SocketUserSwitchSeat>.broadcast();
  Stream<SocketUserSwitchSeat> get userSwitchSeatStream => _userSwitchSeatController.stream;


  Future<void> connect() async {
    if (_socket != null && _socket!.connected) {
      print('Socket already connected');
      return;
    }

    try {
      _updateConnectionStatus(SocketConnectionStatus.connecting);
      
      _socket = IO.io(_baseUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      _setupEventHandlers();
      _socket!.connect();
      
    } catch (e) {
      print('Socket connection error: $e');
      _updateConnectionStatus(SocketConnectionStatus.error);
    }
  }

  void _setupEventHandlers() {
    if (_socket == null) return;

    // Connection event handlers only
    _socket!.onConnect((_) {
      print('Socket connected successfully');
      _updateConnectionStatus(SocketConnectionStatus.connected);
    });

    _socket!.onDisconnect((_) {
      print('Socket disconnected');
      _updateConnectionStatus(SocketConnectionStatus.disconnected);
    });

    _socket!.onConnectError((error) {
      print('Socket connection error: $error');
      _updateConnectionStatus(SocketConnectionStatus.error);
    });

    _socket!.onError((error) {
      print('Socket error: $error');
      _updateConnectionStatus(SocketConnectionStatus.error);
    });

    _socket!.on('joined-call', (data) {
      print('joined-call event received: $data');
      final joinedCall = SocketUserJoinedCall.fromJson(data);
      _userJoinedCallController.add(joinedCall);
    });

    _socket!.on('left-call', (data){
      print('left-call event received: $data');
      final leftCall = SocketUserLeaveCall.fromJson(data);
      _userLeaveCallController.add(leftCall);
    });

    _socket!.on('new-room-message', (data) {
       print('new-room-message event received: $data');
       final message = SocketMessageModel.fromJson(data);
       ApiConstants.addNewMessage(message);
    });
    
    _socket!.on("room-message-sent", (data){
      print(data);
    });

    _socket!.on("seat-switched", (data){
      print("switch seat event:  $data");
      final seatSwitched = SocketUserSwitchSeat.fromJson(data);
      _userSwitchSeatController.add(seatSwitched);
    });

  }

  void _updateConnectionStatus(SocketConnectionStatus status) {
    _connectionStatus = status;
  }

  void setup(String userId){
    _socket!.emit('setup',userId);
  }

  void sendMessage(String roomId,String content, String userId){
    final Map<String, dynamic> messagePayload = {
      'roomId': roomId,
      'content': content,
      'userId': userId,
    };
    _socket!.emit('send-room-message', messagePayload);
  }

  void joinRoomEvent(String roomId){
    _socket!.emit('join-room', roomId);
  }


  Future<void> disconnect() async {
    if (_socket != null) {
      _socket!.disconnect();
      _socket!.dispose();
      _socket = null;
    }
    _updateConnectionStatus(SocketConnectionStatus.disconnected);
    print('Socket disconnected and disposed');
  }

  void dispose() {
    disconnect();
  }
}