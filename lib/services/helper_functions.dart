import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = 'ISLOGGEDIN';
  static String sharedPreferenceUserNameKey = 'USERNAMEKEY';
  static String sharedPreferenceUserEmailKey = 'USEREMAILKEY';
  static String sharedPreferenceUserFullNameKey = 'USERFULLNAMEKEY';
  static String sharedPreferenceUserProfilePic = 'USERPROFILEPIC';
  static String sharedPreferenceUserPhone = 'USERPHONE';
  static String sharedPreferenceUserAbout = 'USERABOUT';
  static String sharedPreferenceUserAddress = 'USERADDRESS';
  static String sharedPreferenceUserId = 'USERID';
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  static Future<bool> saveUserFullNameSharedPreference(
      String userFullName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserFullNameKey, userFullName);
  }

  static Future<bool> saveUserProfilePicSharedPreference(
      String userProfilePic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        sharedPreferenceUserProfilePic, userProfilePic);
  }

  static Future<bool> saveUserPhoneSharedPreference(String userPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserPhone, userPhone);
  }

  static Future<bool> saveUserAboutPhoneSharedPreference(
      String userAbout) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserPhone, userAbout);
  }

  static Future<bool> saveUserAddressSharedPreference(
      String userAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserPhone, userAddress);
  }

  static Future<bool> saveUserIdSharedPreference(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserPhone, userId);
  }

  // getting data from sharedPreference
  static Future<bool?> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String?> getUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String?> getUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserEmailKey);
  }

  static Future<String?> getUserFullNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserFullNameKey);
  }

  static Future<String?> getUserProfilePicSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserProfilePic);
  }

  static Future<String?> getUserPhoneSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserPhone);
  }

  static Future<String?> getUserAboutPhoneSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserAbout);
  }

  static Future<String?> getUserAddressSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserAddress);
  }

  static Future<String?> getUserIdSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserId);
  }
}
