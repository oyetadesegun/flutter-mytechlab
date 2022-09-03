import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/my_home_page/my_home_page.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/auth_page.dart';

class MainLoginScreen extends StatelessWidget {
  static const id = 'MainLoginScreen';
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if ((snapshot.connectionState) == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          } else if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
