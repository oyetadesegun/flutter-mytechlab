// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytechlab/screens.dart/myjob_screen/Persistent/persistent.dart';

import 'package:mytechlab/screens.dart/myjob_screen/myjob_screen.dart';
import 'package:mytechlab/screens.dart/myjob_screen/widget/bottom_nav_bar.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/services/global_methods.dart';
import 'package:uuid/uuid.dart';

import '../../components/constants/colors.dart';
import '../../data/user_data.dart';
import '../signup&login_screen/services/global_variables.dart';

class UploadJobNow extends StatefulWidget {
  final VoidCallback openDrawer;
  const UploadJobNow({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  State<UploadJobNow> createState() => _UploadJobNowState();
}

class _UploadJobNowState extends State<UploadJobNow> {
  final TextEditingController _jobCategoryController =
      TextEditingController(text: 'Select Job Category');
  final TextEditingController _jobTitlecontroller = TextEditingController();
  final TextEditingController _jobDescriptioncontroller =
      TextEditingController();
  final TextEditingController _jobLocationcontroller = TextEditingController();
  final TextEditingController _deadlineDatecontroller =
      TextEditingController(text: 'Select Deadline Date');
  final TextEditingController _currencyController =
      TextEditingController(text: 'Pick a Currency');
  final TextEditingController _rateController =
      TextEditingController(text: 'Pick a rate');
  final TextEditingController _figureController =
      TextEditingController(text: '0.00');

  final _formKey = GlobalKey<FormState>();
  DateTime? picked;
  Timestamp? deadlineDateTimeStamp;
  bool _isLoading = false;

  Widget _textTitles({required String label}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(label,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  @override
  void dispose() {
    _jobCategoryController.dispose();
    _jobDescriptioncontroller.dispose();
    _jobTitlecontroller.dispose();
    _deadlineDatecontroller.dispose();
    _jobLocationcontroller.dispose();
    // _amountController.dispose();
    super.dispose();
  }

  Widget _textFormFields({
    required String valueKey,
    required TextEditingController controller,
    required bool enabled,
    required Function fct,
    required int maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          fct();
        },
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return '$valueKey is missing';
            }
            return null;
          },
          controller: controller,
          enabled: enabled,
          key: ValueKey(valueKey),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          maxLines: valueKey == 'JobDescription' ? 4 : 1,
          maxLength: maxLength,
          keyboardType:
              valueKey == 'figure' ? TextInputType.number : TextInputType.text,
          decoration: const InputDecoration(
              fillColor: Colors.black54,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red))),
        ),
      ),
    );
  }

  void _showRate({required Size size}) {
    size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black54,
            title: const Text(
              'Pick a Rate',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            content: Container(
                width: size.width * 0.9,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: Persistent.rate.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _rateController.text = Persistent.rate[index];
                          });
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_right_alt_outlined,
                                color: Colors.grey),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(Persistent.rate[index],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  )),
                            )
                          ],
                        ),
                      );
                    })),
          );
        });
  }

  void _showCurrency({required Size size}) {
    size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black54,
            title: const Text(
              'Choose a currency',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Persistent.currency.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _currencyController.text = Persistent.currency[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Row(children: [
                        const Icon(Icons.arrow_right_alt_outlined,
                            color: Colors.grey),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(Persistent.currency[index],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              )),
                        )
                      ]),
                    );
                  }),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ))
            ],
          );
        });
  }

  void _showTaskCategoriesDialog({required Size size}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black54,
            title: const Text(
              'Job Category',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Persistent.jobCategoryList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _jobCategoryController.text =
                              Persistent.jobCategoryList[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Row(children: [
                        const Icon(Icons.arrow_right_alt_outlined,
                            color: Colors.grey),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(Persistent.jobCategoryList[index],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              )),
                        )
                      ]),
                    );
                  }),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ))
            ],
          );
        });
  }

  void _pickDateDialog() async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 0)),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        _deadlineDatecontroller.text =
            '${picked!.day}/${picked!.month}/${picked!.year}';
        deadlineDateTimeStamp = Timestamp.fromMicrosecondsSinceEpoch(
            picked!.microsecondsSinceEpoch);
      });
    }
  }

  void _uploadTask() async {
    final jobId = const Uuid().v4();
    User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      if (_deadlineDatecontroller.text == 'Select Deadline Date' ||
          _jobCategoryController.text == 'Select Job Category' ||
          _currencyController.text == 'Pick a Currency' ||
          _rateController.text == 'Pick a rate') {
        GlobalMethod.showErrorDialog(
          error: 'Please fill every Field',
          ctx: context,
        );
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseFirestore.instance.collection('jobs').doc(jobId).set({
          'jobId': jobId,
          'uploadedBy': uid, //upload
          'email': user.email,
          'jobTitle': _jobTitlecontroller.text.toUpperCase(),
          'jobDescription': _jobDescriptioncontroller.text,
          'deadlineDate': _deadlineDatecontroller.text,
          'deadlineDateTimeStamp': deadlineDateTimeStamp,
          'jobCategory': _jobCategoryController.text,
          'jobComments': [],
          'recruitment': true,
          'createdAt': Timestamp.now(),
          'name': name,
          'userImage': userImage,
          'location': _jobLocationcontroller.text,
          'amount': _currencyController.text +
              _figureController.text +
              _rateController.text,
          'applicants': 0,
        });
        await Fluttertoast.showToast(
            msg: 'The task has been uploaded',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.grey,
            fontSize: 18);
        _jobTitlecontroller.clear();
        _jobDescriptioncontroller.clear();
        _jobLocationcontroller.clear();
        _figureController.clear();
        setState(() {
          _jobCategoryController.text = 'Select Job Category';
          _deadlineDatecontroller.text = 'Select Deadline Date';
          _currencyController.text = 'Pick a Currency';
          _rateController.text = 'Pick a rate';
        });
      } catch (error) {
        {
          setState(() {
            _isLoading = false;
          });
          GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('it not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('My location is ${Constants.myLocation}');
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                Navigator.canPop(context)
                    ? Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyJobScreen(openDrawer: widget.openDrawer)),
                        (route) => false)
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyJobScreen(openDrawer: widget.openDrawer)));
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        bottomNavigationBar: BottomNavigationBarForApp(
          indexNum: 4,
          openDrawer: widget.openDrawer,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Card(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Submit a Job',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    const SizedBox(height: 10),
                    const Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textTitles(label: 'Job Category:'),
                            _textFormFields(
                                valueKey: 'JobCategory',
                                controller: _jobCategoryController,
                                enabled: false,
                                fct: () {
                                  _showTaskCategoriesDialog(size: size);
                                },
                                maxLength: 100),
                            _textTitles(label: 'Job Title :'),
                            _textFormFields(
                                valueKey: 'JobTitle',
                                controller: _jobTitlecontroller,
                                enabled: true,
                                fct: () {},
                                maxLength: 100),
                            _textTitles(label: 'Job Description :'),
                            _textFormFields(
                                valueKey: 'JobDescription',
                                controller: _jobDescriptioncontroller,
                                enabled: true,
                                fct: () {},
                                maxLength: 300),
                            _textTitles(label: 'Amount:'),
                            Column(
                              children: [
                                _textFormFields(
                                    valueKey: 'currency',
                                    controller: _currencyController,
                                    enabled: false,
                                    fct: () {
                                      _showCurrency(size: size);
                                    },
                                    maxLength: 100),
                                _textFormFields(
                                    valueKey: 'figure',
                                    controller: _figureController,
                                    enabled: true,
                                    fct: () {},
                                    maxLength: 50),
                                _textFormFields(
                                    valueKey: 'rate',
                                    controller: _rateController,
                                    enabled: false,
                                    fct: () {
                                      _showRate(size: size);
                                    },
                                    maxLength: 100),
                              ],
                            ),
                            _textTitles(label: '🗺️ Job Location:'),
                            _textFormFields(
                                valueKey: 'Location',
                                controller: _jobLocationcontroller,
                                enabled: true,
                                fct: () {},
                                maxLength: 200),
                            _textTitles(label: 'Job Deadline Date :'),
                            _textFormFields(
                                valueKey: 'Deadline',
                                controller: _deadlineDatecontroller,
                                enabled: false,
                                fct: () {
                                  _pickDateDialog();
                                },
                                maxLength: 100),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : MaterialButton(
                                onPressed: () {
                                  _uploadTask();
                                },
                                color: kAccent,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Post Now',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                      SizedBox(width: 9),
                                      Icon(Icons.upload_file,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
