import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({super.key, required this.text, required this.onClicked});
  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onClicked,
        child: Text(text),
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            foregroundColor: Colors.white,
            backgroundColor: kAccent,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
      );
}
