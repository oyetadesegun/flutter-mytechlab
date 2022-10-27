// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'Search/profile_company.dart';

class AllWorkersWidget extends StatefulWidget {
  final String userID;
  final String userName;
  final String userEmail;
  final String phoneNumber;
  final String userImageUrl;
  AllWorkersWidget({
    Key? key,
    required this.userID,
    required this.userName,
    required this.userEmail,
    required this.phoneNumber,
    required this.userImageUrl,
  }) : super(key: key);

  @override
  State<AllWorkersWidget> createState() => _AllWorkersWidgetState();
}

class _AllWorkersWidgetState extends State<AllWorkersWidget> {
  void _mailTo() async {
    var mailUrl = 'mailto:${widget.userEmail}';
    if (await canLaunchUrlString(mailUrl)) {
      await launchUrlString(mailUrl);
    } else {
      print('error');
      throw 'Error occurred';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileCompanyScreen(
                        openDrawer: () {},
                        userID: widget.userID,
                      )));
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.only(right: 12),
          decoration:
              const BoxDecoration(border: Border(right: BorderSide(width: 1))),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            // ignore: prefer_if_null_operators, unnecessary_null_comparison
            backgroundImage: NetworkImage(widget.userImageUrl == null
                ? 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_960_720.png'
                : widget.userImageUrl),
          ),
        ),
        title: Text(
          widget.userName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold, color: kAccent),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Visit Profile',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
        trailing: IconButton(
            onPressed: () {
              _mailTo();
            },
            icon: const Icon(
              Icons.mail_outline,
              size: 30,
              color: Colors.grey,
            )),
      ),
    );
  }
}
