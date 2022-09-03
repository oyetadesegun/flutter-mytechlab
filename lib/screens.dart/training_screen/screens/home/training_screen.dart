// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:mytechlab/screens.dart/signup&login_screen/main_Login_screen.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/active_course.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/emoji_text.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/feature_course.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/search_input.dart';

import '../../../../components/constants/colors.dart';
import '../../../../main.dart';

class TrainingScreen extends StatefulWidget {
  // UserProvider userProvider;
  // TrainingScreen({
  //   Key? key,
  //   required this.userProvider,
  // }) : super(key: key);
  static const String id = 'TrainingScreen';

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
//   //final GoogleSignIn googleSignIn = GoogleSignIn();
  // final ScrollController listScrollController = ScrollController();
  // int _limit = 20;
  // int _limitIncrement = 20;
  // String _textSearch = '';
  // bool isLoading = false;
  // late String currentUserId;

  // late AuthProvider authProvider;
//late HomeProvider homeProvider;
  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(title: 'Settings', icon: Icons.settings),
    PopupChoices(title: 'Sign out', icon: Icons.exit_to_app)
  ];
  final User user = FirebaseAuth.instance.currentUser!;
  // final FirebaseAuth _firebaseAuth = ;
  String username = 'r';
  String fullname = '';
  String phone = '';
  String email = '';

//   Future<void> getUserData() async {
//     User user = FirebaseAuth.instance.currentUser!;
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .get()
//         .then((userData) {
//       setState(() {
//         username = userData.data()!['username'].toString();
//         fullname = userData.data()!['full name'].toString();
//         phone = userData.data()!['phone'].toString();
//         email = userData.data()!['email'].toString();
//       });
//     });
//   }

  // Future<void> handleSignOut() async {
  //   authProvider.handleSignOut();
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => MainLoginScreen()));
  // }

  // void scrollListener() {
  //   if (listScrollController.offset >=
  //           listScrollController.position.maxScrollExtent &&
  //       !listScrollController.position.outOfRange) {}
  //   setState(() {
  //     _limit += _limitIncrement;
  //   });
  // }

  // void onItemMenuPress(PopupChoices choice) {
  //   if (choice.title == 'Sign out') {
  //     handleSignOut();
  //   } else {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => TrainingScreen()));
  //   }
  // }

  // Widget buildPopupMenu() {
  //   return PopupMenuButton<PopupChoices>(
  //       icon: Icon(
  //         Icons.more_vert,
  //         color: Colors.grey,
  //       ),
  //       onSelected: onItemMenuPress,
  //       itemBuilder: (BuildContext context) {
  //         return choices.map((PopupChoices choice) {
  //           return PopupMenuItem(
  //             value: choice,
  //             child: Row(
  //               children: [
  //                 Icon(
  //                   choice.icon,
  //                   color: kAccent,
  //                 ),
  //                 Container(
  //                   width: 10,
  //                 ),
  //                 Text(
  //                   choice.title,
  //                   style: TextStyle(color: ColorConstants.primaryColor),
  //                 )
  //               ],
  //             ),
  //           );
  //         }).toList();
  //       });
  // }

//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//     authProvider = context.read<AuthProvider>();
//     //homeProvider = context.read<HomeProvider>();
//     if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
//       currentUserId = authProvider.getUserFirebaseId()!;
//     } else {
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => MainLoginScreen()),
//           (Route<dynamic> route) => false);
//     }
//     listScrollController.addListener(scrollListener);
//   }

  @override
  Widget build(BuildContext context) {
    //  var userData = widget.userProvider.currentUserData;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: isWhite ? kBackground : Colors.black,
      appBar: AppBar(
        backgroundColor: isWhite ? kBackground : Colors.black,
        leading: IconButton(
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
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            //   userData!.userName,
            //getUserData.toString(),
            'Welcome,',
            style: TextStyle(color: kFontLight, fontSize: 16),
          ),
        ),
        actions: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => MainLoginScreen())));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, right: 20),
                  padding: EdgeInsets.all(8),
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
              ),
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
          // buildPopupMenu(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            EmojiText(),
            SearchInput(),
            FeatureCourse(),
            ActiveCourse(),
          ],
        ),
      ),
    );
  }
}
