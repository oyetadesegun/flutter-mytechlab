// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BodySettings extends StatelessWidget {
  // final profileMenuList = SettingsMenuList.generateProfileMenuList();
  // final profileMenuList2 = SettingsMenuList2.generateProfileMenuList();

  BodySettings({super.key});
  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 2,
        child: ListView(children: [
          // Container(
          //   padding: const EdgeInsets.symmetric(
          //     vertical: 5,
          //   ),
          //   child: Column(children: [
          //     ...profileMenuList.map((e) => MenuList(e)),
          //     const SizedBox(height: 30),
          //     ...profileMenuList2.map((e) => MenuList2(e))
          //   ]),
          // ),
        ]));
  }
}
