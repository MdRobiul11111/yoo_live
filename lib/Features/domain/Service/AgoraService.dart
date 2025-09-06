import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:yoo_live/Constants/ApiConstants.dart';

class AgoraService {
  late RtcEngine _engine;
  int? localUserId;

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
      interval: 250, // 200ms interval
      smooth: 3,
      reportVad: true,
    );


    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) async {
          await _engine.setEnableSpeakerphone(true);
          localUserId = connection.localUid??0;
          collectLocalId(connection.localUid??0);
        },
        onUserJoined: (connection, remoteUid, elapsed) {
        },
        onUserOffline: (connection, remoteUid, reason) {

        },
        onAudioVolumeIndication: (RtcConnection connection, List<AudioVolumeInfo> speakers, int speakerNumber, int totalVolume) {
          for (final s in speakers) {
            if (s.uid == 0 && localUserId != null && s.volume != null) {
              ApiConstants.updateUserVolume(localUserId!, s.volume!);
            } else if (s.uid != null && s.uid != 0 && s.volume != null) {
              ApiConstants.updateUserVolume(s.uid!, s.volume!);
            }
          }
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {print("Left channel: ${connection.channelId}");
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

  int collectLocalId(int id){
    return id;
  }
}
