import 'package:flutter/material.dart';

class InboxPage extends StatefulWidget {
  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final List<Map<String, String>> chats = [
    {
      "name": "Md Zubayar",
      "message": "How are you",
      "image": "assets/image/image 258120.png",
    },
    {
      "name": "Md Zubayar",
      "message": "How are you",
      "image": "assets/image/image 258120.png",
    },
    {
      "name": "Md Zubayar",
      "message": "How are you",
      "image": "assets/image/image 258120.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        title: Text(
          "Inbox",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        itemCount: chats.length,
        separatorBuilder: (_, __) => Divider(color: Colors.white24),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(chat["image"]!),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat["name"]!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      chat["message"]!,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "1",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
