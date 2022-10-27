import 'package:flutter/material.dart';

import 'package:mytechlab/components/constants/constant.dart';

import '../../components/constants/colors.dart';
import '../../components/star_widget.dart';
import '../../data/job_data.dart';
import 'explore_components.dart';

class AddJobBottomTile extends StatelessWidget {
  Jobs job;
  AddJobBottomTile(this.job, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey,
        child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: ListView(children: [
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: Image.asset(
                        job.kImage,
                        height: 110,
                      )),
                ),
                SizedBox(height: 10),
                Text(
                  job.job,
                  style: kJobTitleBottomStyle,
                ),
                SizedBox(height: 5),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.contact_mail, color: kOwnerColor),
                  SizedBox(width: 10),
                  Text(job.jobOwner, style: kAuthorStyle),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Star(job),
                    Text(
                      '(${job.kstarRate.toDouble().toString()})',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Center(
                          child: Text(
                            'APPLY NOW',
                            style: kJobTitleBottomStyle,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.green),
                        )),
                    SizedBox(height: 20),
                    Divider(color: Colors.black, height: 10),
                    SizedBox(height: 20),
                    RowBottomJobApply(
                        Icons.calendar_month, 'Registered on:', '27, Jun 2018'),
                    SizedBox(height: 10),
                    RowBottomJobApply(
                        Icons.perm_identity, 'User Level:', 'User Level #1'),
                    SizedBox(height: 10),
                    RowBottomJobApply(Icons.near_me, 'From:', 'Lagos'),
                    SizedBox(height: 10),
                    RowBottomJobApply(
                        Icons.access_time_filled, 'Avg work Time:', 'Weekly'),
                    SizedBox(height: 20),
                    Divider(color: Colors.black, height: 10),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Lagos',
                            style: TextStyle(fontSize: 20),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ]),
            ])));
  }
}
