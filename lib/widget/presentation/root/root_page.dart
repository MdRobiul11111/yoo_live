import 'package:flutter/material.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/before_live_interface.dart';
import 'package:yoo_live/widget/presentation/home/home_page.dart';
import 'package:yoo_live/widget/presentation/inbox_widget/inbox_page.dart';
import 'package:yoo_live/widget/presentation/profile/profile_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    Icon(Icons.add),
    BeforeLiveScreen(),
    InboxPage(),

    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.black,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color.fromARGB(255, 255, 17, 0),
          unselectedItemColor: Colors.lightBlue,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 35),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart, size: 35),
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
              icon: Icon(Icons.message, size: 35),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 35),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
