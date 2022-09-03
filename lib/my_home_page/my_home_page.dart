import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/constants/colors.dart';
import '../data/job_data.dart';
import '../main.dart';

import '../screens.dart/chat_screen/chat_screen.dart';
import '../screens.dart/explore_screen/explore_screen.dart';
import '../screens.dart/profile_screen/profile_screen.dart';
import '../screens.dart/training_screen/screens/home/training_screen.dart';
import '../screens.dart/wallet_screen/wallet_screen.dart';

class MyHomePage extends StatefulWidget {
  static const String id = 'MyHomePage';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: isWhite ? Colors.white : Colors.black,
        body: buildPageView(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: isWhite ? kBackground : Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kAccent,
          unselectedItemColor: kPrimaryDark,
          currentIndex: bottomSelectedIndex,
          onTap: (index) {
            bottomTapped(index);
          },
          items: buildBottomNavBarItems(),
        ),
      ),
    );
  }

  int bottomSelectedIndex = 0;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
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
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    final Jobs job;
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        TrainingScreen(),
        ExploreScreen(),
        ChatRoom(),
        WalletScreen(),
        ProfileScreen(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
}
