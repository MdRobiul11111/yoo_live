import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/before_live_interface.dart';
import 'package:yoo_live/widget/presentation/home/home_page.dart';
import 'package:yoo_live/widget/presentation/notification_widget/notification_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    Icon(Icons.add),
    BeforeLiveScreen(),
    NotificationPage(),
    Icon(Icons.add),
  ];

  void _onTap(int index) async{
    setState(() async {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
<<<<<<< HEAD
        selectedItemColor: const Color.fromARGB(255, 240, 3, 82),
        unselectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 35), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 35),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 241, 19, 3),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Icon(Icons.videocam, size: 35, color: Colors.white),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, size: 35),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 35),
            label: '',
          ),
=======
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 40),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search',),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
>>>>>>> c12b0a28b39e59c6294dc53f68ca516cf7bd6089
        ],
      ),
    );
  }
}
