// import 'package:flutter/material.dart';

// class CoinsRankingScreen extends StatefulWidget {
//   const CoinsRankingScreen({super.key});

//   @override
//   State<CoinsRankingScreen> createState() => _CoinsRankingScreenState();
// }

// class _CoinsRankingScreenState extends State<CoinsRankingScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF3A2045),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.close, color: Colors.white),
//             onPressed: () {},
//           ),
//         ],
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(50),
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: TabBar(
//               controller: _tabController,
//               indicator: BoxDecoration(
//                 color: Colors.pink,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.grey,
//               tabs: const [
//                 Tab(text: "Daily"),
//                 Tab(text: "Weekly"),
//                 Tab(text: "Monthly"),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildLeaderboard("Daily", [
//             {"name": "Seam Rahman", "coins": "10k"},
//             {"name": "Rafi Khan", "coins": "8k"},
//             {"name": "Jannat", "coins": "6k"},
//           ]),
//           _buildLeaderboard("Weekly", [
//             {"name": "Seam Rahman", "coins": "50k"},
//             {"name": "Sadia", "coins": "30k"},
//             {"name": "Tanim", "coins": "25k"},
//           ]),
//           _buildLeaderboard("Monthly", [
//             {"name": "Seam Rahman", "coins": "200k"},
//             {"name": "Sakib", "coins": "150k"},
//             {"name": "Alif", "coins": "120k"},
//           ]),
//         ],
//       ),
//     );
//   }

//   Widget _buildLeaderboard(String title, List<Map<String, String>> users) {
//     return Column(
//       children: [
//         const SizedBox(height: 20),
//         // Total Coins
//         const Text(
//           "Total Coins",
//           style: TextStyle(color: Colors.white70, fontSize: 14),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           "💎 ${users.fold<int>(0, (sum, u) => sum + int.parse(u["coins"]!.replaceAll("k", "000")))}",
//           style: const TextStyle(
//             color: Colors.amber,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 20),

//         // User List
//         Expanded(
//           child: ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               return Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 10,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   children: [
//                     // Rank
//                     Text(
//                       "${index + 1}",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(width: 10),

//                     // Badge / Medal (example)
//                     Container(
//                       padding: const EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         color: Colors.brown,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: const Text(
//                         "9",
//                         style: TextStyle(color: Colors.white, fontSize: 12),
//                       ),
//                     ),
//                     const SizedBox(width: 10),

//                     // User Name
//                     Expanded(
//                       child: Text(
//                         user["name"]!,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),

//                     // Coins
//                     Text(
//                       "💎 ${user["coins"]}",
//                       style: const TextStyle(
//                         color: Colors.amber,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
