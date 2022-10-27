// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/screens.dart/myjob_screen/Persistent/persistent.dart';
import 'package:mytechlab/screens.dart/myjob_screen/widget/comments_widget.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/services/global_methods.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uuid/uuid.dart';

import '../../data/user_data.dart';
import '../signup&login_screen/services/global_variables.dart';

class JobDetailsScreen extends StatefulWidget {
  final String uploadedBy;
  final String jobId;
  const JobDetailsScreen({
    Key? key,
    required this.uploadedBy,
    required this.jobId,
  }) : super(key: key);
  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isCommenting = false;
  String? authorName;
  String? userImageUrl;
  String? jobCategory;
  String? jobDescription;
  String? jobTitle;
  bool? recruitment;
  Timestamp? postedDateTimeStamp;
  Timestamp? deadlineDateTimeStamp;
  String? postedDate;
  String? deadlineDate;
  String? locationCompany = '';
  String? emailCompany = '';
  int applicants = 0;
  bool isDeadlineAvailable = false;
  bool showComment = false;
  String? amount;
  final TextEditingController commentController = TextEditingController();

  void getJobdata() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uploadedBy)
        .get();
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        authorName = userDoc.get('fullName');
        userImageUrl = userDoc.get('profilePic');
      });
    }
    final DocumentSnapshot jobDatabase = await FirebaseFirestore.instance
        .collection('jobs')
        .doc(widget.jobId)
        .get();
    if (jobDatabase == null) {
      return;
    } else {
      setState(() {
        amount = jobDatabase.get('amount');
        jobTitle = jobDatabase.get('jobTitle');
        jobDescription = jobDatabase.get('jobDescription');
        jobCategory = jobDatabase.get('jobCategory');
        recruitment = jobDatabase.get('recruitment');
        emailCompany = jobDatabase.get('email');
        locationCompany = jobDatabase.get('location');
        applicants = jobDatabase.get('applicants');
        postedDateTimeStamp = jobDatabase.get('createdAt');
        deadlineDateTimeStamp = jobDatabase.get('deadlineDateTimeStamp');
        deadlineDate = jobDatabase.get('deadlineDate');
        var postDate = postedDateTimeStamp!.toDate();
        postedDate = '${postDate.day}/${postDate.month}/${postDate.year}';
      });
      var date = deadlineDateTimeStamp!.toDate();
      isDeadlineAvailable = date.isAfter(DateTime.now());
    }
  }

  @override
  void initState() {
    getJobdata();

    super.initState();
  }

  Widget dividerWidget() {
    return Column(
      children: const [
        SizedBox(height: 10),
        Divider(thickness: 1, color: Colors.grey),
        SizedBox(height: 10),
      ],
    );
  }

  applyForJob() {
    final Uri params = Uri(
      scheme: 'mailto',
      path: emailCompany,
      query: 'subject=Applying for $jobTitle&body=Hello,',
    );
    final url = params.toString();
    launchUrlString(url);
    addNewApplicant();
  }

  void addNewApplicant() async {
    var docRef =
        FirebaseFirestore.instance.collection('jobs').doc(widget.jobId);
    docRef.update({'applicants': applicants + 1});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Card(
                color: Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          jobTitle == null ? 'loading...' : jobTitle!,
                          maxLines: 3,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.grey,
                                  ),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        userImageUrl == null
                                            ? 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_960_720.png'
                                            : userImageUrl!,
                                      ),
                                      fit: BoxFit.fill))),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  authorName == null ? 'loading' : authorName!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  locationCompany == null
                                      ? ''
                                      : locationCompany!,
                                  style: const TextStyle(color: Colors.white70),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      dividerWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(applicants.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          const SizedBox(width: 6),
                          Text(
                            applicants == 0 ? 'Applicant' : 'Applicants',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.how_to_reg_sharp,
                              color: Colors.grey),
                        ],
                      ),
                      FirebaseAuth.instance.currentUser!.uid !=
                              widget.uploadedBy
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dividerWidget(),
                                const Text('Recruitment',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          User? user = _auth.currentUser;
                                          final _uid = user!.uid;
                                          if (_uid == widget.uploadedBy) {
                                            try {
                                              FirebaseFirestore.instance
                                                  .collection('jobs')
                                                  .doc(widget.jobId)
                                                  .update(
                                                      {'recruitment': true});
                                            } catch (error) {
                                              GlobalMethod.showErrorDialog(
                                                  error:
                                                      'Action cannot be performed',
                                                  ctx: context);
                                            }
                                          } else {
                                            GlobalMethod.showErrorDialog(
                                                error:
                                                    'You cannot perform this action',
                                                ctx: context);
                                          }
                                          getJobdata();
                                        },
                                        child: const Text(
                                          'ON',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Opacity(
                                      opacity: recruitment == true ? 1 : 0,
                                      child: const Icon(
                                        Icons.check_box,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(width: 40),
                                    TextButton(
                                        onPressed: () {
                                          User? user = _auth.currentUser;
                                          final _uid = user!.uid;
                                          if (_uid == widget.uploadedBy) {
                                            try {
                                              FirebaseFirestore.instance
                                                  .collection('jobs')
                                                  .doc(widget.jobId)
                                                  .update({
                                                'recruitment': false,
                                              });
                                            } catch (error) {
                                              GlobalMethod.showErrorDialog(
                                                  error:
                                                      'You can not perform this action',
                                                  ctx: context);
                                            }
                                          } else {
                                            GlobalMethod.showErrorDialog(
                                                error:
                                                    'You cannot perform this action',
                                                ctx: context);
                                          }
                                          getJobdata();
                                        },
                                        child: const Text(
                                          'OFF',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Opacity(
                                      opacity: recruitment == false ? 1 : 0,
                                      child: const Icon(
                                        Icons.check_box,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                      dividerWidget(),
                      const Text('Job Description',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(jobDescription == null ? 'loading' : jobDescription!,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14)),
                      dividerWidget()
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color: Colors.black54,
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Center(
                            child: Text(
                                isDeadlineAvailable
                                    ? 'Actively Recuiting, Click the button to Apply'
                                    : 'Deadline Passed',
                                style: TextStyle(
                                    color: isDeadlineAvailable
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
                        const SizedBox(height: 6),
                        Center(
                          child: MaterialButton(
                            onPressed: () {
                              applyForJob();
                            },
                            color: kAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Text('Apply Now',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                            ),
                          ),
                        ),
                        dividerWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Payment:',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            Text(amount == null ? '' : amount!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Uploaded on:',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            Text(postedDate == null ? '' : postedDate!,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Deadline date:',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            Text(deadlineDate == null ? '' : deadlineDate!,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                        ),
                        dividerWidget()
                      ],
                    )),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(4),
                child: Card(
                    color: Colors.black54,
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: _isCommenting
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              child: TextField(
                                                maxLines: 5,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    enabledBorder:
                                                        const UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .pink))),
                                                keyboardType:
                                                    TextInputType.text,
                                                maxLength: 500,
                                                controller: commentController,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Flexible(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8),
                                                    child: MaterialButton(
                                                      onPressed: () async {
                                                        if (commentController
                                                                .text.length <
                                                            7) {
                                                          GlobalMethod
                                                              .showErrorDialog(
                                                                  error:
                                                                      'Comment can not be less than 7',
                                                                  ctx: context);
                                                        } else {
                                                          final generatedId =
                                                              const Uuid().v4();
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'jobs')
                                                              .doc(widget.jobId)
                                                              .update({
                                                            'jobComments':
                                                                FieldValue
                                                                    .arrayUnion([
                                                              {
                                                                'userId':
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid,
                                                                'commentId':
                                                                    generatedId,
                                                                'name': name,
                                                                'userImageUrl':
                                                                    userImage,
                                                                'commentBody':
                                                                    commentController
                                                                        .text,
                                                                'time':
                                                                    Timestamp
                                                                        .now(),
                                                              }
                                                            ]),
                                                          });
                                                          await Fluttertoast.showToast(
                                                              msg:
                                                                  'Your comment has been added',
                                                              toastLength: Toast
                                                                  .LENGTH_LONG,
                                                              backgroundColor:
                                                                  Colors.grey,
                                                              fontSize: 18);
                                                          commentController
                                                              .clear();
                                                        }
                                                        setState(() {
                                                          showComment = true;
                                                        });
                                                      },
                                                      color: kAccent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: const Text('Post',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16)),
                                                    ),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _isCommenting =
                                                              !_isCommenting;
                                                          showComment = false;
                                                        });
                                                      },
                                                      child:
                                                          const Text('Cancel'))
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _isCommenting =
                                                        !_isCommenting;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.add_comment,
                                                  color: kAccent,
                                                  size: 40,
                                                )),
                                            const SizedBox(width: 10),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    showComment = true;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.arrow_drop_down_circle,
                                                  color: kAccent,
                                                  size: 40,
                                                )),
                                          ],
                                        )),
                              showComment == false
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: FutureBuilder<DocumentSnapshot>(
                                          future: FirebaseFirestore.instance
                                              .collection('jobs')
                                              .doc(widget.jobId)
                                              .get(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: kAccent),
                                              );
                                            } else {
                                              if (snapshot.hasData == null) {
                                                return const Center(
                                                    child: Text(
                                                        'Be the first to leave a Comment'));
                                              }
                                            }
                                            return ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return CommentWidget(
                                                    commentId: snapshot.data![
                                                            'jobComments']
                                                        [index]['commentId'],
                                                    commenterId: snapshot.data![
                                                            'jobComments']
                                                        [index]['userId'],
                                                    commenterName:
                                                        snapshot.data![
                                                                'jobComments']
                                                            [index]['name'],
                                                    commentBody: snapshot.data![
                                                            'jobComments']
                                                        [index]['commentBody'],
                                                    commenterImageUrl: snapshot
                                                                .data![
                                                            'jobComments']
                                                        [index]['userImageUrl'],
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return Divider(
                                                      thickness: 1,
                                                      color: Colors.grey);
                                                },
                                                itemCount: snapshot
                                                    .data!['jobComments']
                                                    .length);
                                          }),
                                    ),
                            ]))))
          ],
        ),
      ),
    );
  }
}
