import 'package:flutter/material.dart';

class Category {
  final String name;
  final int numOfCourses;
  final String image;

  Category(this.name, this.numOfCourses, this.image);
}

List categories = categoriesData
    .map((item) => Category(item['name'], item['courses'], item['image']))
    .toList();
dynamic categoriesData = [
  {'name': 'Marketing', 'courses': 17, 'image': 'images/marketer.png'},
  {'name': 'Graphic design', 'courses': 10, 'image': 'images/copywriter.png'},
  {'name': 'Marketing', 'courses': 17, 'image': 'images/graphics.png'},
  {'name': 'Marketing', 'courses': 17, 'image': 'images/programmer.png'},
  {'name': 'Marketing', 'courses': 17, 'image': 'images/uiux.jpg'},
  {'name': 'Marketing', 'courses': 17, 'image': 'images/uiux.jpg'},
  {'name': 'Marketing', 'courses': 17, 'image': 'images/uiux.jpg'}
];
