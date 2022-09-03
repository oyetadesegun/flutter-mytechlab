import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../../my_home_page/my_home_page.dart';
import '../chat_screen/auth_provider.dart';
import '../signup&login_screen/login_screen.dart';
import '../signup&login_screen/main_Login_screen.dart';
import 'intro_slider_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';

  @override
  State<SplashScreen> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    Future.delayed(Duration(seconds: 5), () {
      // checkSignedIn();
    });
  }

  startTimer() async {
    var duration = Duration(seconds: 5);
    return new Timer(duration, loginRoute);
  }

  loginRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainLoginScreen()));
  }

  // void checkSignedIn() async {
  //   AuthProvider authProvider = context.read<AuthProvider>();
  //   bool isLoggedIn = await authProvider.isLoggedIn();
  //   if (isLoggedIn) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => MyHomePage()));
  //     return;
  //   }
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => MainLoginScreen()));
  // }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset('images/logoName.png'),
          ),
          Container(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(color: kAccent),
          )
        ],
      ),
    );
  }
}
