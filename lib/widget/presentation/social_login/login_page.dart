import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/image/image 258120.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              SizedBox(height: 85),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "YOO Live",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.insert_emoticon, color: Colors.white, size: 50),
                ],
              ),
              SizedBox(height: 150),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffD7DDE0),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      Image(image: AssetImage("assets/image/image 258116.png")),
                      SizedBox(width: 15),
                      Text(
                        "Continue with Facebook",
                        style: TextStyle(color: Colors.black, fontSize: 23),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffD7DDE0),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      Image(
                        image: AssetImage("assets/image/image 258116 (1).png"),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Continue with Google",
                        style: TextStyle(color: Colors.black, fontSize: 23),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              Image(image: AssetImage("assets/image/Frame 1321318055.png")),
            ],
          ),
        ),
      ),
    );
  }
}
