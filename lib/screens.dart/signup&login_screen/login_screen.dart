// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/drawer/Main_drawer_page.dart';

import 'package:mytechlab/screens.dart/signup&login_screen/ForgotPasswordPage.dart';
import 'package:mytechlab/services/auth.dart';
import 'package:mytechlab/services/database.dart';
import 'package:mytechlab/services/helper_functions.dart';

import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/components/register_form.dart';

class LoginScreen extends StatefulWidget {
  final Function() onClickedSignUp;
  const LoginScreen({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthMethod authMethod = AuthMethod();
  DatabaseMethods databaseMethods = DatabaseMethods();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool isLoading = false;

  QuerySnapshot? snapshotUserInfo;
  signIn() {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      HelperFunctions.saveUserEmailSharedPreference(
          emailController.text.trim());
      databaseMethods.getUserByEmail(emailController.text.trim()).then((value) {
        snapshotUserInfo = value;
        HelperFunctions.saveUserFullNameSharedPreference(
            snapshotUserInfo!.docs[0]['fullName']);
        HelperFunctions.saveUserEmailSharedPreference(
            snapshotUserInfo!.docs[0]['email']);
        HelperFunctions.saveUserPhoneSharedPreference(
            snapshotUserInfo!.docs[0]['phone']);
        HelperFunctions.saveUserNameSharedPreference(
            snapshotUserInfo!.docs[0]['username']);
        HelperFunctions.saveUserProfilePicSharedPreference(
            snapshotUserInfo!.docs[0]['profilePic']);
      });

      authMethod
          .signInWithEmailAndPassword(
              emailController.text.trim(), passwordController.text.trim())
          .then((value) {
        if (value != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainDrawerPage()));
        }
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
      key: formKey,
      child: Column(children: [
        HeaderSection('Login'),
        const SizedBox(height: 50),
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
            )),
        Email(emailController: emailController),
        password(),
        GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(top: 20, right: 20),
              alignment: Alignment.centerRight,
              child: Text(
                'Forget Password?',
                style: TextStyle(
                    color: kAccent, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ForgotPasswordPage()));
            }),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 54,
            alignment: Alignment.center,
            child: isLoading
                ? CircularProgressIndicator(color: kAccent)
                : ElevatedButton.icon(
                    onPressed: signIn,
                    icon: const Icon(Icons.lock_open),
                    label: const Text(
                      'LOGIN',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: kAccent),
                  )),
        const SizedBox(height: 10),
        // Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: GestureDetector(
        //     onTap: () {},
        //     child: Image.asset('images/google_login.jpg'),
        //   ),
        // ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(
                      text: 'Don\'t have Account? ',
                      style: TextStyle(color: Colors.grey[800], fontSize: 18),
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: 'Sign Up',
                        style: TextStyle(
                            fontSize: 18,
                            color: kAccent,
                            fontWeight: FontWeight.bold))
                  ]))
            ],
          ),
        ),
        const SizedBox(height: 35)
      ]),
    )));
  }

  Container password() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffeeeeee)),
        ],
      ),
      alignment: Alignment.center,
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        controller: passwordController,
        textInputAction: TextInputAction.next,
        obscureText: !showPassword,
        cursorColor: kAccent,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => value != null && value.length < 6
            ? 'Enter min. 6 characters'
            : null,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: (() {
              setState(() {
                showPassword = !showPassword;
              });
            }),
            child: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
          ),
          icon: Icon(
            Icons.vpn_key,
            color: kAccent,
          ),
          hintText: 'Enter Password',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
