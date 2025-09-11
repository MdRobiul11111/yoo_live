import 'package:flutter/material.dart';

class CoinsRankingScreen extends StatefulWidget {
  const CoinsRankingScreen({super.key});

  @override
  State<CoinsRankingScreen> createState() => _CoinsRankingScreenState();
}

class _CoinsRankingScreenState extends State<CoinsRankingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3D263B), Color(0xFF724D70)],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              // Custom top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              // TabBar without underline
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD5788D), Color(0xFFB64EF0)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  dividerColor:
                      Colors
                          .transparent, // ✅ New property (Flutter 3.7+) removes underline
                  tabs: const [
                    Tab(text: "     Daily     "),
                    Tab(text: "     Weekly     "),
                    Tab(text: "     Monthly     "),
                  ],
                ),
              ),

              // Tab content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildLeaderboard("Daily", [
                      {"name": "Seam Rahman", "coins": "10k"},
                      {"name": "Rafi Khan", "coins": "8k"},
                      {"name": "Jannat", "coins": "6k"},
                    ]),
                    _buildLeaderboard("Weekly", [
                      {"name": "Seam Rahman", "coins": "50k"},
                      {"name": "Sadia", "coins": "30k"},
                      {"name": "Tanim", "coins": "25k"},
                    ]),
                    _buildLeaderboard("Monthly", [
                      {"name": "Seam Rahman", "coins": "200k"},
                      {"name": "Sakib", "coins": "150k"},
                      {"name": "Alif", "coins": "120k"},
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboard(String title, List<Map<String, String>> users) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "Total Coins",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 5),
        Text(
          "💎 ${users.fold<int>(0, (sum, u) => sum + int.parse(u["coins"]!.replaceAll("k", "000")))}",
          style: const TextStyle(
            color: Colors.amber,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Text(
                      "${index + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Stack(
                      children: [
                        Container(
                          height: 32,
                          width: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffAA7E59),
                          ),
                          child: const Row(
                            children: [
                              Spacer(),
                              Text(
                                "9",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 12),
                            ],
                          ),
                        ),
                        Container(
                          height: 33,
                          width: 33,
                          child: const Image(
                            image: AssetImage(
                              "assets/icon/Frame 2147228166.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        user["name"]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      "💎 ${user["coins"]}",
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
