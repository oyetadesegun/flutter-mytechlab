import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/course_module.dart';

import '../../../models/module.dart';

class CourseProgress extends StatelessWidget {
  final moduleList = Module.generateModules();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'The Progress',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                children: [
                  Icon(
                    Icons.grid_view,
                    size: 25,
                  ),
                  SizedBox(width: 15),
                  Icon(Icons.list, size: 25),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          ...moduleList.map((e) => CourseModule(e))
        ],
      ),
    );
  }
}
