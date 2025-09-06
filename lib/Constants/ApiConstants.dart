import 'dart:async';

class ApiConstants{
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String issuedAtKey = 'issues_at';
  static const String AgoraAppId = 'e09469f8dc484677ba2d6279e8db56f5';
  static final StreamController<Map<int, int>> volumeController = StreamController<Map<int, int>>.broadcast();
  static Stream<Map<int, int>> get volumeStream => volumeController.stream;
  static final Map<int, int> _currentVolumes = <int, int>{};
  static void updateUserVolume(int uid, int volume) {
    _currentVolumes[uid] = volume;
    volumeController.add(Map.from(_currentVolumes));
  }


}