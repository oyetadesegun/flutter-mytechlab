// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../components/bottom_nav.dart';

class WalletScreen extends StatelessWidget {
  static const String id = 'WalletScreen';
//documents IDs
  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Expanded(
                child: FutureBuilder(
      future: getDocId(),
      builder: (context, snapshot) {
        return ListView.builder(
            itemCount: docIDs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: GetUserName(documentId: docIDs[index]),
              );
            });
      },
    ))));
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;
  GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text('Full Name: ${data['full name']} ');
          }
          return Text('loading..');
        }));
  }
}
