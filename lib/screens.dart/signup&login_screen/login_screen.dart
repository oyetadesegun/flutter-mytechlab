// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytechlab/services/auth.dart';
import 'package:provider/provider.dart';

import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/components/register_form.dart';
import 'package:mytechlab/components/widget.dart';
import 'package:mytechlab/main.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/signup_screen.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/utils.dart';

import '../../my_home_page/my_home_page.dart';
import 'ForgotPasswordPage.dart';

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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      headerSection('Login'),
      const SizedBox(height: 50),
      Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey[200],
            boxShadow: [
              const BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 50,
                  color: const Color(0xffeeeeee)),
            ],
          )),
      Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey[200],
            boxShadow: [
              const BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Color(0xffeeeeee)),
            ],
          ),
          alignment: Alignment.center,
          child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              cursorColor: kAccent,
              textInputAction: TextInputAction.next,
              decoration: inputForm('Enter Email', Icons.email))),
      Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
          boxShadow: [
            const BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffeeeeee)),
          ],
        ),
        alignment: Alignment.center,
        child: TextField(
            obscureText: true,
            textInputAction: TextInputAction.done,
            controller: passwordController,
            cursorColor: kAccent,
            decoration: inputForm('Password', Icons.vpn_key)),
      ),
      GestureDetector(
        child: Container(
          margin: const EdgeInsets.only(top: 20, right: 20),
          alignment: Alignment.centerRight,
          child: const Text(
            'Forget Password?',
            style: TextStyle(
                color: kAccent, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ForgotPasswordPage())),
      ),
      Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
          padding: const EdgeInsets.only(left: 20, right: 20),
          height: 54,
          alignment: Alignment.center,
          child: ElevatedButton.icon(
            onPressed: () {}, //signUp,
            icon: const Icon(Icons.lock_open),
            label: const Text(
              'LOGIN',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: kAccent),
          )),
      SizedBox(height: 10),
      Padding(
        padding: EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {},
          // async {
          //  // bool isSuccess = await authProvider.handle_auth.();
          //   if (isSuccess) {
          //     Navigator.pushReplacement(context,
          //         MaterialPageRoute(builder: (context) => MyHomePage()));
          //   }
          // },
          child: Image.asset('images/google_login.jpg'),
        ),
      ),
      Container(
        // margin: const EdgeInsets.only(top: 10),
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
                      style: const TextStyle(
                          fontSize: 18,
                          color: kAccent,
                          fontWeight: FontWeight.bold))
                ]))
          ],
        ),
      ),
      SizedBox(height: 35)
    ])));
  }
}
// class LoginScreen extends StatefulWidget {
//   static const String id = 'LoginScreen';
//   final VoidCallback onClickedSignUp;
//   const LoginScreen({
//     Key? key,
//     required this.onClickedSignUp,
//   }) : super(key: key);
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//  
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     AuthProvider authProvider = Provider.of<AuthProvider>(context);
//     switch (authProvider.status) {
//       case Status.authenticateError:
//         Fluttertoast.showToast(msg: 'Sign in fail');
//         break;
//       case Status.authenticateCanceled:
//         Fluttertoast.showToast(msg: 'Sign in Cancelled');
//         break;
//       case Status.authenticated:
//         Fluttertoast.showToast(msg: 'Sign in successful');
//         break;
//       default:
//         break;
//     }
  
//         alignment: Alignment.center,
//         child: 
//       ),
      
//       
//       // SizedBox(height: 10),
//       // Padding(
//       //   padding: EdgeInsets.all(20),
//       //   child: GestureDetector(
//       //     onTap: () async {
//       //       bool isSuccess = await authProvider.handle_auth.();
//       //       if (isSuccess) {
//       //         Navigator.pushReplacement(context,
//       //             MaterialPageRoute(builder: (context) => MyHomePage()));
//       //       }
//       //     },
//       //     child: Image.asset('images/google_login.jpg'),
//       //   ),
//       // ),
//       Positioned(
//           child: authProvider.status == Status.authenticating
//               ? LoadingView()
//               : SizedBox.shrink()),
//       
//     ])));
//   }

//   Future signIn() async {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(
//               child: const CircularProgressIndicator(
//                 color: kAccent,
//               ),
//             ));
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: emailController.text.trim(),
//           password: passwordController.text.trim());
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       Utils.showSnackBar(e.message);
//     }
//     navigatorKey.currentState!.popUntil((route) => route.isFirst);
//   }
// }
