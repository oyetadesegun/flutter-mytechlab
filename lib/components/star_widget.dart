// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/job_data.dart';

class StarDisplayWidget extends StatelessWidget {
  final int value;
  final Widget filledStar;
  final Widget unfilledStar;
  const StarDisplayWidget({
    this.value = 0,
    required this.filledStar,
    required this.unfilledStar,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return index < value ? filledStar : unfilledStar;
      }),
    );
  }
}

class StarDisplay extends StarDisplayWidget {
  const StarDisplay({int value = 0})
      : super(
          value: value,
          filledStar: const Icon(Icons.star),
          unfilledStar: const Icon(Icons.star_border),
        );
}

class Star extends StatelessWidget {
  final Jobs job;
  const Star(
    this.job,
  );
  @override
  Widget build(BuildContext context) {
    return StarDisplayWidget(
      value: job.kstarRate,
      filledStar: Icon(Icons.star, color: Colors.orange, size: 32),
      unfilledStar: Icon(Icons.star_border, color: Colors.grey),
    );
  }
}
