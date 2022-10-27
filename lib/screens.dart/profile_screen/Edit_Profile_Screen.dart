// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'package:mytechlab/data/user_data.dart';
import 'package:mytechlab/screens.dart/profile_screen/ProfileWidget.dart';
import 'package:mytechlab/screens.dart/profile_screen/profile_page.dart';
import 'package:mytechlab/screens.dart/profile_screen/user.dart';

import '../../components/constants/colors.dart';
import '../../services/database.dart';
import 'buildAppBar.dart';

class EditProfileScreen extends StatefulWidget {
  final VoidCallback openDrawer;
  const EditProfileScreen({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState(openDrawer);
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  RUser user = UserPreferences.myUser;
  final formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  QuerySnapshot? snapshotUserInfo;

  DatabaseMethods databaseMethods = DatabaseMethods();
  File? imageFile;
  String? profilePic;
  final VoidCallback openDrawer;

  _EditProfileScreenState(this.openDrawer);

  void initState() {
    super.initState();

    fullNameController = TextEditingController(text: Constants.myName);
    emailController = TextEditingController(text: Constants.myEmail);
    phoneController = TextEditingController(text: Constants.myPhone);
    aboutController = TextEditingController(text: user.about);
    addressController = TextEditingController(text: Constants.myLocation);
  }

  void updateProfile() async {
    final String auth = FirebaseAuth.instance.currentUser!.uid;
    // profilePic = await FirebaseStorage.instance
    //     .ref()
    //     .child('profilePic')
    //     .child('$auth.jpg')
    //     .getDownloadURL();
    FirebaseFirestore.instance.collection('users').doc(auth).update({
      'profilePic': profilePic,
      'fullName': fullNameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'about': aboutController.text.trim(),
      'address': addressController.text.trim()
    }).then((value) {
      setState(() {
        Constants.myEmail = emailController.text.trim();
        Constants.myName = fullNameController.text.trim();
        Constants.myPhone = phoneController.text.trim();
        Constants.myLocation = addressController.text.trim();

        Navigator.canPop(context)
            ? Navigator.pop(context)
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        ProfilePage(openDrawer: openDrawer))));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Future uploadPic(BuildContext context) async {
      String fileName = path.basename(imageFile!.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask;
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Profile Picture Uploaded")));
      });
    }
    //   Future uploadFile() async {
    //   if (file == null) return;
    //   final fileName = path.basename(file!.path);
    //   final destination = 'files/$fileName';
    //   FirebaseApi.uploadFile(destination, file!);

    //   task = FirebaseApi.uploadFile(destination, file!);
    //   setState(() {});
    //   if (task == null) return;
    //   final snapshot = await task!.whenComplete(() {});
    //   final urlDownload = await snapshot.ref.getDownloadURL().then((value) {
    //     setState(() {
    //       profilepic = value;
    //     });

    //     print('Download-Link:$profilepic');
    //   });
    // }
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(context, openDrawer),
        body: Builder(builder: (context) {
          return Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: 20),
                ProfileWidget(
                  //  pImage: pImage,
                  imagePath: Constants.myProfilePic,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FullName',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 8),
                    TextFormField(
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'Name can not be Empty';
                        if (value.length < 4) {
                          return 'Name can not be less than 4';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                      maxLines: 1,
                      controller: fullNameController,
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 8),
                    TextFormField(
                      onChanged: (value) {},
                      validator: (email) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email!)
                            ? null
                            : 'Please provide a valid Email address';
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                      maxLines: 1,
                      controller: emailController,
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phone Number',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 8),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone number can not be empty';
                        }
                        if (value.length < 11) {
                          return 'enter a correct phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                      maxLines: 1,
                      controller: phoneController,
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 8),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address can not be empty';
                        }
                        if (value.length < 5) {
                          return 'enter a correct Address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                      maxLines: 1,
                      controller: addressController,
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About Me',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 8),
                    TextFormField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                      maxLines: 5,
                      controller: aboutController,
                    )
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    child: Text(
                      'Update Profile',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        foregroundColor: Colors.white,
                        backgroundColor: kAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
                    onPressed: () {
                      updateProfile();
                    })
              ],
            ),
          );
        }));
  }
}
