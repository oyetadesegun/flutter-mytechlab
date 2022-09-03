// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mytechlab/components/constants/constant.dart';
import 'package:mytechlab/components/star_widget.dart';
import 'package:mytechlab/data/job_data.dart';

import '../main.dart';
import '../screens.dart/explore_screen/job_info_bottom_tile.dart';

class JobTile extends StatelessWidget {
  final Jobs job;
  JobTile(
    this.job,
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            //  isScrollControlled: true,
            context: context,
            builder: (context) => AddJobBottomTile(job));
      },
      child: Expanded(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isWhite ? Colors.grey[100] : Colors.grey[400],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(2, 8), // Shadow position
                  ),
                ],
              ),
              height: 120,
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(job.kImage)),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.job,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: kJobTitleStyle,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: isWhite ? Colors.grey : Colors.black,
                          ),
                          Text(job.kjobLocation,
                              style: TextStyle(
                                color: isWhite ? Colors.grey : Colors.black,
                              )),
                        ],
                      ),
                      Star(job)
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.bookmark,
                          size: 30,
                          color: job.kColor,
                        ),
                        Text(
                          job.kPrices,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
