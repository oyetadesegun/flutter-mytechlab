import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';

import '../../../../../main.dart';

class EmojiText extends StatelessWidget {
  const EmojiText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      child: RichText(
          text: TextSpan(
        children: [
          TextSpan(
              text: 'Let\s boost your\nbrain power',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: isWhite ? Colors.black : Colors.white)),
          const TextSpan(text: '✨', style: TextStyle(fontSize: 26))
        ],
      )),
    );
  }
}
