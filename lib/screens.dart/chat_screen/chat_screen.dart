import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/screens.dart/chat_screen/all_users.dart';
import 'package:mytechlab/screens.dart/chat_screen/conversation_screen.dart';
import 'package:mytechlab/screens.dart/chat_screen/search.dart';
import 'package:mytechlab/services/auth.dart';
import 'package:mytechlab/services/database.dart';
import 'package:mytechlab/services/helper_functions.dart';

import '../../data/user_data.dart';
import '../../main.dart';
import '../drawer/drawer_menu_widget.dart';

class ChatRoom extends StatefulWidget {
  static const String id = 'ChatScreen';
  final VoidCallback openDrawer;

  const ChatRoom({Key? key, required this.openDrawer}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  AuthMethod authMethod = AuthMethod();
  Future<DocumentSnapshot<Map<String, dynamic>>>? chatUser;

  Stream? chatRoomStream;
  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    chatUser = FirebaseFirestore.instance
                        .collection('users')
                        .doc(snapshot.data!.docs[index]['chatroomId']
                            .toString()
                            .replaceAll('_', '')
                            .replaceAll(Constants.uid, ''))
                        .get();

                    return ChatRoomTile(
                      userName: snapshot.data!.docs[index]['chatroomId']
                          .toString()
                          .replaceAll('_', '')
                          .replaceAll(Constants.uid, ''),
                      chatRoomId: snapshot.data!.docs[index]['chatroomId'],
                      profilePic: 'profilePic',
                      chatUserId: snapshot.data!.docs[index]['chatroomId']
                          .toString()
                          .replaceAll('_', '')
                          .replaceAll(Constants.uid, ''),
                    );
                  })
              : const Center(
                  child: Text(
                  'No Chat yet\n Click the Search Icon to begin',
                  textAlign: TextAlign.center,
                ));
        });
  }

  @override
  void initState() {
    getUserInfo();
    Constants.uid = FirebaseAuth.instance.currentUser!.uid;

    super.initState();
  }

  getUserInfo() async {
    Constants.myUserName != await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getChatRooms(Constants.uid).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isWhite ? Colors.white : Colors.black,
      appBar: AppBar(
        leading: DrawerMenuWidget(onClicked: widget.openDrawer),
        backgroundColor: kAccent,
        title: const Text('Recent Chats'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AllUsersScreen()));
            },
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: const Text('View All')),
          ),
          GestureDetector(
            onTap: () {
              authMethod.signOut();
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.exit_to_app)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kAccent,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SearchScreen()));
        },
        child: const Icon(Icons.search),
      ),
      body: chatRoomList(),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatUserId;
  final String chatRoomId;
  final String profilePic;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ChatRoomTile(
      {required this.userName,
      required this.chatRoomId,
      required this.profilePic,
      required this.chatUserId});
  @override
  Widget build(BuildContext context) {
    // getUserChat() async {
    //   DocumentSnapshot userChat = await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(userName)
    //       .get();
    //   return userChat;
    //}

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: kAccent, borderRadius: BorderRadius.circular(40)),
            child: Text(
              userName.substring(0, 1).toUpperCase(),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ConversationScreen(
                  chatRoomId: chatRoomId,
                  profilePic: userName.substring(0, 1).toUpperCase(),
                  chatUserName: userName,
                  chatUserId: Constants.chatUserId,
                );
              }));
            },
            child: Text(
              userName,
            ),
          ),
        ],
      ),
    );
  }
}
