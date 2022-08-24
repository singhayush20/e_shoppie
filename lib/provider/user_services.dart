import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _ref = "users";
  final String _userId = "userId";
  void createUser(Map<String, dynamic> data) async {
    print('adding user details!');
    _firestore.collection(_ref).doc(data[_userId]).set(data);
  }
}
