// import 'package:flutter/material.dart';

// class NotificationPage extends StatelessWidget {
//   const NotificationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         centerTitle: true,
//         title: const Text(
//           "Notification",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: 3,
//         itemBuilder: (context, index) {
//           return Container(
//             margin: const EdgeInsets.only(bottom: 12),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey[900],
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Row(
//               children: [
//                 // Profile Image Placeholder
//                 const CircleAvatar(
//                   radius: 20,
//                   backgroundColor: Colors.grey,
//                   child: Icon(Icons.person, color: Colors.white),
//                 ),

//                 const SizedBox(width: 12),

//                 // Name + message
//                 Expanded(
//                   child: RichText(
//                     text: const TextSpan(
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                       children: [
//                         TextSpan(
//                           text: "Md Masud ",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         TextSpan(text: "was live now"),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Time
//                 const Text(
//                   "9min ago",
//                   style: TextStyle(color: Colors.grey, fontSize: 12),
//                 ),

//                 const SizedBox(width: 8),

//                 // Menu Button
//                 IconButton(
//                   icon: const Icon(Icons.more_horiz, color: Colors.white),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
