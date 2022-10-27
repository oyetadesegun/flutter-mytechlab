// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, non_constant_identifier_names
import 'package:flutter/material.dart';

import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/services/database.dart';

import '../../data/user_data.dart';
import '../../main.dart';

class ConversationScreen extends StatefulWidget {
  String chatRoomId;
  String profilePic;
  String chatUserName;
  String chatUserId;
  ConversationScreen({
    Key? key,
    required this.chatRoomId,
    required this.profilePic,
    required this.chatUserName,
    required this.chatUserId,
  }) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageController = TextEditingController();
  Stream? chatMessagesStream;
  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  Widget ChatMessageList() {
    return StreamBuilder(
        stream: chatMessagesStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MessageTile(
                        snapshot.data!.docs[index]['message'],
                        snapshot.data!.docs[index]['sendBy'] ==
                            Constants.myUserName);
                  })
              : Container();
        });
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': messageController.text.trim(),
        'sendBy': Constants.myUserName,
        'time': DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccent,
        leading: Container(
          padding: const EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.profilePic),
          ),
        ),
        title: Text(widget.chatUserName),
        centerTitle: true,
      ),
      body: Container(
        color: isWhite ? const Color(0xffECE5DD) : Colors.black,
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                  color: isWhite
                      ? Colors.grey[100]
                      : const Color.fromARGB(255, 2, 53, 3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          style: TextStyle(
                              fontSize: 20,
                              color: isWhite ? Colors.black : Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Message...',
                              hintStyle: TextStyle(
                                color: isWhite ? Colors.grey : Colors.white54,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          sendMessage();
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: isWhite
                                        ? [
                                            Colors.grey,
                                            const Color.fromARGB(
                                                54, 147, 146, 146)
                                          ]
                                        : [
                                            const Color(0x36ffffff),
                                            const Color(0x0fffffff)
                                          ]),
                                borderRadius: BorderRadius.circular(40)),
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              'images/send.png',
                              color: isWhite ? Colors.black : Colors.white,
                            )),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  const MessageTile(this.message, this.isSendByMe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
              gradient: isWhite
                  ? LinearGradient(
                      colors: isSendByMe
                          ? [const Color(0xffDCF8C6), const Color(0xffDCF8C6)]
                          : [Colors.white, Colors.white])
                  : LinearGradient(
                      colors: isSendByMe
                          ? [kAccent, kAccent]
                          : [const Color(0x1affffff), const Color(0x1affffff)]),
              borderRadius: isSendByMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23))
                  : const BorderRadius.only(
                      topRight: Radius.circular(23),
                      topLeft: Radius.circular(23),
                      bottomRight: Radius.circular(23),
                    )),
          child: Text(
            message,
            style: TextStyle(
                color: isWhite ? Colors.black : Colors.white, fontSize: 17),
          )),
    );
  }
}
