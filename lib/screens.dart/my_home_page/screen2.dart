import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
                child: Column(
              children: [
                Expanded(child: Container(color: Colors.blueGrey[300])),
                Expanded(
                  child: Container(color: Colors.white),
                )
              ],
            )),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.share))
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(bottom: 300, top: 0),
            //   child: Align(
            //     alignment: Alignment.topCenter,
            //     child: Image.asset('images/graphic.png'),
            //   ),
            // ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: 150,
                // child: ,
              ),
            )
          ],
        ),
      ),
    );
  }
}
