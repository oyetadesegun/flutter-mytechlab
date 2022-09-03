import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/constants/colors.dart';
import '../../data/user_data.dart';
import 'package:mytechlab/components/constants/constant.dart';

class MainProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  final user = FirebaseAuth?.instance.currentUser!;
    return Container(
      padding: EdgeInsets.all(20),
      height: 200,
      color: kAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notes,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            height: 20,
          ),
          Row(children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 53,
              child: CircleAvatar(
                  radius: 50, backgroundImage: NetworkImage(kProfilePicture)),
            ),
            SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Text(
                    "",
                    overflow: TextOverflow.ellipsis,
                    //    user.email!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                ],
              ),
              SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: EdgeInsets.all(5),
                  child: Row(children: [Image.asset(kStar), Text(kMember)]))
            ])
          ])
        ],
      ),
    );
  }
}
