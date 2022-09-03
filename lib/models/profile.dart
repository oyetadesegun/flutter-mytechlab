import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/explore_screen/explore_joblist.dart';
import 'package:mytechlab/screens.dart/explore_screen/explore_screen.dart';
import 'package:mytechlab/screens.dart/other_screens/HelpCentersScreen.dart';
import 'package:mytechlab/screens.dart/other_screens/TermsScreen.dart';
import 'package:mytechlab/screens.dart/profile_screen/Edit_Profile_Screen.dart';

import '../screens.dart/Notification_screen/notification_screen.dart';
import '../screens.dart/favourite_screen/favourite_screen.dart';
import '../screens.dart/other_screens/PolicyScreen.dart';
import '../screens.dart/training_screen/screens/home/training_screen.dart';
import '../screens.dart/wallet_screen/wallet_screen.dart';

class ProfileMenuList {
  String title;
  IconData icon;
  Color bgColor;
  String screen;
  ProfileMenuList(
    this.title,
    this.icon,
    this.bgColor,
    this.screen,
  );
  static List<ProfileMenuList> generateProfileMenuList() {
    return [
      ProfileMenuList('Notification', Icons.chat_bubble_outline, Colors.red,
          NotificationScreen.id),
      ProfileMenuList(
          'My Wallet', Icons.wallet, Colors.lightBlueAccent, WalletScreen.id),
      ProfileMenuList(
          'My Jobs', Icons.cases_outlined, Colors.blue, FavouriteScreen.id),
      ProfileMenuList('Job Search', Icons.add_to_photos_rounded,
          Color.fromARGB(255, 251, 192, 45), ExploreScreen.id),
      ProfileMenuList(
          'Training', Icons.school, Colors.orange, TrainingScreen.id),
    ];
  }
}

class ProfileMenuList2 {
  String title;
  IconData icon;
  Color bgColor;
  String screen;
  ProfileMenuList2(
    this.title,
    this.icon,
    this.bgColor,
    this.screen,
  );
  static List<ProfileMenuList2> generateProfileMenuList() {
    return [
      ProfileMenuList2('Edit My Profile', Icons.verified_user_outlined,
          Colors.deepPurple, EditProfileScreen.id),
      ProfileMenuList2(
          'Help center', Icons.headphones, Colors.green, HelpCentersScreen.id),
      ProfileMenuList2('Terms & Condition', Icons.question_mark, Colors.black,
          TermsScreen.id),
      ProfileMenuList2(
          'Privacy Policy', Icons.lock_outline, Colors.purple, PolicyScreen.id)
    ];
  }
}
