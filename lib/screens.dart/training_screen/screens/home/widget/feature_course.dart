import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/training_screen/models/course.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/course_item.dart';

import 'category_title.dart';

class FeatureCourse extends StatelessWidget {
  final coursesList = Course.generateCourse();

  FeatureCourse({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CategoryTitle('Top of the Week', 'view all'),
          Container(
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: coursesList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => CourseItem(coursesList[index]),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: 15),
            ),
          )
        ],
      ),
    );
  }
}
