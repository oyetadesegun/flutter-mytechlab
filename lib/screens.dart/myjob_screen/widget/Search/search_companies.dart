// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/myjob_screen/myjob_screen.dart';
import 'package:mytechlab/screens.dart/myjob_screen/widget/all_company_widget.dart';
import 'package:mytechlab/screens.dart/myjob_screen/widget/bottom_nav_bar.dart';

import '../../../../components/constants/colors.dart';

class AllWorkersScreen extends StatefulWidget {
  final VoidCallback openDrawer;
  AllWorkersScreen({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  State<AllWorkersScreen> createState() => _AllWorkersScreenState();
}

class _AllWorkersScreenState extends State<AllWorkersScreen> {
  _AllWorkersScreenState();
  String searchQuery = 'Search query';
  final TextEditingController _searchQueryController = TextEditingController();
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autocorrect: true,
      decoration: const InputDecoration(
          hintText: 'Search for Companies...',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.white,
          )),
      style: const TextStyle(color: Colors.white, fontSize: 16),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _clearSearchQuery();
          })
    ];
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery('');
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery.toUpperCase();
      print(searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccent,
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
            child: const Icon(Icons.arrow_back_ios)),
        title: _buildSearchField(),
        actions: _buildActions(),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBarForApp(
        indexNum: 1,
        openDrawer: widget.openDrawer,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('fullName', isGreaterThanOrEqualTo: searchQuery)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: kAccent),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return AllWorkersWidget(
                          userID: snapshot.data!.docs[index]['docId'],
                          userName: snapshot.data!.docs[index]['username'],
                          userEmail: snapshot.data!.docs[index]['email'],
                          phoneNumber: snapshot.data!.docs[index]['phone'],
                          userImageUrl: snapshot.data!.docs[index]
                              ['profilePic']);
                    });
              } else {
                return const Center(
                    child: Text('There is no user bearing this name'));
              }
            }
            return const Center(
              child: Text('Something went wrong',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            );
          }),
    );
  }
}
