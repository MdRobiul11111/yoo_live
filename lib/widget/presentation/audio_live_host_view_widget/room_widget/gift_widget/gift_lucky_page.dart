import 'package:flutter/material.dart';

class GiftLuckyPage extends StatefulWidget {
  const GiftLuckyPage({super.key});

  @override
  State<GiftLuckyPage> createState() => _GiftLuckyPageState();
}

class _GiftLuckyPageState extends State<GiftLuckyPage> {
  final List<Map<String, dynamic>> gifts = [
    {
      "image": "assets/icon/Frame 2147228166.png",
      "name": "Love letter",
      "price": "10,000",
    },
    {
      "image": "assets/icon/Frame 2147228166.png",
      "name": "Cool drink",
      "price": "10,000",
    },
    {
      "image": "assets/icon/Frame 2147228166.png",
      "name": "Cosmic tea",
      "price": "10,000",
    },
    {
      "image": "assets/icon/Frame 2147228166.png",
      "name": "Microphone",
      "price": "10,000",
    },
    {
      "image": "assets/icon/Frame 2147228166.png",
      "name": "Kiss",
      "price": "10,000",
    },
    {
      "image": "assets/icon/Frame 2147228166.png",
      "name": "Ice cream",
      "price": "10,000",
    },
    {
      "image": "assets/icon/Frame 2147228166.png",
      "name": "Like",
      "price": "10,000",
    },
    {
      "image": "assets/icon/Frame 2147228166.png",
      "name": "Red Rose",
      "price": "10,000",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: gifts.length,
      itemBuilder: (context, i) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white.withOpacity(0.1),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.asset(
                  gifts[i]["image"],
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                  errorBuilder:
                      (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              gifts[i]["name"],
              style: const TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            Text(
              "${gifts[i]["price"]} 🪙",
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        );
      },
    );
  }
}
