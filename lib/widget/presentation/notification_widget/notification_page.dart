import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Banner Section
          Container(
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.pink, Colors.purple]),
            ),
            child: Text(
              "Make a statement.",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),

          // Notification List
          Expanded(
            child: ListView(
              children: [
                _notificationTile(
                  title: "Md Masud Ali was live now",
                  showDot: true,
                ),
                _notificationTile(title: "Md Nasim just follow back you"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationTile({required String title, bool showDot = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          if (showDot) const Icon(Icons.circle, color: Colors.red, size: 10),
        ],
      ),
    );
  }
}
