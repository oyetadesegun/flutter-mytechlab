// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mytechlab/components/constants/constant.dart';
import 'package:mytechlab/screens.dart/settings_screen/settings_screen.dart';

import '../../components/constants/colors.dart';
import '../../data/user_data.dart';
import '../drawer/drawer_menu_widget.dart';

class FlexibleSection extends StatelessWidget {
  FlexibleSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'topbar',
      child: Container(
          padding: EdgeInsets.only(top: 60),
          color: kAccent,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[500],
                    radius: 53,
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(Constants.myProfilePic)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    Constants.myName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Constants.myUserName,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}

class TitleSection extends StatelessWidget {
  final VoidCallback openDrawer;
  TitleSection({
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DrawerMenuWidget(onClicked: openDrawer),
        Center(
          child: Text(
            'Job Explore Page',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SettingsScreen(openDrawer: openDrawer)));
            },
            child: Icon(Icons.perm_identity, color: Colors.white, size: 30)),
      ],
    );
  }
}

class Heading extends StatelessWidget {
  String title;

  Heading({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Center(
        child: Text(title,
            style: TextStyle(
                color: kAccent, fontSize: 30, fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class RowBottomJobApply extends StatelessWidget {
  final IconData icon;
  final String text;
  final String value;

  RowBottomJobApply(this.icon, this.text, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Text(text, style: kBottomText),
        Spacer(),
        Text(value, style: kBottomBoldText),
      ],
    );
  }
}
