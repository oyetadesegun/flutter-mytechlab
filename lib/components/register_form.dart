// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, avoid_unnecessary_containers, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';

import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/screens.dart/drawer/Main_drawer_page.dart';

class Forms extends StatelessWidget {
  IconData icon;

  String hint;
  Forms(this.icon, this.hint, {super.key});

  @override
  Widget build(BuildContext context) {
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
      child: TextField(
        textInputAction: TextInputAction.next,
        onChanged: (value) {},
        cursorColor: kAccent,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kAccent,
          ),
          hintText: hint,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  String text;
  HeaderSection(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: kAccent,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(90),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              height: 180,
              width: 180,
              child: Image.asset('images/logoWhite.png'),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, top: 20),
              alignment: Alignment.bottomRight,
              child: Text(
                text,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Bttn extends StatelessWidget {
  final String text;

  const Bttn(this.context, this.text, {super.key});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainDrawerPage()))
      },
      child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
          padding: const EdgeInsets.only(left: 20, right: 20),
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: kAccent,
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xffeeeeee))
              ]),
          child: Text(text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white))),
    );
  }
}

// ignore: camel_case_types
class isMember extends StatelessWidget {
  const isMember({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already a Member ? '),
        GestureDetector(
            child: Text('Login Now', style: TextStyle(color: kAccent)))
      ],
    ));
  }
}

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: TextField(
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
    );
  }
}

class Email extends StatelessWidget {
  const Email({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (email) {
          return RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(email!)
              ? null
              : 'Please provide a valid Email address';
        },
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        cursorColor: kAccent,
        decoration: InputDecoration(
          icon: Icon(
            Icons.mail,
            color: kAccent,
          ),
          hintText: 'Enter Email',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class Password extends StatefulWidget {
  Password({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  @override
  Widget build(BuildContext context) {
    bool showPassword = true;
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
        controller: widget.passwordController,
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

class RePassword extends StatelessWidget {
  const RePassword({
    Key? key,
    required this.confirmPassword,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController confirmPassword;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
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
        controller: confirmPassword,
        textInputAction: TextInputAction.done,
        obscureText: true,
        cursorColor: kAccent,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) return 'Password can not be empty';
          if (value != passwordController.text) {
            return 'They Don\'t Match';
          }

          return null;
        },
        decoration: InputDecoration(
          icon: Icon(
            Icons.vpn_key,
            color: kAccent,
          ),
          hintText: 'Re-Enter Password',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
