import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoo_live/Features/Bloc/CreatedLiveRoomsBloC/created_live_room_bloc.dart';
import 'package:yoo_live/Features/Bloc/RoomBloc/room_bloc.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/audio_room_page.dart';

class AllRoomScreen extends StatefulWidget {
  @override
  State<AllRoomScreen> createState() => _AllRoomScreenState();
}

class _AllRoomScreenState extends State<AllRoomScreen> {
  void fetchLiveRooms() {
    context.read<CreatedLiveRoomBloc>().add(FetchCreatedLiveRooms());
  }

  void navigateToRoom(String roomId) {
    context.read<RoomBloc>().add(FetchSingleRoomDetailsEvent(roomId));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AudioRoomPage(roomId: roomId,)),
    );
  }

  @override
  void initState() {
    fetchLiveRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: BlocBuilder<CreatedLiveRoomBloc, CreatedLiveRoomState>(
        builder: (context, state) {
          if (state is CreatedLiveRoomLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CreatedLiveRoomLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  // Grid of Live Users
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            GridView.builder(
                              itemCount: state.rooms.data?.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.8,
                                  ),
                              itemBuilder: (context, index) {
                                final rooms = state.rooms.data![index];
                                return InkWell(
                                  onTap: () {
                                    navigateToRoom(rooms.sId!);
                                  },
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          rooms.profile ?? "",
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      //I want to set a flag here is room isActive this container will show up otherwise not
                                      if (rooms.isActive ?? false)
                                        Positioned(
                                          left: 8,
                                          top: 8,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(
                                                0.8,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.wifi_tethering,
                                                  size: 14,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Live",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                      Positioned(
                                        right: 8,
                                        top: 8,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.6,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${rooms.callMemberCount ?? 0}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 8,
                                        bottom: 8,
                                        child: Text(
                                          rooms.title ?? "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 2,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CreatedLiveRoomError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
