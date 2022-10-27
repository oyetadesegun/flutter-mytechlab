import 'package:flutter/material.dart';
import 'package:mytechlab/components/job_tile.dart';

import '../../data/job_data.dart';
import 'explore_components.dart';

class ExploreJobList extends StatelessWidget {
  static const String id = 'ExploreJobList';
  final jobList = Jobs.generateJobs();

  ExploreJobList({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Heading(
            title: 'Recent Posted Jobs',
          ),
          Container(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: jobList.length,
              itemBuilder: (context, index) => JobTile(jobList[index]),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 5),
            ),
          )
        ],
      ),
    );
  }
}
