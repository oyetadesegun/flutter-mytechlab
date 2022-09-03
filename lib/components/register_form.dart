import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mytechlab/components/constants/colors.dart';
import '../screens.dart/signup&login_screen/signup_screen.dart';

import '../my_home_page/my_home_page.dart';
import '../screens.dart/signup&login_screen/login_screen.dart';

class form extends StatelessWidget {
  IconData icon;

  String hint;
  form(
    this.icon,
    this.hint,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
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

class headerSection extends StatelessWidget {
  String text;
  headerSection(
    this.text,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: kAccent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(90),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Image.asset('images/logoWhite.png'),
              height: 180,
              width: 180,
            ),
            Container(
              margin: EdgeInsets.only(right: 20, top: 20),
              alignment: Alignment.bottomRight,
              child: Text(
                text,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class bttn extends StatelessWidget {
  final String text;

  bttn(this.context, this.text);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {Navigator.pushReplacementNamed(context, MyHomePage.id)},
      child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 50),
          padding: EdgeInsets.only(left: 20, right: 20),
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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white))),
    );
  }
}

class isMember extends StatelessWidget {
  const isMember({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
        //margin: EdgeInsets.only(top: 10),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already a Member ? '),
        GestureDetector(
            // onTap: () => {Navigator.pushNamed(context, LoginScreen())},
            child: Text('Login Now', style: TextStyle(color: kAccent)))
      ],
    ));
  }
}

class phoneNumber extends StatelessWidget {
  const phoneNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffeeeeee)),
        ],
      ),
      alignment: Alignment.center,
      child: TextField(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) => value != null && value.length >= 10
        //     ? 'Enter a validate phone number'
        //     : null,
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
        //  email != null && !EmailValidator.validate(email)
        //     ? 'Enter a valid email'
        //     : null,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        cursorColor: kAccent,
        decoration: const InputDecoration(
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

class Password extends StatelessWidget {
  const Password({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

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
        controller: passwordController,
        textInputAction: TextInputAction.done,
        obscureText: true,
        cursorColor: kAccent,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => value != null && value.length < 6
            ? 'Enter min. 6 characters'
            : null,
        decoration: const InputDecoration(
          // ignore: unnecessary_const
          icon: const Icon(
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
        decoration: const InputDecoration(
          // ignore: unnecessary_const
          icon: const Icon(
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
