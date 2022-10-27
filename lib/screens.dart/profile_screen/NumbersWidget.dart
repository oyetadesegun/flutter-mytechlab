import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(context, '4.8', 'Ranking'),
            buildDivider(),
            buildButton(context, '35', 'Following'),
            buildDivider(),
            buildButton(context, '50', 'Followers')
          ],
        ),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(value,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            SizedBox(height: 2),
            Text(text, style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
      );

  Widget buildDivider() => Container(
      height: 24, child: VerticalDivider(color: kAccent, thickness: 1));
}
