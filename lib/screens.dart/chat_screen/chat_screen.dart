import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/screens.dart/chat_screen/search.dart';
import 'package:mytechlab/services/auth.dart';

import '../../main.dart';

class ChatRoom extends StatefulWidget {
  static const String id = 'ChatScreen';
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    AuthMethod authMethod = AuthMethod();
    return Scaffold(
      backgroundColor: isWhite ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: kAccent,
        title: const Text('Chat Room'),
        centerTitle: true,
        actions: [
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        child: const Icon(Icons.search),
      ),
      body: const Center(
        child: Text(
          'rrr',
        ),
      ),
    );
  }
}
