import 'dart:async';

import '../Features/domain/Model/SocketMessageModel.dart';

class ApiConstants{
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String issuedAtKey = 'issues_at';
  static const String AgoraAppId = 'e09469f8dc484677ba2d6279e8db56f5';
  static const String UserServerId = 'user_server_id';
  static final StreamController<Map<int, int>> volumeController = StreamController<Map<int, int>>.broadcast();
  static Stream<Map<int, int>> get volumeStream => volumeController.stream;

  static final Map<int, int> _currentVolumes = <int, int>{};

  static void updateUserVolume(int uid, int volume) {
    _currentVolumes[uid] = volume;
    volumeController.add(Map.from(_currentVolumes));
  }
  static final List<SocketMessageModel> _currentMessages = [];
  static final StreamController<List<SocketMessageModel>> _messageController = StreamController<List<SocketMessageModel>>.broadcast();
  static Stream<List<SocketMessageModel>> get messages => _messageController.stream;

  static void addNewMessage(SocketMessageModel message) {
    _currentMessages.add(message);
    _messageController.add(List.of(_currentMessages));
  }

}