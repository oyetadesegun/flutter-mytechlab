import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../drawer/drawer_menu_widget.dart';

AppBar buildAppBar(BuildContext context, VoidCallback openDrawer) {
  return AppBar(
    leading: DrawerMenuWidget(onClicked: openDrawer),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.moon_stars,
            color: Colors.black,
          )
          //
          )
    ],
  );
}
