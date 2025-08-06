import 'package:flutter/material.dart';
import 'package:yoo_live/widget/presentation/home/search_page/search_page.dart';
import 'package:yoo_live/widget/presentation/home/tab_bar_widget/Following_screen.dart';
import 'package:yoo_live/widget/presentation/home/tab_bar_widget/popular_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Two tabs: Following, For You
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 70, // adjust height as needed
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Gradient Tab Container
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFC5C7D), Color(0xFF6A82FB)],
                      ),
                    ),
                    labelPadding: EdgeInsets.symmetric(horizontal: 1),
                    labelStyle: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(text: '    Popular     '),
                      Tab(text: '  Following     '),
                      Tab(text: '    Games     '),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Search Icon
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.search, size: 30, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // PopularScreen
            PopularScreen(),
            //  FollowingScreen
            FollowingScreen(),

            const Center(
              child: Text(
                "comeing soon",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
