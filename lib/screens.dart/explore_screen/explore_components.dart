import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/profile_screen/profile_screen.dart';
import '../../components/constants/colors.dart';
import '../../data/user_data.dart';
import 'package:mytechlab/components/constants/constant.dart';

class FlexibleSection extends StatelessWidget {
  const FlexibleSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final user = FirebaseAuth.instance.currentUser!;
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
                        backgroundImage: NetworkImage(kProfilePicture)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '',
                    //user.email!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    kMember,
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
  const TitleSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // GestureDetector(
        //   onTap: () {
        //    Navigator.pushNamed(context, HomeScreen.id);
        //   },
        //   child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
        // ),
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
              Navigator.pushNamed(context, ProfileScreen.id);
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
      padding: const EdgeInsets.only(top: 30),
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

  const RowBottomJobApply(this.icon, this.text, this.value);

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
