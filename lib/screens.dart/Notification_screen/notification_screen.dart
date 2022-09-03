import 'package:flutter/material.dart';

import '../../components/bottom_nav.dart';

class NotificationScreen extends StatelessWidget {
  static const String id = 'NotificationScreen';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text('Notification Screen')),
        bottomNavigationBar: BottomNav());
  }
}
