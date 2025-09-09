import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoo_live/Features/Bloc/CreatedLiveRoomsBloC/created_live_room_bloc.dart';
import 'package:yoo_live/widget/presentation/home/search_page/search_page.dart';
import 'package:yoo_live/widget/presentation/notification_widget/notification_page.dart';

import '../audio_live_host_view_widget/audio_room_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void fetchLiveRooms() {
    context.read<CreatedLiveRoomBloc>().add(FetchCreatedLiveRooms());
  }

  Future<void> _onRefresh() async {
    context.read<CreatedLiveRoomBloc>().add(FetchCreatedLiveRooms());
    // Wait for the bloc to complete the fetch operation
    await Future.delayed(Duration(milliseconds: 500));
  }

  void navigateToRoom(String roomId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AudioRoomPage(roomId: roomId)),
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              "Dark Live",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              child: Icon(Icons.notifications, color: Colors.white),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
      ),

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
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: Colors.white,
                      backgroundColor: Colors.pink,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              CarouselSlider.builder(
                                itemCount: state.sliderResponse.data?.length,
                                itemBuilder: (context, index, realIndex) {
                                  final rooms =
                                      state.sliderResponse.data?[index];
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          rooms?.imageUrl ?? "",
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                      Positioned(
                                        left: 12,
                                        bottom: 12,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.5,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 8),
                                              if (rooms?.status == "ACTIVE")
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  child: const Text(
                                                    "Live",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 12,
                                        top: 12,
                                        child: Text(
                                          rooms?.title ?? "",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black,
                                                offset: Offset(1, 1),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                options: CarouselOptions(
                                  height: 180,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  viewportFraction: 0.8,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Dots Indicator
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    state.sliderResponse.data!
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                          return Container(
                                            width:
                                                _currentIndex == entry.key
                                                    ? 10.0
                                                    : 6.0,
                                            height: 6.0,
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 3.0,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color:
                                                  _currentIndex == entry.key
                                                      ? Colors.pink
                                                      : Colors.grey,
                                            ),
                                          );
                                        })
                                        .toList(),
                              ),
                              SizedBox(height: 16),

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
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
