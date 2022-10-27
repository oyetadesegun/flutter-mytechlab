// import 'package:flutter/material.dart';
// import 'package:mytechlab/screens.dart/explore_screen/explore_screen.dart';
// import 'package:mytechlab/screens.dart/other_screens/HelpCentersScreen.dart';
// import 'package:mytechlab/screens.dart/other_screens/TermsScreen.dart';
// import 'package:mytechlab/screens.dart/profile_screen/Edit_Profile_Screen.dart';

// import '../screens.dart/Notification_screen/notification_screen.dart';
// import '../screens.dart/favourite_screen/favourite_screen.dart';
// import '../screens.dart/other_screens/PolicyScreen.dart';
// import '../screens.dart/training_screen/screens/home/training_screen.dart';
// import '../screens.dart/chat_screen/all_users.dart';

// class SettingsMenuList {
//   final VoidCallback openDrawer;
//   String title;
//   IconData icon;
//   Color bgColor;
//   Widget screen;
  
 
//   SettingsMenuList({
  
//    required this.title,
//    required this.icon,
//    required this.bgColor,
//    required this.screen, required this.openDrawer,
//   });
//   static List<SettingsMenuList> generateProfileMenuList() {
//     return [
//       SettingsMenuList(title:'Notification',  
//            bgColor:Colors.red, icon:Icons.chat_bubble_outline, openDrawer: openDrawer, screen: NotificationScreen()),
//       SettingsMenuList('View All Users', Icons.person_search,
//           Colors.lightBlueAccent, AllUsersScreen(openDrawer:openDrawer)),
//       SettingsMenuList(
//           'My Jobs', Icons.cases_outlined, Colors.blue, FavouriteScreen(openDrawer:openDrawer)),
//       SettingsMenuList('Job Search', Icons.add_to_photos_rounded,
//           const Color.fromARGB(255, 251, 192, 45), ExploreScreen(openDrawer:openDrawer,)),
//       SettingsMenuList('Training', Icons.school, Colors.orange, TrainingScreen(
//         openDrawer: (openDrawer:openDrawer) {
//           //TODO: open drawer
//         },
//       )),
//     ];
//   }
// }

// class SettingsMenuList2 {
//   String title;
//   IconData icon;
//   Color bgColor;
//   Widget screen;
//   SettingsMenuList2(
//     this.title,
//     this.icon,
//     this.bgColor,
//     this.screen,
//   );
//   static List<SettingsMenuList2> generateProfileMenuList() {
//     return [
//       SettingsMenuList2('Edit My Profile', Icons.verified_user_outlined,
//           Colors.deepPurple, EditProfileScreen()),
//       SettingsMenuList2(
//           'Help center', Icons.headphones, Colors.green, HelpCentersScreen()),
//       SettingsMenuList2('Terms & Condition', Icons.question_mark, Colors.black,
//           TermsScreen()),
//       SettingsMenuList2(
//           'Privacy Policy', Icons.lock_outline, Colors.purple, PolicyScreen())
//     ];
//   }
// }
