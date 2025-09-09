import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoo_live/Features/Bloc/RoomBloc/room_bloc.dart';
import 'package:yoo_live/Features/domain/Model/SingleRoomModelResponse.dart';
import 'package:yoo_live/Features/domain/Model/SocketMessageModel.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/call_request_widget/call_request_DefaultTab_button.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/room_tools_widget/tools_page.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/user_room_profile_card.dart';
import 'package:yoo_live/widget/presentation/root/root_page.dart';

import '../../../Constants/ApiConstants.dart';

class AudioRoomPage extends StatefulWidget {
  final String roomId;

  const AudioRoomPage({super.key, required this.roomId});

  @override
  State<AudioRoomPage> createState() => _AudioRoomPageState();
}

class _AudioRoomPageState extends State<AudioRoomPage>
    with WidgetsBindingObserver {
  final List<String> users = List.generate(16, (index) => "Seat ${index + 1}");
  int memberLength = 0;
  TextEditingController messageController = TextEditingController();
  bool localAudioMute = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<RoomBloc>().add(JoinRoomEvent(widget.roomId));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      context.read<RoomBloc>().add(LeaveCallEvent(widget.roomId));
    }
  }

  Future<bool> _showExitDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
        backgroundColor: Color(0xff352C2E),
        title: Text('Leave Room?', style: TextStyle(color: Colors.white)),
        content: Text(
          'Are you sure you want to leave this audio room?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Leave', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final shouldPop = await _showExitDialog();
          if (shouldPop && context.mounted) {
            context.read<RoomBloc>().add(LeaveCallEvent(widget.roomId));
          }
        }
      },
      child: BlocListener<RoomBloc, RoomState>(
        listener: (context, state) {
          if (state is LeaveRoomSuccess) {
            print("Leave room success - navigating back to RootPage");
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => RootPage()),
            );
          } else if (state is LeaveRoomError) {
            print("Leave room error: ${state.errorMessage}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error leaving room: ${state.errorMessage}"),
              ),
            );
          } else if (state is RoomLoaded) {
            if (mounted) {
              setState(() {
                memberLength =
                    state.singleRoomResponse.data?.joinedMembers?.length ?? 0;
              });
              print("Member length updated in BlocListener: $memberLength");
            }
          }
        },
        child: Scaffold(
          backgroundColor: Color(0xff1E1113),
          body: SafeArea(
            child: Column(
              children: [
                // 🔼 Top Profile and follow
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff352C2E),
                        ),
                        child: BlocBuilder<RoomBloc, RoomState>(
                          builder: (context, state) {
                            if (state is RoomLoading) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 15,
                                ),
                                child: Row(
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Text(
                                          "Loading...",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              ".....",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.equalizer,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    // follow button
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Color(0xffC358C6),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (state is RoomLoaded) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 15,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        state
                                            .singleRoomResponse
                                            .data
                                            ?.profile ??
                                            "",
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Text(
                                          state
                                              .singleRoomResponse
                                              .data
                                              ?.title ??
                                              "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              (state
                                                  .singleRoomResponse
                                                  .data
                                                  ?.sId ??
                                                  "")
                                                  .truncateTo(10),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.equalizer,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    // follow button
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Color(0xffC358C6),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 15,
                              ),
                              child: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Spacer(),
                                      Text(
                                        "Loading...",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            ".....",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.equalizer,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  // follow button
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Color(0xffC358C6),
                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      Spacer(),
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/image/image 258120.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              // fream
                              SizedBox(
                                height: 45,
                                width: 45,
                                child: Image(
                                  image: AssetImage("assets/icon/frem1.png"),
                                ),
                              ),
                            ],
                          ),

                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/image/image 258120.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ), // fream
                              SizedBox(
                                height: 45,
                                width: 45,
                                child: Image(
                                  image: AssetImage("assets/icon/frem1.png"),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 25,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey,
                            ),
                            child: Center(
                              child: Text(
                                "$memberLength+",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //diamond
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 32,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffA46C2F),
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                Text(
                                  "15.5k",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 12),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xffFE9833),
                            child: SizedBox(
                              height: 27,
                              width: 27,
                              child: Image(
                                image: AssetImage("assets/icon/diamond 1.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 8),
                      Stack(
                        children: [
                          Container(
                            height: 32,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffB460D2),
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                Text(
                                  "15.5k",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 12),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 3.5,
                              horizontal: 6,
                            ),
                            height: 25,
                            width: 25,
                            child: Image(
                              image: AssetImage("assets/icon/coin 1.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),

                      //leave call
                      BlocListener<RoomBloc, RoomState>(
                        listener: (context, state) {
                          if (state is LeaveRoomError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)),
                            );
                          } else if (state is LeaveRoomSuccess) {
                            Navigator.pop(context);
                          }
                        },
                        child: InkWell(
                          onTap: () {
                            context.read<RoomBloc>().add(
                              LeaveCallEvent(widget.roomId),
                            );
                          },
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 👑 Owner Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 11,
                          horizontal: 10,
                        ),
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/image/image 258120.png"),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ), // fream
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: Image(
                          image: AssetImage("assets/icon/frem1.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Owner",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //🎤 Grid of Seats
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(color: Colors.transparent),
                  width: double.infinity,
                  child: BlocBuilder<RoomBloc, RoomState>(
                    builder: (context, state) {
                      if (state is RoomLoading || state is JoiningRoomLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is RoomLoaded) {
                        final totalSeats = state.singleRoomResponse.data?.seat ?? 0;

                        final seatMap = {
                          for (var user in state.singleRoomResponse.data?.joinedMembers ?? <JoinedMembers>[])
                            user.seatNo: user,
                        };
                        return StreamBuilder<Map<int, int>>(
                          stream: ApiConstants.volumeStream,
                          builder: (context, volumeSnapshot) {
                            final volumeMapData = volumeSnapshot.data ?? <int, int>{};
                            return GridView.builder(
                              padding: EdgeInsets.all(16),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 3,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.85,
                              ),
                              itemCount: totalSeats,
                              itemBuilder: (context, index) {
                                final seatNumber = index + 1;
                                final user = seatMap[seatNumber];
                                bool isCurrentUserTalking = false;

                                if (user?.userId != null && user!.userId is int) {
                                  final agoraUserid = user.userId as int;
                                  const int talkingThreshold = 5;
                                  final currentVolume = volumeMapData[agoraUserid] ?? 0;
                                  isCurrentUserTalking = currentVolume > talkingThreshold;
                                }

                                if (user != null) {
                                  // Seat occupied by a user
                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            flex: 7,
                                            child: InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (
                                                      _,
                                                      ) => UserRoomProfileCard(
                                                    uid: "${user.userId}",
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color:
                                                    isCurrentUserTalking
                                                        ? Colors.greenAccent
                                                        : Colors
                                                        .transparent,
                                                    width: 3,
                                                  ),
                                                  // Add a subtle glow effect when talking
                                                  boxShadow:
                                                  isCurrentUserTalking
                                                      ? [
                                                    BoxShadow(
                                                      color: Colors
                                                          .greenAccent
                                                          .withOpacity(
                                                        0.5,
                                                      ),
                                                      blurRadius: 8,
                                                      spreadRadius: 2,
                                                    ),
                                                  ]
                                                      : null,
                                                ),
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    user.profileImage ?? "",
                                                  ),
                                                  radius: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    user.name ?? "",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                        width: 10,
                                                        child: Image.asset(
                                                          "assets/icon/diamond 1.png",
                                                        ),
                                                      ),
                                                      SizedBox(width: 1),
                                                      Text(
                                                        "15.5k",
                                                        style: TextStyle(
                                                          color: Colors.amber,
                                                          fontSize: 9,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  // Empty seat - make it more subtle and consistent
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context.read<RoomBloc>().add(
                                            SwitchSeatEvent(
                                              widget.roomId,
                                              seatNumber,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.transparent,
                                            border: Border.all(
                                              color: Colors.grey.withOpacity(
                                                0.3,
                                              ),
                                              width: 2,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.grey.withOpacity(0.6),
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Seat $seatNumber",
                                        style: TextStyle(
                                          color: Colors.grey.withOpacity(0.7),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            );
                          },
                        );
                      }
                      if (state is RoomError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: Colors.red, size: 48),
                              SizedBox(height: 8),
                              Text(
                                "Failed to load room",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                state.errorMessage,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                      // Default state - show loading or empty state
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text(
                              "Loading room...",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 30),
                // 💬 Chat Messages sections
                Container(
                  padding: const EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height * 0.15,
                  alignment: Alignment.bottomCenter,
                  child: StreamBuilder<List<SocketMessageModel>>(
                    stream: ApiConstants.messages,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final messages = snapshot.data!; // The data is a list of messages
                        return ListView.builder(
                          itemCount: messages.length,
                          // Use the length of the list
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            return ListItemWidget(
                              name: message.name ?? "",
                              message: message.content ?? "",
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('An error occurred!'));
                      } else {
                        return const Center(
                          child: Text(
                            'No messages yet.',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                    },
                  ),
                ),

                // 🧰 Bottom Bar sections
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: "Say hi...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send, size: 32, color: Colors.white),
                        onPressed: () {
                          final message = messageController.text;
                          context.read<RoomBloc>().add(
                            SendMessage(widget.roomId, message),
                          );
                        },
                      ),
                      //mic
                      IconButton(
                        icon: Icon(localAudioMute ? Icons.mic_off : Icons.mic, size: 32, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            localAudioMute = !localAudioMute;
                            context.read<RoomBloc>().add(
                              MuteLocalAudioEvent(localAudioMute),
                            );
                          });
                        },
                      ),

                      // InkWell(
                      //   onTap: () {},
                      //   child: Container(
                      //     height: 25,
                      //     width: 25,
                      //     child: Image(
                      //       image: AssetImage("assets/icon/Vector.png"),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 32,
                          width: 32,
                          child: Image(
                            image: AssetImage(
                              "assets/icon/Simplification (8).png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 17),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 32,
                          width: 32,
                          child: Image(
                            image: AssetImage(
                              "assets/icon/Simplification (9).png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      IconButton(
                        icon: Icon(Icons.gamepad, size: 32, color: Colors.blue),
                        onPressed: () {
                          // ToolsPage
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ToolsPage();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension StringTruncateExtension on String {
  String truncateTo(int maxLength, {String ellipsis = ""}) {
    // Added optional ellipsis
    if (length > maxLength) {
      return substring(0, maxLength) + ellipsis;
    } else {
      return this;
    }
  }
}

class ListItemWidget extends StatelessWidget {
  final String name;
  final String message;

  const ListItemWidget({Key? key, required this.name, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: 20,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xffAA7E59),
                ),
                child: const Row(
                  children: [
                    Spacer(),
                    Text(
                      "9", // This value is still hardcoded
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(),
                height: 23,
                width: 23,
                child: const Image(
                  image: AssetImage("assets/icon/Frame 2147228166.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(width: 5),
          Text("$name: $message", style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
