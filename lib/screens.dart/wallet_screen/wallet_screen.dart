// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';

class WalletScreen extends StatelessWidget {
  final VoidCallback openDrawer;
  const WalletScreen({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccent,
        leading: GestureDetector(
          onTap: openDrawer,
          child: Icon(Icons.menu),
        ),
        title: Text('Wallet'),
      ),
    );
  }
}
