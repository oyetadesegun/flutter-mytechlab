// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Jobs {
  String workTime;
  String level;
  String date;
  String job;
  Color kColor;
  String kImage;
  int kstarRate;
  String kjobLocation;
  String kPrices;
  String jobOwner;
  String jobDescription;
  Jobs(
    this.workTime,
    this.level,
    this.date,
    this.job,
    this.kColor,
    this.kImage,
    this.kstarRate,
    this.kjobLocation,
    this.kPrices,
    this.jobOwner,
    this.jobDescription,
  );
  static List<Jobs> generateJobs() {
    return [
      Jobs(
          'Weekly',
          'User Level #1',
          '27, Jun 2018',
          'Copywriting',
          Colors.red,
          'images/copywriter.png',
          5,
          'Lagos',
          '\$30',
          'Oyetade Segun',
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
      Jobs(
        '3 months',
        'User Level #2',
        r'06, Aug 2018',
        'Graphics Designing',
        Colors.green,
        'images/graphics.png',
        3,
        'Lekki',
        '\$20',
        'MyTechLab',
        'It is a far establishing fact that a reader will be distracted by the readable content of a page when looking at its layout.',
      ),
      Jobs(
        '1 month',
        'User Level #3',
        '19, Jan 2018',
        r'UX/UI Expert',
        Colors.blue,
        'images/uiux.jpg',
        4,
        'Agege',
        '\$29',
        'Sir. John',
        'lorem ipsum is a dummy text,lorem ipsum is a dummy text,lorem ipsum is a dummy text,lorem ipsum is a dummy text,lorem ipsum is a dummy text,',
      ),
      Jobs(
        'two times/week',
        'User Level #1',
        '10, Jun 2018',
        'Programming',
        Colors.orange,
        'images/programmer.png',
        3,
        'Ikorodu',
        '\$15',
        'John Doe',
        'Test the tester to know if the tester an be tested by the tested',
      ),
      Jobs(
        'monthly',
        'User Level #1',
        '08, Jul 2020',
        'Marketing',
        Colors.black,
        'images/marketer.png',
        4,
        'Epe',
        '\$19',
        'Johnny Cage',
        'monthly',
      ),
    ];
  }
}
