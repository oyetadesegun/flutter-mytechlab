// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mytechlab/models/profile.dart';

import 'menu_list.dart';

class BodyProfile extends StatelessWidget {
  final profileMenuList = ProfileMenuList.generateProfileMenuList();
  final profileMenuList2 = ProfileMenuList2.generateProfileMenuList();
  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 2,
        child: ListView(children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Column(children: [
              ...profileMenuList.map((e) => MenuList(e)),
              SizedBox(height: 30),
              ...profileMenuList2.map((e) => MenuList2(e))
            ]),
          ),
        ]));
  }
}
