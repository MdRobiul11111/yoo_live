import 'package:flutter/material.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/report_page.dart';

class UserRoomProfileCard extends StatelessWidget {
  const UserRoomProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF694667), Color(0xFF452B42)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Manage Button
          Row(
            children: [
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(child: ReportPage());
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff4C354B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Manage",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ), //Profile
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                  "https://via.placeholder.com/150", // Replace with real image
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Name + ID
          const Text(
            "Janvi Kapoor",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Color(0xffA444B5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Text(
                    "ID",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 7),
              const Text(
                "ID: 575332",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Badges
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              _buildBadge("assets/icon/ri_police-badge-fill.png", "AGENCY"),
              _buildBadge("assets/icon/exclusive 1.png", "LV 5"),
              _buildBadge("assets/icon/logos_hosted-graphite.png", "HOST"),
              _buildBadge("assets/icon/icon-park_sales-report.png", "RESELLER"),
            ],
          ),
          const SizedBox(height: 20),

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatItem(title: "8M", subtitle: "Followers"),
              _StatItem(title: "2.3k", subtitle: "Friend"),
              _StatItem(title: "15", subtitle: "Following"),
            ],
          ),
          const SizedBox(height: 30),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _actionButton(Icons.person_add, "Follow", Colors.black),
              _actionButton(Icons.message, "Message", Colors.pinkAccent),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildBadge(String imagePath, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xff5C1904),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 19,
            child: Image(image: AssetImage(imagePath), fit: BoxFit.cover),
          ),
          SizedBox(width: 5),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  static Widget _actionButton(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const _StatItem({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
