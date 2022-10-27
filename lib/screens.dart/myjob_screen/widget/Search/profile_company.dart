// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_if_null_operators
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../components/constants/colors.dart';
import '../../../profile_screen/Edit_Profile_Screen.dart';
import '../../myjob_screen.dart';
import '../bottom_nav_bar.dart';

class ProfileCompanyScreen extends StatefulWidget {
  final VoidCallback openDrawer;
  final String userID;

  ProfileCompanyScreen({
    Key? key,
    required this.openDrawer,
    required this.userID,
  }) : super(key: key);

  @override
  State<ProfileCompanyScreen> createState() => _ProfileCompanyScreenState();
}

class _ProfileCompanyScreenState extends State<ProfileCompanyScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? name;
  String email = '';
  String phoneNumber = '';
  String imageUrl = '';
  String joinedAt = '';
  bool _isLoading = false;
  bool _isSameUser = false;
  void getUserData() async {
    try {
      _isLoading = true;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          name = userDoc.get('fullName');
          email = userDoc.get('email');
          phoneNumber = userDoc.get('phone');
          imageUrl = userDoc.get('profilePic');
          Timestamp joinedAtTimeStamp = userDoc.get('createdAt');
          var joinedDate = joinedAtTimeStamp.toDate();
          joinedAt = '${joinedDate.day}/${joinedDate.month}/${joinedDate.year}';
        });

        User? user = _auth.currentUser;
        final _uid = user!.uid;
        setState(() {
          _isSameUser = _uid == widget.userID;
        });
      }
    } catch (error) {
    } finally {
      _isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Widget userInfo({required IconData icon, required String content}) {
    return Row(
      children: [
        Icon(icon, color: Colors.black),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(content, style: const TextStyle(color: Colors.black54)),
        )
      ],
    );
  }

  Widget _contactBy(
      {required Color color, required Function fct, required IconData icon}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white,
        child: IconButton(
          onPressed: () {
            fct();
          },
          icon: Icon(icon, color: color),
        ),
      ),
    );
  }

  void _opeWhatsAppChat() async {
    var url = 'https://wa.me/$phoneNumber?text=Hello%20$name';
    launchUrlString(url);
  }

  void _mailTo() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query:
          'subject= Write subject here, Please&body=Hello, please write details here',
    );
    final url = params.toString();
    launchUrlString(url);
  }

  void _callPhoneNumber() async {
    var url = 'tel://$phoneNumber';
    launchUrlString(url);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Navigator.canPop(context)
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyJobScreen(openDrawer: widget.openDrawer)),
                      (route) => false)
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyJobScreen(openDrawer: widget.openDrawer)));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        // title: const Text('Company Profile'),
        // centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBarForApp(
        indexNum: 2,
        openDrawer: () {},
      ),
      body: Center(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(color: kAccent),
                )
              : SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Stack(
                        children: [
                          Card(
                            color: Colors.white10,
                            margin: const EdgeInsets.all(30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      name == null ? 'Name here' : name!,
                                      style: TextStyle(
                                          color: kAccent, fontSize: 24),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Divider(
                                      thickness: 1, color: Colors.white),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Account Information:',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: userInfo(
                                        icon: Icons.email, content: email),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: userInfo(
                                        icon: Icons.phone,
                                        content: phoneNumber),
                                  ),
                                  const SizedBox(height: 15),
                                  const Divider(
                                      thickness: 1, color: Colors.white),
                                  const SizedBox(height: 25),
                                  _isSameUser
                                      ? Container()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            _contactBy(
                                                color: Colors.green,
                                                fct: () {
                                                  _opeWhatsAppChat();
                                                },
                                                icon: FontAwesome.whatsapp),
                                            _contactBy(
                                                color: Colors.red,
                                                fct: () {
                                                  _mailTo();
                                                },
                                                icon: Icons.mail_outline),
                                            _contactBy(
                                                color: Colors.purple,
                                                fct: () {
                                                  _callPhoneNumber();
                                                },
                                                icon: Icons.call)
                                          ],
                                        ),
                                  !_isSameUser
                                      ? Container()
                                      : Center(
                                          child: Padding(
                                          padding: const EdgeInsets.all(30),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProfileScreen(
                                                            openDrawer: () {},
                                                          )));
                                            },
                                            color: kAccent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text('Edit Profile',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 28,
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(Icons.edit,
                                                      color: Colors.white)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * 0.26,
                                height: size.width * 0.26,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(width: 8, color: kAccent),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          // ignore: unnecessary_null_comparison
                                          imageUrl == null
                                              ? 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_960_720.png'
                                              : imageUrl,
                                        ),
                                        fit: BoxFit.fill)),
                              )
                            ],
                          )
                        ],
                      )),
                )),
    );
  }
}
