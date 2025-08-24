import 'package:flutter/material.dart';

class CallRequestsScreen extends StatelessWidget {
  const CallRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3E2350), // purple background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Call Request List
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _callRequestTile("Seam Rahman", "9");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _callRequestTile(String name, String level) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Left badges
          Row(
            children: [
              Container(
                height: 30,
                width: 30,

                decoration: BoxDecoration(
                  color: Color(0xff242835),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("1", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 6),
              Stack(
                children: [
                  Container(
                    height: 22,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffAA7E59),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          level,
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
                      image: AssetImage("assets/icon/Frame 2147228166.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 6),
              Icon(Icons.military_tech, color: Colors.greenAccent, size: 20),
            ],
          ),

          const SizedBox(width: 12),

          // Name
          Expanded(
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          // Right Action (Call decline)
          Icon(Icons.phone_callback, color: Colors.white, size: 24),
        ],
      ),
    );
  }
}
