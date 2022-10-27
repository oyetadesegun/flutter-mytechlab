// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mytechlab/screens.dart/profile_screen/Edit_Profile_Screen.dart';
import 'package:mytechlab/screens.dart/profile_screen/buildAppBar.dart';
import 'package:mytechlab/screens.dart/profile_screen/user.dart';

import '../../data/user_data.dart';
import 'ButtonWidget.dart';
import 'NumbersWidget.dart';
import 'ProfileWidget.dart';

class ProfilePage extends StatelessWidget {
  final VoidCallback openDrawer;
  const ProfilePage({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context, openDrawer),
      body: Builder(builder: (context) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: Constants.myProfilePic,
              onClicked: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                          openDrawer: openDrawer,
                        )));
              }, // pImage: Constants.myProfilePic.to,
            ),
            const SizedBox(height: 24),
            buildName(user),
            const SizedBox(height: 24),
            Center(
                child: ButtonWidget(
              text: 'Update Profile Details',
              onClicked: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                          openDrawer: openDrawer,
                        )));
              },
            )),
            const SizedBox(height: 24),
            NumbersWidget(),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Phone Number',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Text(Constants.myPhone,
                      style: const TextStyle(fontSize: 16, height: 1.4))
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Text(Constants.myEmail,
                      style: const TextStyle(fontSize: 16, height: 1.4))
                ],
              ),
            ),
            const SizedBox(height: 24),
            buildAbout(user),
            const SizedBox(height: 24),
          ],
        );
      }),
    );
  }

  Widget buildName(RUser user) => Column(
        children: [
          Text(
            Constants.myName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(Constants.myUserName,
              style: TextStyle(color: Colors.grey, fontSize: 18))
        ],
      );

  // Widget buildUpgradeButton() => ButtonWidget(
  //       text: 'Update Profile Details',
  //       onClicked: () {},
  //     );

  Widget buildAbout(RUser user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('About',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(user.about, style: const TextStyle(fontSize: 16, height: 1.4))
          ],
        ),
      );
}
