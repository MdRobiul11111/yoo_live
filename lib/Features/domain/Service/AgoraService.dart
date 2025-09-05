import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:yoo_live/Constants/ApiConstants.dart';

class AgoraService {
  late RtcEngine _engine;
  final _volumeController = StreamController<Map<int, int>>.broadcast();
  Stream<Map<int,int>> get volumeStream => _volumeController.stream;

  Future<void> initialize() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      RtcEngineContext(
        appId: ApiConstants.AgoraAppId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    // Enable audio volume indication
    await _engine.enableAudioVolumeIndication(
      interval: 200, // 200ms interval
      smooth: 3,
      reportVad: true,
    );


    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) async {
          print("Joined channel: ${connection.channelId}");
          await _engine.setEnableSpeakerphone(true);

        },
        onUserJoined: (connection, remoteUid, elapsed) {
          print("User joined: $remoteUid");
        },
        onUserOffline: (connection, remoteUid, reason) {
          print("User offline: $remoteUid");
        },
        onAudioVolumeIndication:
            (RtcConnection connection, List<AudioVolumeInfo> speakers, int speakerNumber, int totalVolume) {
          print("Audio volume indication - Total: $totalVolume, Speakers: ${speakers.length}, SpeakerNumber: $speakerNumber");
          // build a map uid -> volume for easy consumption
          final map = <int,int>{};
          for (final s in speakers) {
            final uid = s.uid ?? 0;
            final volume = s.volume ?? 0;
            map[uid] = volume;
            print("Speaker - UID: $uid, Volume: $volume, VolumeType: ${s.vad}");
          }
          
          // Only add totalVolume if local user (uid 0) is actually in the speakers list
          // Don't artificially add volume for local user when they're not speaking
          
          print("Volume map being sent: $map");
          _volumeController.add(map);
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          print("Left channel: ${connection.channelId}");
        },
      ),
    );
  }

  Future<void> joinChannel(String channelName, int uid) async {
    await _engine.joinChannel(
      token: '',
      channelId: channelName,
      uid: uid,
      options: const ChannelMediaOptions(
        autoSubscribeAudio: true,
        publishMicrophoneTrack: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> muteLocalAudio(bool mute) async {
    await _engine.muteLocalAudioStream(mute);
  }

  void dispose() {
    _engine.release();
  }
}
