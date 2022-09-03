import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/login_screen.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/signup_screen.dart';

class AuthPage extends StatefulWidget {
  static const String id = 'AuthPage';

  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginScreen(onClickedSignUp: toggle)
      : SignUpScreen(onClickedSignIn: toggle); //onClickedSignIn: toggle);
  void toggle() => setState(() => isLogin = !isLogin);
}
