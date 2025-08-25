import 'package:flutter/material.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/call_request_widget/call_request_DefaultTab_button.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/room_tools_widget/tools_page.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/user_room_profile_card.dart';

class AudioRoomPage extends StatelessWidget {
  final List<String> users = List.generate(16, (index) => "Seat ${index + 1}");

  AudioRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 15),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/image/image 258120.png",
                            ),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(),
                              Text(
                                "Addar Prohor",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "ID:121511",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.equalizer, color: Colors.white),
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
                            "33+",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                ],
              ),
            ),
            // 👑 Owner Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
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

            // 🎤 Grid of Seats
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // UserRoomProfileCard_button
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(child: UserRoomProfileCard());
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/image/image 258120.png",
                          ),
                          radius: 25,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(users[index], style: TextStyle(color: Colors.white)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 13,
                            width: 13,
                            child: Image(
                              image: AssetImage("assets/icon/diamond 1.png"),
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "15.5k",
                            style: TextStyle(color: Colors.amber, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            // 💬 Chat Messages
            Container(
              padding: EdgeInsets.all(8),
              height: 120,
              child: ListView(
                children: [
                  Padding(
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
                                color: Color(0xffAA7E59),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    "9",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 12),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(),
                              height: 23,
                              width: 23,
                              child: Image(
                                image: AssetImage(
                                  "assets/icon/Frame 2147228166.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Mst. Tiba Akter: How are you?",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  Padding(
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
                                color: Color(0xffAA7E59),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    "9",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 12),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(),
                              height: 23,
                              width: 23,
                              child: Image(
                                image: AssetImage(
                                  "assets/icon/Frame 2147228166.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Mst. Habib Khan: How are you?",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Replied Tiba: Vlo achi",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      children: [
                        Container(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Text(
                              "Ratul Entered Room",
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                          ),
                        ),
                        Spacer(),
                        // Call_Request Defaulttab Button
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3D1E4F),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: CallRequestDefaulttabButton(),
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 🧰 Bottom Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                        decoration: InputDecoration(
                          hintText: "Say hi...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.mic, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.white),
                    onPressed: () {},
                  ),

                  IconButton(
                    icon: Icon(Icons.card_giftcard, color: Colors.yellow),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.gas_meter, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.gamepad, color: Colors.blue),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(child: ToolsPage());
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
    );
  }
}
