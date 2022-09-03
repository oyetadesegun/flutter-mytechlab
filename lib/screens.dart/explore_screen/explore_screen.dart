// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mytechlab/main.dart';
import 'package:mytechlab/screens.dart/explore_screen/explore_joblist.dart';

import '../../components/job_tile.dart';
import '../../data/job_data.dart';
import 'explore_components.dart';

class ExploreScreen extends StatelessWidget {
  final moduleList = Jobs.generateJobs();
  static const String id = 'ExploreScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isWhite ? Colors.white : Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              backgroundColor: Colors.green,
              title: TitleSection(),
              pinned: true,
              expandedHeight: 240,
              flexibleSpace: FlexibleSpaceBar(
                background: FlexibleSection(),
              )),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Heading(title: 'Latest Available Jobs'),
              ...moduleList.map((e) => JobTile(e))
            ]),
          )
        ],
      ),
    );
  }
}
