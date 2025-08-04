import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Icon(Icons.add),
    Icon(Icons.add),
    Icon(Icons.add),
    Icon(Icons.add),
    Icon(Icons.add),
  ];

  void _onTap(int index) {
    setState(() {
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 40),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        ],
      ),
    );
  }
}
