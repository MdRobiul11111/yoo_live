import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yoo_live/widget/presentation/social_login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late BuildContext _context;
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), (() {
      Navigator.pushReplacement(
        _context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Color(0xff070125),
      body: Center(
        child: SizedBox(
          child: Image.asset('assets/image/yoolive.jpg', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
