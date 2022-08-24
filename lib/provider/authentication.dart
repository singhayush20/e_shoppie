import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<User?> googleSignIn();
}

class Auth implements BaseAuth {
  User? user;
  FirebaseAuth? firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    try {
      final UserCredential userCredential =
          await firebaseAuth!.signInWithCredential(credential);
      user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
        print(e.code);
        print(e.credential);
      } else if (e.code == 'invalid-credential') {
        // handle the error here
        print(e.credential);
      }
    } catch (e) {
      // handle the error here
    }
    return null;
    // if (user != null) {
    //   final QuerySnapshot result = await FirebaseFirestore.instance
    //       .collection('users')
    //       .where('id', isEqualTo: user?.uid)
    //       .get();
    //   final List<DocumentSnapshot> documents = result.docs;
    //   if (documents.length == 0) {
    //     //insert the user to the database
    //     FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
    //       "id": user?.uid,
    //       "email": user?.email,
    //       "username": user?.displayName,
    //       "profilePicture": user?.photoURL
    //     });
    //   }
    // }
  }

  // void changeScreenReplacement(BuildContext context, String id) {
  //   Navigator.popAndPushNamed(context, id);
  // }
  //
  // void changeScreen(BuildContext context, String id) {
  //   Navigator.popAndPushNamed(context, id);
  // }
}
