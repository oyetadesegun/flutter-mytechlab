// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mytechlab/models/profile.dart';

class MenuList extends StatelessWidget {
  final ProfileMenuList profileMenuList;

  MenuList(
    this.profileMenuList,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, profileMenuList.screen),
      child: ListTile(
        leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: profileMenuList.bgColor,
            ),
            padding: EdgeInsets.all(5),
            child: Icon(
              profileMenuList.icon,
              color: Colors.white,
            )),
        title: Text(profileMenuList.title),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}

class MenuList2 extends StatelessWidget {
  final ProfileMenuList2 profileMenuList2;
  const MenuList2(this.profileMenuList2);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, profileMenuList2.screen),
      child: ListTile(
        leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: profileMenuList2.bgColor,
            ),
            padding: EdgeInsets.all(5),
            child: Icon(profileMenuList2.icon, color: Colors.white)),
        title: Text(profileMenuList2.title),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
