import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/services/helper_functions.dart';

import '../signup&login_screen/main_Login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  bool? userIsLoggedIn;
  @override
  void initState() {
    super.initState();
    startTimer();
    getLoggedInState();
    Future.delayed(const Duration(seconds: 5), () {});
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  startTimer() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, loginRoute);
  }

  loginRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainLoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
      ),
    );
  }
}
