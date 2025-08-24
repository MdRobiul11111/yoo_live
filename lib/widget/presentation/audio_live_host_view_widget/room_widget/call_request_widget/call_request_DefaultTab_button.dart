import 'package:flutter/material.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/call_request_widget/call_requests_screen.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/call_request_widget/joining_call_request_page.dart';

class CallRequestDefaulttabButton extends StatelessWidget {
  const CallRequestDefaulttabButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black, // purple gradient bg
        body: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3E2350), Color(0xFF3E2350)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Top drag handle + close button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                // Custom TabBar
                Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFD57C81), Color(0xFFC254D0)],
                      ),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    tabs: const [
                      Tab(text: "        Call Requests        "),
                      Tab(text: "        Joining Call        "),
                    ],
                  ),
                ),

                // TabBar content
                Expanded(
                  child: TabBarView(
                    children: [CallRequestsScreen(), JoiningCallRequestPage()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
