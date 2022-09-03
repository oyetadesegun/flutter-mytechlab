// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mytechlab/models/profile.dart';

import '../screens.dart/chat_screen/chat_screen.dart';
import '../screens.dart/explore_screen/explore_screen.dart';
import '../screens.dart/favourite_screen/favourite_screen.dart';
import '../screens.dart/profile_screen/profile_screen.dart';
import '../screens.dart/training_screen/screens/home/training_screen.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  void callBack() {}
  int selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (currentIndex) {
        if (currentIndex == 0) {
          setState(() {
            selectedIndex = 0;
            Navigator.of(context).pushNamed(TrainingScreen.id);
          });
        }
        if (currentIndex == 1) {
          setState(() {
            selectedIndex = 1;
            Navigator.of(context).pushNamed(ExploreScreen.id);
          });
        }
        if (currentIndex == 2) {
          Navigator.of(context).pushNamed(ChatRoom.id);
        }
        if (currentIndex == 3) {
          Navigator.of(context).pushNamed(ProfileScreen.id);
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cases_outlined),
          label: 'Jobs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervisor_account),
          label: 'Profile',
        )
      ],
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
    );
  }
}
