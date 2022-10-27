import 'package:flutter/material.dart';

List<BoxShadow> shadowList = [
  BoxShadow(
      color: Colors.grey.shade300, blurRadius: 30, offset: const Offset(0, 10))
];

class DrawerItem {
  final String title;
  final IconData icon;

  const DrawerItem({required this.title, required this.icon});
}

class DrawerItems {
  static const home =
      DrawerItem(icon: Icons.explore_outlined, title: 'Training');
  static const jobListing =
      DrawerItem(icon: Icons.cases_outlined, title: 'Job Listing');
  static const wallet =
      DrawerItem(icon: Icons.account_balance_wallet, title: 'Wallet');
  static const chatRoom = DrawerItem(icon: Icons.chat, title: 'Chat Room');
  static const myProfile = DrawerItem(icon: Icons.person, title: 'My Profile');
  static const notification =
      DrawerItem(icon: Icons.notification_add, title: 'Notification');
  static const settings = DrawerItem(icon: Icons.settings, title: 'Settings');
  static const logout = DrawerItem(icon: Icons.logout, title: 'Logout');
  static final List<DrawerItem> all = [
    home,
    jobListing,
    wallet,
    chatRoom,
    myProfile,
    notification,
    settings,
    logout,
  ];
}
