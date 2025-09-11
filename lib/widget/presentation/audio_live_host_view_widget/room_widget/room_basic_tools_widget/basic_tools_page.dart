import 'package:flutter/material.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/room_basic_tools_widget/music_widget/play_music_screen.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3D263B), Color(0xFF724D70)],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Basic Tools",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Grid items
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(child: PlayMusicScreen());
                      },
                    );
                  },
                  child: _buildToolItem(
                    "assets/icon/Simplification (15).png",
                    "Music",
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: _buildToolItem(
                    "assets/icon/Simplification (11).png",
                    "Share",
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: _buildToolItem(
                    "assets/icon/Simplification (12).png",
                    "Emoji",
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: _buildToolItem(
                    "assets/icon/Simplification (16).png",
                    "Seat Mode",
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolItem(String iconPath, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(iconPath, width: 30, height: 30, fit: BoxFit.cover),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
