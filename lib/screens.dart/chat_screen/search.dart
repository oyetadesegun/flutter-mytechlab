// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/services/database.dart';

import '../../main.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //   initiateSearch();
  }

  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();
  QuerySnapshot? searchSnapshot;
  initiateSearch() async {
    await databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

// createChatRoomandStartConversation(String userName){
//   List<String> users= [userName,my];
// databaseMethods.createChatRoom(chatRoomId, chatRoomMap)
// }
  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot?.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Map<String, dynamic> search =
                  searchSnapshot?.docs[index].data()! as Map<String, dynamic>;
              print(search);
              print(search['full name']);
              return SearchTile(
                searchSnapshot?.docs[index].data['full name'],
                userName: search['username'],
              );
            })
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isWhite ? Colors.white : Colors.black,
      appBar: AppBar(
        title: Text('Chat Room'),
        centerTitle: true,
        backgroundColor: kAccent,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: isWhite ? Colors.grey[100] : Color(0x54ffffff),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      style: TextStyle(
                          fontSize: 20,
                          color: isWhite ? Colors.black : Colors.white),
                      decoration: InputDecoration(
                          hintText: 'search username...',
                          hintStyle: TextStyle(
                            color: isWhite ? Colors.grey : Colors.white54,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: initiateSearch(),
                    //searchlist
                    //print(search['full name']);

                    // databaseMethods
                    //     .getUserByUsername(searchTextEditingController.text)
                    //     .then((value) {
                    //   searchSnapshot = value;
                    //   print('initiate snapshot $searchSnapshot');
                    //   print(searchSnapshot?.docs);
                    //   Map<String, dynamic> search = searchSnapshot?.docs[0]
                    //       .data() as Map<String, dynamic>;
                    //   print(search['full name']);
                    // });
                    //initiateSearch;

                    //  print(initiateSearch());

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
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String userFullName;
  const SearchTile({
    Key? key,
    required this.userName,
    required this.userFullName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userFullName,
                style: TextStyle(
                    color: isWhite ? Colors.black : Colors.white, fontSize: 20),
              ),
              Text(
                userName,
                style: TextStyle(color: isWhite ? Colors.black : Colors.white),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                'Message',
                style: TextStyle(
                    color: isWhite ? Colors.white : Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
