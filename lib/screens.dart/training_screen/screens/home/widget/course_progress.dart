import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/course_module.dart';

import '../../../models/module.dart';

class CourseProgress extends StatelessWidget {
  final moduleList = Module.generateModules();

  CourseProgress({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'The Progress',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                children: const [
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
          const SizedBox(height: 20),
          ...moduleList.map((e) => CourseModule(e))
        ],
      ),
    );
  }
}
