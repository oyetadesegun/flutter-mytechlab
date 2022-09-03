
  //get docIDs   sha1:  ab8fca6472d9ae5467dac8fc8477917115d336d4
  //      SHA-256: e14ed8ff5898e25e6a632ebe723bdc1acc4083215772c05c553066b6d0b8d236
  // KEY-SHAAs    2jmj7l5rSw0yVb/vlWAYkK/YBwk=

//   {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white10,
//       body: Stack(children: [
//         Positioned(
//           bottom: 0,
//           left: 0,
//           child: Container(
//             width: size.width,
//             height: 80,
//             // color: Colors.white,
//             child: Stack(children: [
//               CustomPaint(
//                 size: Size(size.width, 80),
//                 painter: BNBCustomPainter(),
//               ),
//               Center(
//                   heightFactor: 0.6,
//                   child: GestureDetector(
//                     onTap: () => Navigator.pushNamed(context, WalletScreen.id),
//                     child: FloatingActionButton(
//                       onPressed: () =>
//                           Navigator.pushNamed(context, WalletScreen.id),
//                       backgroundColor: kAccent,
//                       child: Icon(Icons.wallet, size: 40),
//                       elevation: 0.1,
//                     ),
//                   )),
//               Container(
//                 width: size.width,
//                 height: 80,
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       IconButton(
//                           onPressed: () =>
//                               Navigator.pushNamed(context, TrainingScreen.id),
//                           icon: Icon(Icons.home)),
//                       IconButton(
//                           onPressed: () =>
//                               Navigator.pushNamed(context, ExploreScreen.id),
//                           icon: Icon(Icons.calendar_month_rounded)),
//                           Container(width: size.width*0.2),
//                       IconButton(
//                           onPressed: () =>
//                               Navigator.pushNamed(context, ChatScreen.id),
//                           icon: Icon(Icons.chat)),
//                       IconButton(
//                           onPressed: () =>
//                               Navigator.pushNamed(context, ProfileScreen.id),
//                           icon: Icon(Icons.supervisor_account)),
//                     ]),
//               ),
//             ]),
//           ),
//         ),
//       ]),
//     );
//   }
// }

// class BNBCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//     Path path = Path()..moveTo(0, 20);
//     path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
//     path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
//     path.arcToPoint(Offset(size.width * 0.60, 20),
//         radius: Radius.circular(10), clockwise: false);
//     path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
//     path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     canvas.drawShadow(path, Colors.black, 5, true);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }