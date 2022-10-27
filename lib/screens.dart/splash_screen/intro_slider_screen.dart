import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/signup&login_screen/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../components/constants/colors.dart';

class IntroSliderScreen extends StatefulWidget {
  static const String id = 'IntroSliderScreen';

  const IntroSliderScreen({super.key});

  @override
  State<IntroSliderScreen> createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  final controller = PageController();
  @override
  void initState() {
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
                  foregroundColor: Colors.white,
                  backgroundColor: kAccent,
                  minimumSize: const Size.fromHeight(80)),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AuthPage()));
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
                        child: const Text(
                          'SKIP',
                        )),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 5,
                        effect: WormEffect(
                            spacing: 16,
                            dotColor: kFont,
                            activeDotColor: kAccent),
                        onDotClicked: (index) => controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () => controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut),
                        child: const Text(
                          'NEXT',
                        ))
                  ]),
            ),
    );
  }
}

class Page extends StatelessWidget {
  String image, text, desc;
  Page(this.text, this.desc, this.image, {super.key});

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
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
