import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/detail/widget/custom_app_bar.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/course_description.dart';

import '../../../models/course.dart';
import '../../home/widget/course_progress.dart';

class DetailPage extends StatelessWidget {
  final Course course;

  const DetailPage(this.course, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(course),
          CourseDescription(course),
          CourseProgress()
        ],
      ),
    ));
  }
}
