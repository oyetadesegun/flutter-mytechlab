// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../data/user_data.dart';
import '../../main.dart';
import '../signup&login_screen/ForgotPasswordPage.dart';
import 'drawer_items.dart';

class DrawerWidget extends StatefulWidget {
  final ValueChanged<DrawerItem> onSelectedItem;
  const DrawerWidget({
    Key? key,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildProfile(context),
              const SizedBox(
                height: 20,
              ),
              buildDrawerItems(context),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );

  Widget buildDrawerItems(BuildContext context) => Column(
        children: DrawerItems.all
            .map((item) => ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  leading: Icon(item.icon, color: Colors.white),
                  title: Text(item.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  onTap: () => widget.onSelectedItem(item),
                ))
            .toList(),
      );

  Widget buildProfile(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(Constants.myProfilePic),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Constants.myName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 3),
            Text(
              Constants.myUserName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white54,
                  fontSize: 20),
            )
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () => "",
          icon: Switch(
            value: isWhite,
            onChanged: (value) {
              setState(() {
                isWhite = value;
                print(isWhite);
              });
            },
            activeTrackColor: Colors.grey,
            activeColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.black45,
          ),
        ),
      ],
    );
  }
}
