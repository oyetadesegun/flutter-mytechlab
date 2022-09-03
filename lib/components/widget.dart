import 'package:flutter/material.dart';

import 'constants/colors.dart';

InputDecoration inputForm(String hintText, IconData icon) {
  return InputDecoration(
    icon: Icon(
      icon,
      color: kAccent,
    ),
    hintText: hintText,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
  );
}
