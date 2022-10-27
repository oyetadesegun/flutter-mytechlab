import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';

import 'utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: kAccent,
          title: const Text('Reset Password'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        'images/logoName.png',
                        height: 130,
                      ),
                    ),
                    const Text(
                        'Enter Your Email and we will send you a\npassword reset link. Make sure you check your spam',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 15),
                    TextFormField(
                        controller: emailController,
                        cursorColor: kAccent,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(labelText: 'Email'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: kAccent,
                          minimumSize: const Size.fromHeight(50)),
                      icon: const Icon(Icons.email_outlined),
                      label: const Text(
                        'Reset Password',
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: resetPassword,
                    ),
                  ],
                )),
          ),
        ),
      );
  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
                child: CircularProgressIndicator(
              color: kAccent,
            )));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Password Reset Email Sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
