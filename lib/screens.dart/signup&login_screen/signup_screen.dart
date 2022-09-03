import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/my_home_page/my_home_page.dart';
import 'package:mytechlab/services/auth.dart';
import 'package:path/path.dart' as path;
import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/main.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/utils.dart';

import '../../components/register_form.dart';
import '../../services/database.dart';
import 'firebase_api.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'SignUpScreen';
  final Function() onClickedSignIn;
  const SignUpScreen({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);
  @override
  State<SignUpScreen> createState() => SignUpState();
}

class SignUpState extends State<SignUpScreen> {
  AuthMethod authMethod = AuthMethod();
  DatabaseMethods databaseMethods = DatabaseMethods();
  UploadTask? task;
  File? file;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? path.basename(file!.path) : 'No profile uploaded yet...';
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(children: [
            headerSection('Register'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: selectFile,
                    label: const Text('Upload Profile Picture'),
                    icon: const Icon(Icons.camera_enhance_rounded)),
                const SizedBox(width: 5),
                ElevatedButton(
                    onPressed: uploadFile,
                    child: const Icon(
                      Icons.download_done_rounded,
                      size: 35,
                    ))
              ],
            ),
            const SizedBox(height: 8),
            Text(fileName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            task != null ? buildUploadStatus(task!) : Container(),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffeeeeee)),
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                controller: usernameController,
                validator: (value) {
                  if (value!.isEmpty) return 'Username can not be Empty';
                  if (value.length < 4)
                    return 'Username can not be less than 4';
                  return null;
                },
                textInputAction: TextInputAction.next,
                onChanged: (value) {},
                cursorColor: kAccent,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.insert_emoticon_sharp,
                    color: kAccent,
                  ),
                  hintText: 'username',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffeeeeee)),
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                controller: fullNameController,
                textInputAction: TextInputAction.next,
                onChanged: (value) {},
                validator: (value) =>
                    value!.isEmpty ? "Name can not be empty" : null,
                // validator: (value) {
                //   if (value!.isEmpty) return 'Name can not be empty';
                //   return null;
                // },
                cursorColor: kAccent,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kAccent,
                  ),
                  hintText: 'Full Name',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffeeeeee)),
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value!.isEmpty) return 'phone number can not be empty';
                  if (value.length < 11) return 'enter a correct phone number';
                  return null;
                },
                textInputAction: TextInputAction.next,
                onChanged: (value) {},
                keyboardType: TextInputType.phone,
                cursorColor: kAccent,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: kAccent,
                  ),
                  hintText: 'Phone Number',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Email(emailController: emailController),
            Password(passwordController: passwordController),
            RePassword(
                confirmPassword: confirmPassword,
                passwordController: passwordController),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 54,
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: signUp,
                  icon: const Icon(Icons.lock_open),
                  label: const Text(
                    'REGISTER',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: kAccent),
                )),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: RichText(
                  text: TextSpan(
                      text: 'Already have an Account? ',
                      style: TextStyle(color: Colors.grey[800], fontSize: 18),
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Log In',
                        style: const TextStyle(
                            fontSize: 18,
                            color: kAccent,
                            fontWeight: FontWeight.bold))
                  ])),
            ),
            SizedBox(height: 60)
          ]),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      //type: FileType.image,
      allowMultiple: false,
    );
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;
    final fileName = path.basename(file!.path);
    final destination = 'files/$fileName';
    FirebaseApi.uploadFile(destination, file!);

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download-Link:$urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (progress * 100).toString();
          return Text(
            'Image Upload: $percentage% DONE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return Container();
        }
      });
  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: kAccent,
              ),
            ));
    try {
      authMethod.signUpwithEmailAndPassword(
          emailController.text.trim(), passwordController.text.trim());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      addUserDetails(
        usernameController.text.trim(),
        fullNameController.text.trim(),
        phoneController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      //print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
  // Future signUp() async {
  //   final isValid = formKey.currentState!.validate();
  //   if (formKey.currentState!.validate()) {
  //     if (!isValid) return;
  //     showDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (context) => const Center(
  //               child: CircularProgressIndicator(
  //                 color: kAccent,
  //               ),
  //             ));
  //   }
  //   try {
  //     authMethod
  //         .signUpwithEmailAndPassword(
  //             emailController.text.trim(), passwordController.text.trim())
  //         .then((value) {
  //       Map<String, String> userInfoMap = {
  //         'email': emailController.text.trim(),
  //         'full name': fullNameController.text.trim(),
  //         'password': passwordController.text.trim(),
  //         'phone': phoneController.text.trim(),
  //         'username': usernameController.text.trim()
  //       };
  //       databaseMethods.uploadUserInfo(userInfoMap);
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => MyHomePage()));
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future addUserDetails(String username, String fullname, String phone,
      String email, String password) async {
    await FirebaseFirestore.instance.collection('users').add({
      'username': username,
      'full name': fullname,
      'phone': phone,
      'email': email,
      'password': password,
    });
  }

  Future retrieve(String username, String fullname, String phone, String email,
      String password) async {
    await FirebaseFirestore.instance.collection('users').get();
  }
}
