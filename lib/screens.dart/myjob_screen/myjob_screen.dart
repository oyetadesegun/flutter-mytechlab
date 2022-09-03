import 'package:flutter/material.dart';

class MyJobScreen extends StatelessWidget {
  static const String id = 'MyJobScreen';
  const MyJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('My Job Screen')),
    ); //    bottomNavigationBar: BottomNav());
  }
}
