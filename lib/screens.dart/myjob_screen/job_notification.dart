import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/myjob_screen/myjob_screen.dart';

import '../../components/constants/colors.dart';
import 'widget/bottom_nav_bar.dart';

class JobNotification extends StatelessWidget {
  final VoidCallback openDrawer;

  const JobNotification({super.key, required this.openDrawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccent,
        leading: GestureDetector(
            onTap: () {
              Navigator.canPop(context)
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyJobScreen(openDrawer: openDrawer)),
                      (route) => false)
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyJobScreen(openDrawer: openDrawer)));
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text('Job Notification'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBarForApp(
        indexNum: 3,
        openDrawer: openDrawer,
      ),
    );
  }
}
