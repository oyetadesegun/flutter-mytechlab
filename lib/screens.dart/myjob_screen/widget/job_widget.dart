// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/screens.dart/myjob_screen/job_details.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/services/global_methods.dart';

class JobWidget extends StatefulWidget {
  final String jobTitle;
  final String jobDescription;
  final String jobId;
  final String uploadedBy;
  final String userImage;
  final String name;
  final bool recruitment;
  final String email;
  final String location;
  const JobWidget({
    Key? key,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobId,
    required this.uploadedBy,
    required this.userImage,
    required this.name,
    required this.recruitment,
    required this.email,
    required this.location,
  }) : super(key: key);
  @override
  State<JobWidget> createState() => _JobWidgetState();
}

class _JobWidgetState extends State<JobWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _deleteDialog() {
    User? user = _auth.currentUser;
    final uid = user!.uid;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () async {
                    try {
                      if (widget.uploadedBy == uid) {
                        await FirebaseFirestore.instance
                            .collection('jobs')
                            .doc(widget.jobId)
                            .delete();
                        await Fluttertoast.showToast(
                            msg: 'Task has been deleted',
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: Colors.grey,
                            fontSize: 18);
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null;
                      } else {
                        GlobalMethod.showErrorDialog(
                            error: 'You cannot perfrom this action',
                            ctx: (context));
                      }
                    } catch (error) {
                      GlobalMethod.showErrorDialog(
                          error: 'This task cannot be deleted', ctx: (context));
                    } finally {}
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JobDetailsScreen(
                        uploadedBy: widget.uploadedBy,
                        jobId: widget.jobId,
                      )));
        },
        onLongPress: _deleteDialog,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.only(right: 12),
          decoration:
              const BoxDecoration(border: Border(right: BorderSide(width: 1))),
          child: CircleAvatar(backgroundImage: NetworkImage(widget.userImage)),
        ),
        title: Text(
          widget.jobTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: kAccent, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
            const SizedBox(height: 8),
            Text(
              widget.jobDescription,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
