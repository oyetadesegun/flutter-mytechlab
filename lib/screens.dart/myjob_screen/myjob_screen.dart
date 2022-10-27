// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:mytechlab/screens.dart/drawer/Main_drawer_page.dart';
import 'package:mytechlab/screens.dart/myjob_screen/widget/Search/search_job.dart';

import 'package:mytechlab/screens.dart/myjob_screen/widget/bottom_nav_bar.dart';
import 'package:mytechlab/screens.dart/myjob_screen/widget/job_widget.dart';
import 'package:mytechlab/screens.dart/profile_screen/ButtonWidget.dart';

import '../../components/constants/colors.dart';
import 'Persistent/persistent.dart';

class MyJobScreen extends StatefulWidget {
  static const String id = 'MyJobScreen';

  final VoidCallback openDrawer;
  const MyJobScreen({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  State<MyJobScreen> createState() => _MyJobScreenState();
}

class _MyJobScreenState extends State<MyJobScreen> {
  String? jobCategoryFilter;

  void _showTaskCategoriesDialog({required Size size}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black54,
            title: const Text(
              'Job Category',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Persistent.jobCategoryList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          jobCategoryFilter = Persistent.jobCategoryList[index];
                        });
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null;
                      },
                      child: Row(children: [
                        const Icon(Icons.arrow_right_alt_outlined,
                            color: Colors.grey),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(Persistent.jobCategoryList[index],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              )),
                        )
                      ]),
                    );
                  }),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
              TextButton(
                onPressed: () {
                  setState(() {
                    jobCategoryFilter = null;
                  });
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text('Cancel Filter',
                    style: TextStyle(color: Colors.white)),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    Persistent persistentObject = Persistent();
    persistentObject.getMyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccent,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainDrawerPage()));
            },
            child: const Icon(Icons.menu)),
        title: const Text('Available Jobs'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _showTaskCategoriesDialog(size: MediaQuery.of(context).size);
              },
              icon: const Icon(Icons.filter_list_rounded)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchJobScreen(
                              openDrawer: widget.openDrawer,
                            )));
              },
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      bottomNavigationBar: BottomNavigationBarForApp(
        openDrawer: widget.openDrawer,
        indexNum: 0,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('jobs')
            .where('jobCategory', isEqualTo: jobCategoryFilter)
            .where('recruitment', isEqualTo: true)
            .orderBy('createdAt', descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: kAccent),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data?.docs.isNotEmpty == true) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return JobWidget(
                      jobTitle: snapshot.data!.docs[index]['jobTitle'],
                      jobDescription: snapshot.data!.docs[index]
                          ['jobDescription'],
                      jobId: snapshot.data!.docs[index]['jobId'],
                      uploadedBy: snapshot.data!.docs[index]['uploadedBy'],
                      userImage: snapshot.data!.docs[index]['userImage'],
                      name: snapshot.data!.docs[index]['name'],
                      recruitment: snapshot.data!.docs[index]['recruitment'],
                      email: snapshot.data!.docs[index]['email'],
                      location: snapshot.data!.docs[index]['location'],
                    );
                  });
            } else {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'There is no job in this Category',
                    style: TextStyle(fontSize: 20),
                  ),
                  ButtonWidget(
                    text: 'Click to Refresh',
                    onClicked: () {
                      setState(() {
                        jobCategoryFilter = null;
                      });
                    },
                  )
                ],
              ));
            }
          }
          return const Center(
              child: Text(
            'Something went wrong',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ));
        },
      ),
    );
  }
}
