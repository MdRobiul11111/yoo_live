import 'package:flutter/material.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage({super.key});

  Widget _buildFollowerItem(String name, int level) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Level badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.brown[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.shield, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  "$level",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Name + Badge
          const Icon(Icons.emoji_events, color: Colors.greenAccent, size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          // ❌ Remove Button
          GestureDetector(
            onTap: () {
              // TODO: remove follower logic
            },
            child: const Icon(Icons.close, color: Colors.white70),
          ),
          const SizedBox(width: 12),

          // ➕ Gradient Button
          GestureDetector(
            onTap: () {
              // TODO: add follower logic
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFD57C81), Color(0xFFC254D0)],
                ),
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.add, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final followers = [
      {"name": "Seam Rahman", "level": 9},
      {"name": "Seam Rahman", "level": 9},
      {"name": "Seam Rahman", "level": 9},
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Followers",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (ctx, i) {
          return _buildFollowerItem(
            followers[i]["name"] as String,
            followers[i]["level"] as int,
          );
        },
      ),
    );
  }
}
