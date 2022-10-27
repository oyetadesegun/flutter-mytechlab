// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mytechlab/components/constants/colors.dart';

import 'Search/profile_company.dart';

class CommentWidget extends StatefulWidget {
  final String commentId;
  final String commenterId;
  final String commenterName;
  final String commentBody;
  final String commenterImageUrl;

  CommentWidget({
    Key? key,
    required this.commentId,
    required this.commenterId,
    required this.commenterName,
    required this.commentBody,
    required this.commenterImageUrl,
  }) : super(key: key);
  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  List<Color> colors = [
    Colors.amber,
    Colors.orange,
    Colors.pink.shade200,
    kAccent,
    Colors.brown,
    Colors.cyan,
    Colors.blueAccent,
    Colors.deepOrange
  ];

  @override
  Widget build(BuildContext context) {
    colors.shuffle();
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileCompanyScreen(
                        openDrawer: () {},
                        userID: widget.commenterId,
                      )));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: colors[1]),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(widget.commenterImageUrl),
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.commenterName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white)),
                    Text(
                      widget.commentBody,
                      maxLines: 5,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                          color: Colors.grey),
                    )
                  ],
                ))
          ],
        ));
  }
}
