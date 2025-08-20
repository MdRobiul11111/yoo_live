import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Features/Bloc/AuthProfileBloc/auth_profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void fetchProfileDetails() {
    context.read<AuthProfileBloc>().add(FetchAuthProfileDetails());
  }

  @override
  void initState() {
    fetchProfileDetails();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<AuthProfileBloc, AuthProfileState>(
            builder: (context, state) {
              if (state is AuthProfileStateLoading) {
                return Center(child: CircularProgressIndicator());
              }
              else if (state is AuthProfileStateSuccess) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Back & Edit
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.edit, color: Colors.white),
                            ],
                          ),
                        ),

                        // Profile Image & Name

                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            "${state.authProfile.data?.profileImage}",
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "${state.authProfile.data?.name}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "ID: ${state.authProfile.data?.userId} | ${state
                              .authProfile.data?.country}",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),

                        const SizedBox(height: 8),

                        // VIP Icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 32,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xffAA7E59),
                                  ),
                                  child: Row(
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
                                  margin: EdgeInsets.symmetric(),
                                  height: 33,
                                  width: 33,
                                  child: Image(
                                    image: AssetImage(
                                      "assets/icon/Frame 2147228166.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 7),
                            Container(
                              height: 32,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffC95454),
                              ),
                              child: Center(
                                child: Text(
                                  "VIP",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Coins & Diamonds
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Coins
                            Container(
                              height: 32,
                              width: 97,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff616161),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Image(
                                    image: AssetImage(
                                        "assets/icon/coin 1.png"),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "100",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            // Diamonds
                            Container(
                              height: 32,
                              width: 97,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff8A5BB8),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Image(
                                    image: AssetImage(
                                        "assets/icon/diamond 1.png"),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "100",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Friends, Followers, Following
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _countColumn("0", "Friend"),
                            _countColumn("0", "Followers"),
                            _countColumn("0", "Following"),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // VIP Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 32,
                              width: 97,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff8A5BB8),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Image(
                                    image: AssetImage(
                                      "assets/icon/Simplification.png",
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "VIP",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            Container(
                              height: 32,
                              width: 97,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff8A5BB8),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Image(
                                    image: AssetImage(
                                      "assets/icon/Simplification (2).png",
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "SVIP",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            Container(
                              height: 32,
                              width: 97,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff8A5BB8),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Image(
                                    image: AssetImage(
                                      "assets/icon/Simplification (1).png",
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Store",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Grid Icons
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _gridItem(
                                "assets/icon/Frame 2147228116.png",
                                "Live history",
                              ),
                              _gridItem(
                                "assets/icon/Frame 2147228116 (4).png",
                                "Back Pack",
                              ),
                              _gridItem(
                                "assets/icon/Frame 2147228116 (1).png",
                                "My Level",
                              ),
                              _gridItem(
                                "assets/icon/Frame 2147228116 (3).png",
                                "Wallet",
                              ),
                              _gridItem(
                                "assets/icon/Frame 2147228123.png",
                                "Reseller",
                              ),
                              _gridItem(
                                "assets/icon/Frame 2147228116 (2).png",
                                "My Agency",
                              ),
                              _gridItem(
                                "assets/icon/Frame 2147228116 (5).png",
                                "Helping",
                              ),
                              _gridItem(
                                "assets/icon/Frame 2147228116 (6).png",
                                "Admin",
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Make a statement
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.brown[900],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.purpleAccent),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Make a statement.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Share your thoughts with your followers",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Bottom List Items
                        _listTile("About Us"),
                        _listTile("Help Line"),
                        _listTile("Invite Friends"),
                        _listTile("Settings"),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              }
              else if (state is AuthProfileError) {
                return Center(child: Text("There is an unexpected error",style: TextStyle(color: Colors.white),));
              };
              return SizedBox.shrink();
            }
        )
    );
  }

  Widget _countColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _gridItem(String imagePath, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          child: Image(image: AssetImage(imagePath), fit: BoxFit.cover),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _listTile(String title) {
    return ListTile(
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
    );
  }
}
