// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mytechlab/screens.dart/course/widget/course_widget.dart';
import '../../components/constants/colors.dart';
import '../../data/user_data.dart';
import '../../main.dart';
import '../drawer/drawer_menu_widget.dart';

class MainCourse extends StatefulWidget {
  final VoidCallback openDrawer;

  const MainCourse({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  State<MainCourse> createState() => _MainCourseState();
}

class _MainCourseState extends State<MainCourse> {
  //final List<String> courseIDs = [];
  String? courseImage;
  Object? courseId;
  QuerySnapshot? courses;
  Future getCourses() async {
    courses = await FirebaseFirestore.instance.collection('courses').get();
    courseId = courses!.docs;
  }

  @override
  void initState() {
    getCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchCourseController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: isWhite ? kBackground : Colors.black,
          leading: DrawerMenuWidget(onClicked: widget.openDrawer),
          elevation: 0,
          centerTitle: false,
          actions: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(top: 15, right: 20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(Constants.myProfilePic))),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey ${Constants.myName},',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'What would you like to learn today',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(40)),
                    child: TextField(
                      controller: searchCourseController,
                      autocorrect: true,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'Search what would like to learn...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          )),
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Category',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Spacer(),
                      Text('See All',
                          style: TextStyle(color: Colors.grey, fontSize: 18)),
                      SizedBox(height: 30),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: getCourses(),
                        builder: (context, snapshot) {
                          return MasonryGridView.count(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount: courses!.docs.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            itemBuilder: (context, index) {
                              return CourseWidget(
                                courseId: courses!.docs[index]['courseId'],
                                courseImage: courses!.docs[index]
                                    ['courseImage'],
                                courseTitle: courses!.docs[index]
                                    ['courseTitle'],
                                videos: courses!.docs[index]['videos'],
                                height: index.isEven ? 200 : 240,
                                students: courses!.docs[index]['students'],
                                rating: courses!.docs[index]['rating'],
                                discount: courses!.docs[index]['discount'],
                                price: courses!.docs[index]['price'],
                              );
                            },
                          );
                        }),
                  ),
                ])));
  }
}
