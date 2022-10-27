// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../components/constants/colors.dart';
import '../../data/user_data.dart';
import '../profile_screen/profile_page.dart';
import 'body_settings.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback openDrawer;
  const SettingsScreen({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: kAccent,
          leading: GestureDetector(onTap: openDrawer, child: Icon(Icons.menu))),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                              openDrawer: openDrawer,
                            )));
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 200,
                color: kAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 53,
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(Constants.myProfilePic)),
                      ),
                      const SizedBox(width: 20),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  Constants.myName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.keyboard_arrow_right,
                                    color: Colors.grey)
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.yellow[700],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                padding: const EdgeInsets.all(5),
                                child: Row(children: [
                                  Image.asset(kStar),
                                  Text(Constants.myUserName)
                                ]))
                          ])
                    ])
                  ],
                ),
              ),
            ),
            BodySettings()
          ],
        ),
      ),
    );
  }
}
