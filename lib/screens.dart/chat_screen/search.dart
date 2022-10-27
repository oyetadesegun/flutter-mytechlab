// ignore_for_file: avoid_function_literals_in_foreach_calls, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/screens.dart/chat_screen/conversation_screen.dart';
import 'package:mytechlab/services/database.dart';
import '../../components/constants/constant.dart';
import '../../data/user_data.dart';
import '../../main.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();
  QuerySnapshot? searchSnapshot;
  List<String> docIDs = [];
  String? docId;

  String searchQuery = 'Search query';
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              docIDs.add(document.reference.id);
            }));
  }

  Widget searchList() {
    return searchSnapshot != null
        ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('username', isEqualTo: searchQuery)
                .snapshots(),
            builder: (context, snapshot) {
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => SearchTile(
                      userName: snapshot.data!.docs[index]['username'],
                      fullName: snapshot.data!.docs[index]['fullName'],
                      profilePic: snapshot.data!.docs[index]['profilePic'],
                      docId: snapshot.data!.docs[index]['docId']),
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(color: Theme.of(context).scaffoldBackgroundColor),
                  itemCount: snapshot.data!.docs.length);
            },
          )
        : Container();
    // return searchSnapshot != null
    //     ? ListView.separated(
    //         shrinkWrap: true,
    //         itemCount: searchSnapshot!.docs.length,
    //         itemBuilder: (context, index) {
    //           return SearchTile(
    //             docId: searchSnapshot!.docs[index]['docId'],
    //             userName: searchSnapshot!.docs[index]['username'],
    //             fullName: searchSnapshot!.docs[index]['fullName'],
    //             profilePic: searchSnapshot!.docs[index]['profilePic'],
    //           );
    //         },
    //         separatorBuilder: (BuildContext context, int index) =>
    //             Divider(color: Theme.of(context).scaffoldBackgroundColor),
    //       )
    //     : Container();
  }

  createChatRoomAndStartConversation({required String chatUserId}) {
    if (chatUserId != Constants.uid) {
      String chatRoomId = getChatRoomId(chatUserId, Constants.uid);
      List<String> users = [chatUserId, Constants.uid];
      Map<String, dynamic> chatRoomMap = {
        'users': users,
        'chatroomId': chatRoomId,
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(
                    chatUserId: searchSnapshot!.docs[0]['docId']!,
                    chatRoomId: chatRoomId,
                    profilePic: searchSnapshot!.docs[0]['profilePic']!,
                    chatUserName: searchSnapshot!.docs[0]['fullName'],
                  )));
    } else {
      const SnackBar(content: Text('you can not message yourself'));
    }
  }

  initiateSearch() {
    databaseMethods
        .getUserByUsername(
      searchTextEditingController.text.trim(),
    )
        .then((value) {
      setState(() {
        searchSnapshot = value;
        docId = searchSnapshot!.docs[0]['docId'];
      });
    });
  }

  Widget SearchTile(
      {required String userName,
      required String fullName,
      required String profilePic,
      required String docId}) {
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: kAccent,
            radius: 40,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 38,
              child: ClipOval(
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Image.network(
                    profilePic,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(fullName, style: kDarkText.copyWith(color: Colors.black)),
              SizedBox(width: 10),
              Text(
                userName,
                style: TextStyle(
                  color: kDark,
                  fontSize: 18,
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndStartConversation(chatUserId: docId);
              Constants.chatUserId = docId;
              getChatFullDetail();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: kAccent, borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: const Text(
                'Message',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    Constants.uid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  getChatFullDetail() async {
    final DocumentSnapshot chatUser = await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.chatUserId)
        .get();
    Constants.chatUserProfilePic = chatUser.get('profilePic');
    Constants.chatUserFullName = chatUser.get('fullName');
    Constants.chatUserName = chatUser.get('username');
    Constants.chatUserProfilePic = chatUser.get('profilePic');
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
      initiateSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kAccent,
          title: Text('Search By Username'),
        ),
        body: SingleChildScrollView(
          child: Stack(children: [
            Container(
                color: isWhite ? Colors.white : Colors.black,
                child: Column(children: [
                  Container(
                      color: isWhite ? Colors.grey[100] : Color(0x54ffffff),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              autocorrect: true,
                              onChanged: (query) => updateSearchQuery(query),
                              controller: searchTextEditingController,
                              style: kDarkText.copyWith(
                                  fontWeight: FontWeight.normal),
                              decoration: InputDecoration(
                                  hintText: 'search username...',
                                  hintStyle: TextStyle(
                                    color:
                                        isWhite ? Colors.grey : Colors.white54,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              initiateSearch();
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: isWhite
                                          ? [
                                              Colors.grey,
                                              Color.fromARGB(54, 147, 146, 146)
                                            ]
                                          : [
                                              const Color(0x36ffffff),
                                              const Color(0x0ffffff)
                                            ]),
                                  borderRadius: BorderRadius.circular(40)),
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                Icons.search,
                                color: isWhite ? Colors.black : Colors.white,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      )),
                  searchList(),
                ])),
          ]),
        ));
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return '$b\_$a';
  } else {
    return '$a\_$b';
  }
}
