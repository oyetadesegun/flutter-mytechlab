// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  // final GoogleSignIn googleSignIn;
  // final FirebaseAuth firebaseAuth;
  // final FirebaseFirestore firebaseFirestore;
  // final SharedPreferences prefs;
  // Status _status = Status.uninitialized;

  // Status get status => _status;

  // AuthProvider({
  //   required this.googleSignIn,
  //   required this.firebaseAuth,
  //   required this.firebaseFirestore,
  //   required this.prefs,
  // });
  // String? getUserFirebaseId() {
  //   return prefs.getString(FirestoreConstants.id);
  // }

  // Future<bool> isLoggedIn() async {
  //   bool isLoggedIn = await googleSignIn.isSignedIn();
  //   if (isLoggedIn &&
  //       prefs.getString(FirestoreConstants.id)?.isNotEmpty == true) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // Future<bool> handleSignIn() async {
  //   _status = Status.authenticating;
  //   notifyListeners();
  //   GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //   if (googleUser != null) {
  //     GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     User? firebaseUser =
  //         (await firebaseAuth.signInWithCredential(credential)).user;
  //     if (firebaseUser != null) {
  //       final QuerySnapshot result = await firebaseFirestore
  //           .collection(FirestoreConstants.pathUserCollection)
  //           .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
  //           .get();
  //       final List<DocumentSnapshot> document = result.docs;
  //       if (document.length == 0) {
  //         firebaseFirestore
  //             .collection(FirestoreConstants.pathUserCollection)
  //             .doc(firebaseUser.uid)
  //             .set({
  //           FirestoreConstants.username: firebaseUser.displayName,
  //           FirestoreConstants.photoUrl: firebaseUser.photoURL,
  //           FirestoreConstants.id: firebaseUser.uid,
  //           'createdAt': DateTime.now().microsecondsSinceEpoch.toString(),
  //           FirestoreConstants.chattingWith: null
  //         });
  //         User? currentUser = firebaseUser;
  //         await prefs.setString(FirestoreConstants.id, currentUser.uid);
  //         await prefs.setString(
  //             FirestoreConstants.username, currentUser.displayName ?? "");
  //         await prefs.setString(
  //             FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
  //         await prefs.setString(
  //             FirestoreConstants.phone, currentUser.phoneNumber ?? "");
  //       } else {
  //         DocumentSnapshot documentSnapshot = document[0];
  //         UserChat userChat = UserChat.fromDocument(documentSnapshot);
  //         await prefs.setString(FirestoreConstants.id, userChat.id);
  //         await prefs.setString(FirestoreConstants.fullname, userChat.fullname);
  //         await prefs.setString(FirestoreConstants.username, userChat.username);
  //         await prefs.setString(FirestoreConstants.photoUrl, userChat.photoUrl);
  //         await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
  //         await prefs.setString(FirestoreConstants.phone, userChat.phone);
  //       }
  //       _status = Status.authenticated;
  //       notifyListeners();
  //       return true;
  //     } else {
  //       _status = Status.authenticateError;
  //       notifyListeners();
  //       return false;
  //     }
  //   } else {
  //     _status = Status.authenticateCanceled;
  //     notifyListeners();
  //     return false;
  //   }
  // }

  // Future<void> handleSignOut() async {
  //   _status = Status.uninitialized;
  //   FirebaseAuth.instance.signOut();
  //   // Navigator.of(context).push(MaterialPageRoute(
  //   //     builder: ((context) => MainLoginScreen())));
  //   //await firebaseAuth.signOut();
  //   //await googleSignIn.disconnect();
  //   // await googleSignIn.signOut();
  // }
}
