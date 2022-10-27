// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/screens.dart/myjob_screen/myjob_screen.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/auth_page.dart';

class UserState extends StatelessWidget {
  final VoidCallback openDrawer;
  UserState({
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (context, userSnapshot) {
          if (userSnapshot.data == null) {
            print('user is not logged in yet');
            return AuthPage();
          } else if (userSnapshot.hasData) {
            print('user is logged in');
            return MyJobScreen(openDrawer: openDrawer);
          } else if (userSnapshot.hasError) {
            return const Scaffold(
              body:
                  Center(child: Text('An error has occurred. Try again later')),
            );
          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator(color: kAccent)),
            );
          }
          return Scaffold(
            body: Center(child: Text('Something went wrong')),
          );
        },
        stream: FirebaseAuth.instance.authStateChanges());
  }
}
