import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/services/global_methods.dart';
import 'package:mytechlab/services/auth.dart';
import 'package:path/path.dart' as path;
import 'package:mytechlab/components/constants/colors.dart';

import '../../components/register_form.dart';

import '../../services/database.dart';
import '../../services/helper_functions.dart';

class SignUpScreen extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpScreen({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);
  @override
  State<SignUpScreen> createState() => SignUpState();
}

class SignUpState extends State<SignUpScreen> {
  @override
  void initState() {
    node.addListener(() {
      if (!node.hasFocus) {
        formatNickname();
      }
    });
    super.initState();
  }

  void formatNickname() {
    usernameController.text = usernameController.text.replaceAll(" ", "");
  }

  bool loading = false;
  bool isLoading = false;
  AuthMethod authMethod = AuthMethod();
  DatabaseMethods databaseMethods = DatabaseMethods();
  String? profilePic;

  UploadTask? task;
  File? imageFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  FocusNode node = FocusNode();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();
  final addressController = TextEditingController();
  final usernameController = TextEditingController();
  @override
  void dispose() {
    usernameController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  void signUp() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      if (imageFile == null) {
        GlobalMethod.showErrorDialog(
            error: 'Please pick an Image', ctx: context);
        return;
      }
      setState(() {
        isLoading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim().toLowerCase(),
          password: passwordController.text.trim(),
        );
        final User? user = _auth.currentUser;
        final uid = user!.uid;
        final ref = FirebaseStorage.instance
            .ref()
            .child('profilePic')
            .child('$uid.jpg');
        await ref.putFile(imageFile!);
        profilePic = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('users').doc(uid).set({
          'docId': uid,
          'profilePic': profilePic!,
          'email': emailController.text.trim().toLowerCase(),
          'fullName': fullNameController.text.trim(),
          'phone': phoneController.text.trim(),
          'username': usernameController.text.toLowerCase().trim(),
          'address': addressController.text.trim(),
          'createdAt': Timestamp.now(),
        });
        HelperFunctions.saveUserEmailSharedPreference(
            emailController.text.trim().toLowerCase());
        HelperFunctions.saveUserFullNameSharedPreference(
            fullNameController.text.trim());
        HelperFunctions.saveUserPhoneSharedPreference(
            phoneController.text.trim());
        HelperFunctions.saveUserNameSharedPreference(
            usernameController.text.trim().toLowerCase());
        HelperFunctions.saveUserAddressSharedPreference(
            addressController.text.trim());
        HelperFunctions.saveUserProfilePicSharedPreference(profilePic!);
        setState(() {
          isLoading = true;
        });
        Navigator.canPop(context) ? Navigator.of(context) : null;
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Please choose an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    getFromCamera();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.camera,
                          color: kAccent,
                        ),
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: kAccent),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    getFromGallery();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.photo,
                          color: kAccent,
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(color: kAccent),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(children: [
            HeaderSection('Register'),
            const SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 70,
                  child: ClipOval(
                    child: SizedBox(
                      width: 180,
                      height: 180,
                      child: (imageFile != null
                          ? Image.file(
                              imageFile!,
                              fit: BoxFit.fill,
                            )
                          : Image.network(
                              'https://img.icons8.com/officel/452/circled-user-male-skin-type-6.png',
                              fit: BoxFit.fill,
                            )),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                      onTap: showImageDialog,
                      child: ClipOval(
                        child: Container(
                          child: Icon(Icons.add_a_photo, color: Colors.white),
                          padding: EdgeInsets.all(8),
                          color: Colors.green,
                        ),
                      )),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffeeeeee)),
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                focusNode: node,
                controller: usernameController,
                validator: (value) {
                  if (value!.isEmpty) return 'Username can not be Empty';
                  if (value.length < 4) {
                    return 'Username can not be less than 4';
                  }
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
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: const [
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
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: const [
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
                  if (value!.isEmpty) {
                    return 'phone number can not be empty';
                  }
                  if (value.length < 11) {
                    return 'enter a correct phone number';
                  }
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
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffeeeeee)),
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                //focusNode: node,
                controller: addressController,
                validator: (value) {
                  if (value!.isEmpty) return 'Address can not be Empty';
                  if (value.length < 4) {
                    return 'Address can not be less than 4';
                  }
                  return null;
                },
                //  textInputAction: TextInputAction.next,
                onChanged: (value) {},
                cursorColor: kAccent,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.pin_drop,
                    color: kAccent,
                  ),
                  hintText: 'Address',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 54,
                alignment: Alignment.center,
                child: isLoading
                    ? Container(
                        child: Center(
                        child: CircularProgressIndicator(color: kAccent),
                      ))
                    : ElevatedButton.icon(
                        onPressed: () {
                          signUp();
                        },
                        icon: const Icon(Icons.lock_open),
                        label: const Text(
                          'REGISTER',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
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
                        style: TextStyle(
                            fontSize: 18,
                            color: kAccent,
                            fontWeight: FontWeight.bold))
                  ])),
            ),
            const SizedBox(height: 60)
          ]),
        ),
      ),
    );
  }

  void getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    cropImage(pickedFile!.path);

    Navigator.pop(context);
  }

  void getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    cropImage(pickedFile!.path);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }
}
