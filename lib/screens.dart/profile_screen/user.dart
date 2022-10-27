// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mytechlab/data/user_data.dart';
import 'package:mytechlab/main.dart';

class RUser {
  final String imagePath;
  final String name;
  final String email;
  final String userName;
  final String about;
  final bool isDarkMode;

  final String phone;
  RUser({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.userName,
    required this.about,
    required this.isDarkMode,
    required this.phone,
  });
}

class UserPreferences {
  static RUser myUser = RUser(
      imagePath: Constants.myProfilePic,
      name: Constants.myName,
      userName: Constants.myUserName,
      phone: Constants.myPhone,
      email: Constants.myEmail,
      about:
          'you are yet to Update me 😥.\nClick the button above to do that right now',
      isDarkMode: isWhite);
}
