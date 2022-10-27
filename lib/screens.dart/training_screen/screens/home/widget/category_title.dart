import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';

import '../../../../../main.dart';

class CategoryTitle extends StatelessWidget {
  final String leftText;
  final String rightText;

  const CategoryTitle(this.leftText, this.rightText, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isWhite ? kFont : Colors.white,
            ),
          ),
          Text(
            rightText,
            style: const TextStyle(fontSize: 16, color: kFontLight),
          ),
        ],
      ),
    );
  }
}
