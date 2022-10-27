import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/myjob_screen/widget/job_widget.dart';

import '../../../../components/constants/colors.dart';
import '../../myjob_screen.dart';

class SearchJobScreen extends StatefulWidget {
  final VoidCallback openDrawer;
  const SearchJobScreen({Key? key, required this.openDrawer}) : super(key: key);

  @override
  State<SearchJobScreen> createState() => _SearchJobScreenState();
}

class _SearchJobScreenState extends State<SearchJobScreen> {
  final TextEditingController _searchQueryController = TextEditingController();
  String searchQuery = 'Search query';
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autocorrect: true,
      decoration: const InputDecoration(
          hintText: 'Search for jobs...',
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
      searchQuery = newQuery.toString();
      print(searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kAccent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
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
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: _buildSearchField(),
        actions: _buildActions(),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('jobs')
            .where('jobTitle', isGreaterThanOrEqualTo: searchQuery)
            .where('recruitment', isEqualTo: true)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: kAccent,
            ));
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data?.docs.isNotEmpty == true) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return JobWidget(
                        jobTitle: snapshot.data?.docs[index]['jobTitle'],
                        jobDescription: snapshot.data?.docs[index]
                            ['jobDescription'],
                        jobId: snapshot.data?.docs[index]['jobId'],
                        uploadedBy: snapshot.data?.docs[index]['uploadedBy'],
                        userImage: snapshot.data?.docs[index]['userImage'],
                        name: snapshot.data?.docs[index]['name'],
                        recruitment: snapshot.data?.docs[index]['recruitment'],
                        email: snapshot.data?.docs[index]['email'],
                        location: snapshot.data?.docs[index]['location']);
                  });
            }
          } else {
            return Center(
                child: Text(
                    'There is no job currently starting with $searchQuery'));
          }
          return const Center(
            child: Text('Something went wrong',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          );
        },
      ),
    );
  }
}
