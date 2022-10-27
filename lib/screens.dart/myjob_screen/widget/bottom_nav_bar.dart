// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';

import 'package:mytechlab/screens.dart/myjob_screen/job_notification.dart';
import 'package:mytechlab/screens.dart/myjob_screen/upload_job.dart';
import 'package:mytechlab/screens.dart/myjob_screen/widget/Search/profile_company.dart';
import 'package:mytechlab/screens.dart/myjob_screen/widget/Search/search_companies.dart';

import '../myjob_screen.dart';

// ignore: must_be_immutable
class BottomNavigationBarForApp extends StatelessWidget {
  int indexNum = 0;

  final VoidCallback openDrawer;
  BottomNavigationBarForApp({
    Key? key,
    required this.indexNum,
    required this.openDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 50,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.blueAccent,
      color: kAccent,
      index: indexNum,
      items: const [
        Icon(Icons.list, size: 19, color: Colors.black),
        Icon(Icons.search, size: 19, color: Colors.black),
        Icon(Icons.person_pin, size: 19, color: Colors.black),
        Icon(Icons.notification_add, size: 19, color: Colors.black),
        Icon(Icons.add, size: 19, color: Colors.black),
      ],
      animationCurve: Curves.bounceInOut,
      animationDuration: const Duration(milliseconds: 300),
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyJobScreen(
                        openDrawer: openDrawer,
                      )));
        } else if (index == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AllWorkersScreen(
                        openDrawer: openDrawer,
                      )));
        } else if (index == 2) {
          final FirebaseAuth _auth = FirebaseAuth.instance;
          final User? user = _auth.currentUser;
          final String uid = user!.uid;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileCompanyScreen(
                        openDrawer: openDrawer,
                        userID: uid,
                      )));
        } else if (index == 3) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JobNotification(
                        openDrawer: openDrawer,
                      )));
        } else if (index == 4) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UploadJobNow(
                        openDrawer: openDrawer,
                      )));
        }
      },
    );
  }
}
