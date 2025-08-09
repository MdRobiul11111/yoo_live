import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoo_live/Features/Bloc/AuthBloc/auth_bloc.dart';
import 'package:yoo_live/widget/presentation/root/root_page.dart';
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
        MaterialPageRoute(builder: (context) => CheckUserStatus()),
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


class CheckUserStatus extends StatefulWidget {
  const CheckUserStatus({super.key});

  @override
  State<CheckUserStatus> createState() => _CheckUserStatusState();
}

class _CheckUserStatusState extends State<CheckUserStatus> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(CheckUserSignedIn());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc,AuthState>(listener: (context,state){
        if(state is AuthStateSignIn){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RootPage()),
          );
        }else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      },child:SizedBox.shrink(),),
    );
  }
}

