// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:mytechlab/main.dart';
// import 'package:mytechlab/my_home_page/my_home_page.dart';
// import 'package:mytechlab/screens.dart/Notification_screen/notification_screen.dart';
// import 'package:mytechlab/screens.dart/chat_screen/chat_screen.dart';
// import 'package:mytechlab/screens.dart/explore_screen/explore_screen.dart';
// import 'package:mytechlab/screens.dart/favourite_screen/favourite_screen.dart';
// import 'package:mytechlab/screens.dart/myjob_screen/myjob_screen.dart';
// import 'package:mytechlab/screens.dart/other_screens/HelpCentersScreen.dart';
// import 'package:mytechlab/screens.dart/other_screens/PolicyScreen.dart';
// import 'package:mytechlab/screens.dart/other_screens/TermsScreen.dart';
// import 'package:mytechlab/screens.dart/profile_screen/Edit_Profile_Screen.dart';
// import 'package:mytechlab/screens.dart/profile_screen/profile_screen.dart';
// import 'package:mytechlab/screens.dart/signup&login_screen/auth_page.dart';
// import 'package:mytechlab/screens.dart/splash_screen/intro_slider_screen.dart';
// import 'package:mytechlab/screens.dart/splash_screen/splash_screen.dart';
// import 'package:mytechlab/screens.dart/training_screen/screens/home/training_screen.dart';
// import 'package:mytechlab/screens.dart/wallet_screen/wallet_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   final prefs = await SharedPreferences.getInstance();
//   final showHome = prefs.getBool('showHome') ?? false;
//   runApp(MyApp(
//     showHome: showHome,
//     prefs: prefs,
//   ));
// }
// class NewHome extends StatelessWidget {
//   const NewHome({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return showHome ? SplashScreen() : IntroSliderScreen();
//         // routes: {
//         //   ProfileScreen.id: (context) => ProfileScreen(),
//         //   FavouriteScreen.id: (context) => FavouriteScreen(),
//         //   ExploreScreen.id: (context) => ExploreScreen(),
//         //   TrainingScreen.id: (context) => TrainingScreen(),
//         //   NotificationScreen.id: (context) => NotificationScreen(),
//         //   WalletScreen.id: (context) => WalletScreen(),
//         //   MyJobScreen.id: (context) => MyJobScreen(),
//         //   HelpCentersScreen.id: (context) => HelpCentersScreen(),
//         //   TermsScreen.id: (context) => TermsScreen(),
//         //   PolicyScreen.id: (context) => PolicyScreen(),
//         //   EditProfileScreen.id: (context) => EditProfileScreen(),
//         //   MyHomePage.id: (context) => MyHomePage(),
//         //   ChatScreen.id: (context) => ChatScreen(),
//         //   SplashScreen.id: (context) => SplashScreen(),
//         //   AuthPage.id: (context) => AuthPage(),
//         //   IntroSliderScreen.id: (context) => IntroSliderScreen(),
//         //   //  SignUpScreen.id: (context) => SignUpScreen(onClickedSignIn: toggle)

//         );
//   }
// }
