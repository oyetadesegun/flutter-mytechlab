// ignore_for_file: must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';

class AllUsersScreen extends StatelessWidget {
  static const String id = 'WalletScreen';
  List<String> docIDs = [];

  AllUsersScreen({super.key});

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kAccent,
          title: const Text('View All Users'),
        ),
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
  const GetUserName({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('${data['profilePic']}'),
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['fullName'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(data['username'],
                            style: const TextStyle(
                              fontSize: 18,
                            ))
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.arrow_right)
              ],
            );
          }
          return const Text('loading..');
        });
  }
}
