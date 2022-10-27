import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../signup&login_screen/services/global_variables.dart';

class Persistent {
  static List<String> jobCategoryList = [
    'Programming (Web and App)',
    'Graphics Designing',
    'UI/UX ',
    'Data Science & Analysis',
    'Marketing',
    'Copywriting and Content writing',
    'Social Media Management',
    'Virtual Assistant',
    'Others',
  ];
  static List<String> currency = ['₦', r'$', '£', '₿'];
  static List<String> rate = [
    '/month',
    '/Commission',
    '/day',
    ' one off',
    " Winner's prize",
    '/week',
    '/job',
    '/Sales'
  ];
  void getMyData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    name = userDoc.get('fullName');
    userImage = userDoc.get('profilePic');
  }
}
