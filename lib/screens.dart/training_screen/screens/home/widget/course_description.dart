// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';

import '../../../models/course.dart';

class CourseDescription extends StatelessWidget {
  final Course course;
  CourseDescription(
    this.course,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  course.authorImg,
                  width: 20,
                ),
              ),
              SizedBox(width: 5),
              Text(
                course.author,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  color: kFontLight,
                  shape: BoxShape.circle,
                ),
              ),
              Icon(Icons.access_time_filled, size: 20, color: kAccent),
              SizedBox(width: 5),
              Text('1h 35 min',
                  style: TextStyle(
                      color: kFont, fontSize: 16, fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(height: 15),
          Text(
            course.title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: kFont),
          ),
          SizedBox(height: 15),
          Text(
            'How we developed speech and it became such a powerful book became such a powerful book',
            style: TextStyle(wordSpacing: 2, fontSize: 16, color: kFontLight),
          )
        ],
      ),
    );
  }
}
