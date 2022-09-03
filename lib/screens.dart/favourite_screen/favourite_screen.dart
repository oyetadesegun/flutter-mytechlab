import 'package:flutter/material.dart';
import 'package:mytechlab/screens.dart/explore_screen/explore_screen.dart';

class FavouriteScreen extends StatefulWidget {
  static const String id = 'FavouriteScreen';
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final bool page = true;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'topbar',
      child: Container(
        child: Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.notes),
              backgroundColor: Colors.green,
              centerTitle: true,
              title: Text('My Job Screen'),
            ),
            body: page == true ? NoJobYet() : Container()),
      ),
    );
  }
}

class NoJobYet extends StatelessWidget {
  const NoJobYet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
            child: Column(
          children: [
            Image.asset(
              'images/empty-1.png',
              height: 350,
            ),
            Text(
              'No jobs yet...',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'When you Apply for a Job,',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            Center(
              child: Text(
                'it will appear here in form a list',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ExploreScreen.id);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'START SEARCHING',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        )),
      ),
    ]);
  }
}
//