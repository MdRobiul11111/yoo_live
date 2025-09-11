import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoo_live/Features/Bloc/AuthBloc/auth_bloc.dart';
import 'package:yoo_live/widget/presentation/root/root_page.dart';
import 'package:yoo_live/widget/presentation/social_login/user_id_login_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void signInWithGoogle() {
    context.read<AuthBloc>().add(SignInWithGoogleRequested());
  }

  void signInWithFacebook() {
    context.read<AuthBloc>().add(SignInWithFacebookRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RootPage()),
            );
          }else if(state is AuthStateLoading){
            Center(child: CircularProgressIndicator());
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff090506),
            // image: DecorationImage(
            //   fit: BoxFit.fill,
            //   image: AssetImage("assets/image/image 258120.png"),
            // ),
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
                      "Drak Live",
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

                //fb login
                InkWell(
                  onTap: () {
                    signInWithFacebook();
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff292526),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        Image(
                          image: AssetImage("assets/image/image 258116.png"),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Continue with Facebook",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                //google login
                InkWell(
                  onTap: () {
                    signInWithGoogle();
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff292526),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        Image(
                          image: AssetImage(
                            "assets/image/image 258116 (1).png",
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Continue with Google",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RootPage()),
                        );
                      },
                      child: Image(
                        image: AssetImage("assets/image/Frame 1321318055.png"),
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserIdLoginPage(),
                          ),
                        );
                      },
                      child: Image(
                        image: AssetImage("assets/image/Frame 1321318054.png"),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "''You agree here that you are within all our rules",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "and regulations.''",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
