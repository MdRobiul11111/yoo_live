import 'package:flutter/material.dart';

class AudioRoomPage extends StatelessWidget {
  final List<String> users = List.generate(10, (index) => "Seat ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      body: SafeArea(
        child: Column(
          children: [
            // 🔼 Top Profile and Timer
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/profile.jpg"),
                    radius: 24,
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Addar Prohor",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "ID:121511",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 4),
                  Text("15.5k", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 12),
                  Icon(Icons.people, color: Colors.pinkAccent),
                  SizedBox(width: 4),
                  Text("Top 50+", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 12),
                  Icon(Icons.timer, color: Colors.white),
                  Text(" 1:10:05", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),

            // 👑 Owner Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/owner.jpg"),
                radius: 30,
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
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.8,
                ),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/user.png"),
                        radius: 30,
                      ),
                      SizedBox(height: 6),
                      Text(users[index], style: TextStyle(color: Colors.white)),
                      Text(
                        "15.5k",
                        style: TextStyle(color: Colors.amber, fontSize: 12),
                      ),
                    ],
                  );
                },
              ),
            ),

            // 💬 Chat Messages
            Container(
              padding: EdgeInsets.all(8),
              height: 100,
              child: ListView(
                children: [
                  Text(
                    "Mst. Tiba Akter: How are you?",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Mst. Habib Khan: How are you?",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Replied Tiba: Vlo achi",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Ratul Entered Room",
                    style: TextStyle(color: Colors.greenAccent),
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
                    icon: Icon(Icons.card_giftcard, color: Colors.yellow),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.gamepad, color: Colors.blue),
                    onPressed: () {},
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
