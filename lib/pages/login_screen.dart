import 'package:e_shoppie/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;
  SharedPreferences? preferences;
  bool isLoading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // Firebase.initializeApp();
    isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void isSignedIn() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.popAndPushNamed(context, HomePage.id);
      setState(() {
        isLoading = false;
      });
    }
    Future handleSignIn() async {
      preferences = await SharedPreferences.getInstance();
      setState(() {
        isLoading = true;
      });
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        try {
          final UserCredential userCredential =
              await firebaseAuth.signInWithCredential(credential);
          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // handle the error here
          } else if (e.code == 'invalid-credential') {
            // handle the error here
          }
        } catch (e) {
          // handle the error here
        }
        if (user != null) {
          final QuerySnapshot result = await FirebaseFirestore.instance
              .collection('user')
              .where('id', isEqualTo: user?.uid)
              .get();
          final List<DocumentSnapshot> documents = result.docs;
          if (documents.length == 0) {
            //insert the user to the database
            FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
              "id": user?.uid,
              "email": user?.email,
              "username": user?.displayName,
              "profilePicture": user?.photoURL
            });
            await preferences?.setString("id", user!.uid);
            await preferences?.setString("username", user!.displayName ?? ' ');
            await preferences?.setString("photoUrl", user!.photoURL ?? ' ');
          } else {
            await preferences?.setString("id", documents[0]['id']);
            await preferences?.setString("username", documents[0]['username']);
            await preferences?.setString("photoUrl", documents[0]['photoUrl']);
          }
          Fluttertoast.showToast(msg: "Logged In Successfully!");
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }
}
