// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/Notification_screen/notification_screen.dart';
import 'package:mytechlab/screens.dart/chat_screen/chat_screen.dart';
import 'package:mytechlab/screens.dart/course/main_course.dart';
import 'package:mytechlab/screens.dart/drawer/drawer_items.dart';
import 'package:mytechlab/screens.dart/myjob_screen/myjob_screen.dart';
import 'package:mytechlab/screens.dart/profile_screen/profile_page.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/main_Login_screen.dart';
import 'package:mytechlab/screens.dart/wallet_screen/wallet_screen.dart';

import '../../data/user_data.dart';
import '../../main.dart';

import '../settings_screen/settings_screen.dart';

import 'drawer_widget.dart';

class MainDrawerPage extends StatefulWidget {
  MainDrawerPage({Key? key}) : super(key: key);

  @override
  State<MainDrawerPage> createState() => _MainDrawerPageState();
}

class _MainDrawerPageState extends State<MainDrawerPage> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;

  bool isDragging = false;
  DrawerItem item = DrawerItems.home;
  @override
  void initState() {
    getUserInfo();
    openDrawer();
    super.initState();
  }

  void closeDrawer() => setState(() {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      });
  void openDrawer() => setState(() {
        xOffset = 230;
        yOffset = 150;
        scaleFactor = 0.6;
        isDrawerOpen = true;
      });
  getUserInfo() async {
    User user = FirebaseAuth.instance.currentUser!;
    var userId = user.uid;
    final DocumentSnapshot currentUser =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Constants.myName = currentUser.get('fullName');
    Constants.myUserName = currentUser.get('username');
    Constants.myProfilePic = currentUser.get('profilePic');
    Constants.myEmail = currentUser.get('email');
    Constants.myPhone = currentUser.get('phone');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Stack(children: [
        buildDrawer(),
        buildPage(),
      ]),
    );
  }

  Widget buildDrawer() => SafeArea(child: Container(
        //  width: xOffset,
        child: DrawerWidget(
          onSelectedItem: (item) {
            switch (item) {
              case DrawerItems.logout:
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.black45,
                        title: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.logout,
                                size: 36,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('Log Out',
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white)),
                            ),
                          ],
                        ),
                        content: const Text('Do you really want to Log out?',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : null;
                              },
                              child: const Text('No',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.green))),
                          TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : null;
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MainLoginScreen()));
                              },
                              child: const Text('Yes',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red)))
                        ],
                      );
                    });

                return;
              default:
                setState(() => this.item = item);
                closeDrawer();
            }
          },
        ),
      ));

  Widget buildPage() {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: closeDrawer,
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          if (!isDragging) return;
          const delta = 1;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }
          isDragging = false;
        },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor),
            child: AbsorbPointer(
              absorbing: isDrawerOpen,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isDrawerOpen ? 30 : 0),
                child: getDrawerPage(),
              ),
            )),
      ),
    );
  }

  Widget getDrawerPage() {
    switch (item) {
      case DrawerItems.jobListing:
        return MyJobScreen(openDrawer: openDrawer);
      case DrawerItems.wallet:
        return WalletScreen(openDrawer: openDrawer);
      case DrawerItems.chatRoom:
        return ChatRoom(openDrawer: openDrawer);
      case DrawerItems.myProfile:
        return ProfilePage(openDrawer: openDrawer);
      case DrawerItems.notification:
        return NotificationScreen(openDrawer: openDrawer);
      case DrawerItems.settings:
        return SettingsScreen(openDrawer: openDrawer);

      default:
        return MainCourse(openDrawer: openDrawer);
    }
  }
}
