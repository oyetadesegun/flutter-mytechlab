import 'package:flutter/material.dart';
import 'package:mytechlab/components/job_tile.dart';

import '../../data/job_data.dart';
import 'explore_components.dart';

class ExploreJobList extends StatelessWidget {
  static const String id = 'ExploreJobList';
  final JobList = Jobs.generateJobs();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Heading(
            title: 'Recent Posted Jobs',
          ),
          // SizedBox(height: 30),
          Container(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: JobList.length,
              itemBuilder: ((context, index) => JobTile(JobList[index])),
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 5),
            ),
          )
        ],
      ),
    );
  }
}
