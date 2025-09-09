// import 'package:flutter/material.dart';

// class StorePage extends StatefulWidget {
//   const StorePage({super.key});

//   @override
//   State<StorePage> createState() => _StorePageState();
// }

// class _StorePageState extends State<StorePage> {
//   int selectedCategory = 2; // default: Party theme

//   final List<String> categories = [
//     "Frame",
//     "Entry effect",
//     "Party theme",
//     "Chat background",
//   ];

//   final List<Map<String, dynamic>> items = [
//     {"image": "https://via.placeholder.com/150/0000FF", "price": 1000},
//     {"image": "https://via.placeholder.com/150/FF0000", "price": 1000},
//     {"image": "https://via.placeholder.com/150/00FF00", "price": 1000},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text("Store", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // Category Buttons
//           SizedBox(
//             height: 50,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               itemBuilder: (context, index) {
//                 final isSelected = selectedCategory == index;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedCategory = index;
//                     });
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 6,
//                       vertical: 8,
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       color: isSelected ? Colors.pinkAccent : Colors.grey[800],
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Center(
//                       child: Text(
//                         categories[index],
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           const SizedBox(height: 10),

//           // Items Grid
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 childAspectRatio: 0.65,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//               ),
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 final item = items[index];
//                 return Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[900],
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Image
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.network(
//                           item["image"],
//                           height: 100,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(height: 8),

//                       // Price
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.monetization_on,
//                             color: Colors.orange,
//                             size: 18,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             "${item["price"]}",
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Spacer(),

//                       // Buy Now Button
//                       GestureDetector(
//                         onTap: () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                 "Bought item for ${item["price"]} coins!",
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(
//                             horizontal: 8,
//                             vertical: 6,
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           decoration: BoxDecoration(
//                             gradient: const LinearGradient(
//                               colors: [Colors.pinkAccent, Colors.purple],
//                             ),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               "Buy Now",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomCategoryTabs extends StatelessWidget {
  final List<String> categories = [
    "All",
    "Popular",
    "Following",
    "Games",
    "Shop",
  ];

  final List<Widget> pages = [
    AllPage(),
    PopularPage(),
    // FollowingPage(),
    GamesPage(),
    ShopPage(), ShopPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Categories", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "View All",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Category Buttons
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    /// Navigate to new page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => pages[index]),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.grey[900],
                    ),
                    child: Text(
                      categories[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------ Different Pages ------------------

class AllPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("All")),
      body: const Center(
        child: Text(
          "This is All Page",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class PopularPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Popular")),
      body: const Center(
        child: Text(
          "This is Popular Page",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class GamesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Games")),
      body: const Center(
        child: Text(
          "This is Games Page",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Shop")),
      body: const Center(
        child: Text(
          "This is Shop Page",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
