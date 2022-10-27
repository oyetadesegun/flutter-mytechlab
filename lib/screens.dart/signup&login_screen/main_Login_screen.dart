// ignore_for_file: must_be_immutable, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/drawer/Main_drawer_page.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/auth_page.dart';

class MainLoginScreen extends StatelessWidget {
  static const id = 'MainLoginScreen';
  bool showSpinner = false;

  MainLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if ((snapshot.connectionState) == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          } else if (snapshot.hasData) {
            return MainDrawerPage();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
