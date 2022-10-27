import 'package:flutter/material.dart';

import '../../components/constants/colors.dart';

class NotificationScreen extends StatelessWidget {
  final VoidCallback openDrawer;
  static const String id = 'NotificationScreen';
  NotificationScreen({
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kAccent,
            leading:
                GestureDetector(onTap: openDrawer, child: Icon(Icons.menu))),
        body: Center(child: Text('Notification Screen')));
    // bottomNavigationBar: BottomNav());
  }
}
