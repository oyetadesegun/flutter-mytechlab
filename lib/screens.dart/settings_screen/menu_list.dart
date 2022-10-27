// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// import 'package:mytechlab/models/settings.dart';

// class MenuList extends StatelessWidget {
//  SettingsMenuList(openDrawer) profileMenuList;
//   MenuList(
//     Key? key,
//     this.profileMenuList,
//   ) : super(key: key);
// //=> Navigator.pushNamed(context, profileMenuList.screen),
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => profileMenuList.screen)));
//       },
//       child: ListTile(
//         leading: Container(
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(Radius.circular(5)),
//               color: profileMenuList.bgColor,
//             ),
//             padding: const EdgeInsets.all(5),
//             child: Icon(
//               profileMenuList.icon,
//               color: Colors.white,
//             )),
//         title: Text(profileMenuList.title),
//         trailing: Icon(
//           Icons.keyboard_arrow_right,
//           color: Colors.grey[400],
//         ),
//       ),
//     );
//   }
// }

// class MenuList2 extends StatelessWidget {
//   final SettingsMenuList2 profileMenuList2;
//   const MenuList2(this.profileMenuList2, {super.key});
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => profileMenuList2.screen)));
//       },
//       child: ListTile(
//         leading: Container(
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(Radius.circular(5)),
//               color: profileMenuList2.bgColor,
//             ),
//             padding: const EdgeInsets.all(5),
//             child: Icon(profileMenuList2.icon, color: Colors.white)),
//         title: Text(profileMenuList2.title),
//         trailing: Icon(
//           Icons.keyboard_arrow_right,
//           color: Colors.grey[400],
//         ),
//       ),
//     );
//   }
// }
