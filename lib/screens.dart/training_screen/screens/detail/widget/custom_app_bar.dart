// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/main.dart';

import '../../../models/course.dart';

class CustomAppBar extends StatelessWidget {
  final Course course;
  const CustomAppBar(this.course);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: isWhite ? Colors.white : Colors.black,
        body: Container(
            child: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  height: 400,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(course.imageUrl, fit: BoxFit.fitHeight),
                  ),
                ),
                Container(height: 20)
              ],
            ),
            Positioned(
              bottom: 0,
              right: 40,
              child: Container(
                height: 50,
                width: 110,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {},
                  child: Text('Start Class'),
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 25,
                child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        // size: 20,
                      ),
                      iconSize: 20,
                      onPressed: () => Navigator.pop(context)),
                )),
            Positioned(
                top: MediaQuery.of(context).padding.top,
                right: 25,
                child: Container(
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.white,
                        // size: 20,
                      ),
                      iconSize: 20,
                      onPressed: () {},
                    ))),
          ],
        )),
      ),
    );
  }
}
