import 'package:flutter/material.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/audio_room_page.dart';

class BeforeLiveScreen extends StatefulWidget {
  const BeforeLiveScreen({super.key});

  @override
  State<BeforeLiveScreen> createState() => _BeforeLiveScreenState();
}

class _BeforeLiveScreenState extends State<BeforeLiveScreen> {
  String selectedCategory = 'Song';
  int selectedSeat = 8;

  final List<String> categories = [
    'Song',
    'Music',
    'Story',
    'Fun',
    'PK',
    'Another',
  ];
  final List<int> seatOptions = [8, 12, 16];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Category",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children:
                  categories.map((category) {
                    final isSelected = selectedCategory == category;
                    return ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.black : Colors.black,
                      ),
                      selectedColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.white),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 30),
            const Text(
              "Add a image",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image, color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Add a title',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 30),
            const Text(
              "Seat",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Row(
              children:
                  seatOptions.map((seat) {
                    final isSelected = selectedSeat == seat;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSeat = seat;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                        ),
                        child: Text(
                          seat.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFBAE3C), Color(0xFFB64EF0)],
                ),
              ),
              child: TextButton.icon(
                onPressed: () {
                  // Go Live logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AudioRoomPage()),
                  );
                },
                icon: const Icon(Icons.graphic_eq, color: Colors.white),
                label: const Text(
                  "Go Live",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
