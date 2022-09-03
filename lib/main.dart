// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/signup_screen.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/utils.dart';
import 'package:mytechlab/screens.dart/splash_screen/intro_slider_screen.dart';
import 'package:mytechlab/screens.dart/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isWhite = true;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(
    showHome: showHome,
    prefs: prefs,
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

final user = FirebaseAuth.instance.currentUser;

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  final bool showHome;
  MyApp({Key? key, required this.showHome, required this.prefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.black,
        ),
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: showHome ? SplashScreen() : IntroSliderScreen());
  }
}
