import 'package:firebase_database/firebase_database.dart';

class UserServices {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = "users";
  createUser(String uid, Map value) async {
    print('adding user details!');
    String userid = value["uid"];
    await _database
        .ref()
        .child("$ref/$userid")
        .push()
        .set(value)
        .catchError((e) => {print(e.toString())});
  }
}
