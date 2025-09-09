import 'package:flutter/material.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
                  "Share",
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
                  onTap: () {},
                  child: _buildToolItem(
                    "assets/icon/whatsapp-icon-logo-svgrepo-com 1.png",
                    "Whatsapp",
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: _buildToolItem(
                    "assets/icon/facebook-svgrepo-com 1.png",
                    "Facebook",
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: _buildToolItem(
                    "assets/icon/Simplification (10).png",
                    "Imo",
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: _buildToolItem(
                    "assets/icon/link-svgrepo-com (1) 1.png",
                    "Copy Link",
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: _buildToolItem(
                    "assets/icon/friend-3-svgrepo-com 1.png",
                    "Friend",
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: _buildToolItem(
                    "assets/icon/more-vertical-svgrepo-com 2.png",
                    "More",
                  ),
                ),
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
        Image.asset(iconPath, width: 40, height: 40, fit: BoxFit.cover),
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
