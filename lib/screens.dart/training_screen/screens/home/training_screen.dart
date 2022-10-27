import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytechlab/screens.dart/drawer/drawer_menu_widget.dart';

import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/active_course.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/emoji_text.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/feature_course.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/search_input.dart';
import 'package:mytechlab/services/auth.dart';

import '../../../../components/constants/colors.dart';
import '../../../../data/user_data.dart';
import '../../../../main.dart';

class TrainingScreen extends StatefulWidget {
  static const String id = 'TrainingScreen';
  final VoidCallback openDrawer;
  const TrainingScreen({super.key, required this.openDrawer});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class PopupChoices {
  String title;
  IconData icon;
  PopupChoices({
    required this.title,
    required this.icon,
  });
}

class _TrainingScreenState extends State<TrainingScreen> {
  AuthMethod authMethod = AuthMethod();

  final User user = FirebaseAuth.instance.currentUser!;
  String username = 'r';
  String fullname = '';
  String phone = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: isWhite ? kBackground : Colors.black,
      appBar: AppBar(
        backgroundColor: isWhite ? kBackground : Colors.black,
        leading: DrawerMenuWidget(onClicked: widget.openDrawer),
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            'Welcome ${Constants.myUserName},',
            style: TextStyle(color: kFontLight, fontSize: 16),
          ),
        ),
        actions: [
          SizedBox(width: 10),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, right: 20),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: kFontLight.withOpacity(0.3), width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: Image.asset(
                  'images/bell.png',
                  width: 30,
                  color: isWhite ? Colors.black : kBackground,
                ),
              ),
              // ),
              Positioned(
                top: 15,
                right: 30,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: kAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const EmojiText(),
            const SearchInput(),
            FeatureCourse(),
            ActiveCourse(),
          ],
        ),
      ),
    );
  }
}
