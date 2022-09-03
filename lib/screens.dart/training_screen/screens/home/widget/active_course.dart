import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/training_screen/screens/home/widget/category_title.dart';

import '../../../../../components/constants/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../main.dart';

class ActiveCourse extends StatelessWidget {
  int value = 61;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        CategoryTitle('Currently active', 'view all'),
        Container(
          margin: EdgeInsets.all(25),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: kFontLight.withOpacity(0.1),
              border: Border.all(
                color: kFontLight.withOpacity(0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset('images/nicole-2.jpg', width: 60)),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Symetry theory',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isWhite ? kFont : Colors.white)),
                      Text(
                        '2 lessons left',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kFontLight),
                      )
                    ],
                  )
                ],
              ),
              CircularPercentIndicator(
                radius: 50,
                lineWidth: 5,
                percent: value / 100,
                center: Text(
                  '$value%',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isWhite ? Colors.black : Colors.white),
                ),
                progressColor: kAccent,
              )
            ],
          ),
        ),
      ],
    ));
  }
}
