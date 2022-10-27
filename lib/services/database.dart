import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
  }

  getUserByDocId(String docId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('docId', isEqualTo: docId)
        .get();
  }

  uploadUserInfo(userMap, String userId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserByEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
  }

  getUserByName(String fullname) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('fullName', isEqualTo: fullname)
        .get();
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: false)
        .snapshots();
  }

  getChatRooms(String userName) async {
    return await FirebaseFirestore.instance
        .collection('ChatRoom')
        .where('users', arrayContains: userName)
        .snapshots();
  }
}
