// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mytechlab/components/constants/constant.dart';
import 'package:mytechlab/screens.dart/course/details_screen.dart';

class CourseWidget extends StatefulWidget {
  final String courseId;
  final String courseImage;
  final String courseTitle;
  final Map<String, dynamic> videos;
  final double height;
  final int students;
  final num rating;
  final num discount;
  final num price;

  const CourseWidget({
    Key? key,
    required this.courseId,
    required this.courseImage,
    required this.courseTitle,
    required this.videos,
    required this.height,
    required this.students,
    required this.rating,
    required this.discount,
    required this.price,
  }) : super(key: key);

  @override
  State<CourseWidget> createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(
                      courseImage: widget.courseImage,
                      courseId: widget.courseId,
                      courseTitle: widget.courseTitle,
                      videos: widget.videos,
                      students: widget.students,
                      rating: widget.rating,
                      discount: widget.discount,
                      price: widget.price,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        height: widget.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(widget.courseImage //
                    )),
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.courseTitle,
                    style: kTitleTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    "${widget.videos.length.toString()} Courses",
                    style: TextStyle(color: kTextColor.withOpacity(.5)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
