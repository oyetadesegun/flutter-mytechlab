// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/auth_page.dart';
import 'package:mytechlab/screens.dart/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../components/constants/colors.dart';
import '../../main.dart';
import '../signup&login_screen/login_screen.dart';

class IntroSliderScreen extends StatefulWidget {
  static const String id = 'IntroSliderScreen';

  @override
  State<IntroSliderScreen> createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  final controller = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 4);
          },
          children: [
            Page(
                'Welcome to MyTechLab',
                'We\'ve been expecting you. Kindly swipe to learn More about this App Features... ',
                'images/welcome.gif'),
            Page(
                'We are here to Empower you...',
                'After carrying out Multiple and Careful research on Major Key High-Icome Skills, We have been able to collate this sets of Training just to empower you in your desired Endeavour',
                'images/learn.gif'),
            Page(
                'Job Opportunities Just for you...',
                'You have sharpened your skills in the Soft Skills that interests you, now it is Time to put your knowledge into practice ',
                'images/work.gif'),
            Page(
                'Who doesn\'t want to get Paid?',
                'Atlast, you are done wth your Task, it is time to check your Alert, you worked for it so you deserve it. Sha remember me oooo.',
                'images/money.gif'),
            Page(
                'Meet Like Minds',
                'No man is an island they say, then it is important we can get to interact with like minds so we can socialise and improve. Guys don\'t shoot shots ooo',
                'images/meet.gif')
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  primary: Colors.white,
                  backgroundColor: kAccent,
                  minimumSize: Size.fromHeight(80)),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
                Navigator.pushReplacementNamed(context, AuthPage.id);
              },
              child: const Text('Get Started', style: TextStyle(fontSize: 24)))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => controller.jumpToPage(4),
                        child: Text(
                          'SKIP',
                        )),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 5,
                        effect: const WormEffect(
                            spacing: 16,
                            dotColor: kFont,
                            activeDotColor: kAccent),
                        onDotClicked: (index) => controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () => controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut),
                        child: Text(
                          'NEXT',
                        ))
                  ]),
            ),
    );
  }
}

class Page extends StatelessWidget {
  String image, text, desc;
  Page(this.text, this.desc, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Image.asset(image),
            Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25, color: kAccent, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  desc, textAlign: TextAlign.center,
                  // ,
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
