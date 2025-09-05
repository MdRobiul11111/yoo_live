import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  int selectedIndex = 0;

  final List<String> categories = [
    "All",
    "Popular",
    "Following",
    "Games",
    "Shop",
  ];

  final List<Widget> pages = [
    Center(child: Text("All Page", style: TextStyle(fontSize: 24))),
    Center(child: Text("Popular Page", style: TextStyle(fontSize: 24))),
    Center(child: Text("Following Page", style: TextStyle(fontSize: 24))),
    Center(child: Text("Games Page", style: TextStyle(fontSize: 24))),
    Center(child: Text("Shop Page", style: TextStyle(fontSize: 24))),
  ];

  final List<String> carouselImages = [
    "https://picsum.photos/id/237/400/200",
    "https://picsum.photos/id/238/400/200",
    "https://picsum.photos/id/239/400/200",
    "https://picsum.photos/id/240/400/200",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yoo Live"), centerTitle: true),
      body: Column(
        children: [
          // Carousel Slider
          CarouselSlider(
            items:
                carouselImages.map((url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.85,
            ),
          ),

          const SizedBox(height: 15),

          // Category Buttons
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.pink : Colors.grey[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Selected Page Content
          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}
