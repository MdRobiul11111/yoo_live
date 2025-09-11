import 'package:flutter/material.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/gift_widget/gift_cp_page.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/gift_widget/gift_custom_page.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/gift_widget/gift_hot_page.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/gift_widget/gift_lucky_page.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/room_widget/gift_widget/gift_vip_page.dart';

class GiftScreen extends StatefulWidget {
  const GiftScreen({Key? key}) : super(key: key);

  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            gradient: const LinearGradient(
              colors: [Color(0xFF3D263B), Color(0xFF724D70)],
            ),
          ),
          child: Column(
            children: [
              // Close Button
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // TabBar
              TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicator: const BoxDecoration(),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: "Hot"),
                  Tab(text: "Lucky"),
                  Tab(text: "Cp"),
                  Tab(text: "Custom"),
                  Tab(text: "Vip"),
                ],
              ),

              const SizedBox(height: 10),

              // TabBarView with Separate Pages
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    GiftHotPage(),
                    GiftLuckyPage(),
                    GiftCpPage(),
                    GiftCustomPage(),
                    GiftVipPage(),
                  ],
                ),
              ),

              // Bottom Section
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Coins
                    Row(
                      children: const [
                        Icon(
                          Icons.monetization_on,
                          color: Colors.amber,
                          size: 20,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "104",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.keyboard_arrow_right, color: Colors.white),
                      ],
                    ),

                    // Pagination + Send Button
                    Row(
                      children: [
                        _PageButton("1"),
                        _PageButton("10"),
                        _PageButton("66"),
                        _PageButton("99"),

                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 35,
                            width: 80,
                            margin: const EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFB460D2), Color(0xFFC358C6)],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Text(
                                "Send",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🔹 Reusable PageButton
class _PageButton extends StatelessWidget {
  final String text;
  const _PageButton(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
