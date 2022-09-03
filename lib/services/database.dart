import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    QuerySnapshot usernameSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: [username]).get();
    return usernameSnapshot;
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

  // getUserByEmail(String email) async {
  //   return await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('email', isEqualTo: email)
  //       .get();
  // }

  // getUserByName(String fullname) async {
  //   return await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('full name', isEqualTo: fullname)
  //       .get();
  // }
}
//String emai,String fullname, String phone, String username 