import 'package:e_shoppie/provider/authentication.dart';
import 'package:e_shoppie/provider/user_services.dart';
import 'package:e_shoppie/specific_page_data/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//User can only be one of these states
/**
 * uninitialized: User just opened the app (just opening)
 * unauthenticated: Show the login screen to the user
 * authenticating: Show a circular indicator the user
 * authenticated: User is looged into the app
 */
enum Status { uninitialized, authenticated, unauthenticated } //authenticating,

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  // Auth _userAuth = Auth();
  UserServices userServices = UserServices();
  User? _user;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  Status _status =
      Status.uninitialized; //when the instance of the class is created
  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    //subscribing to stream to listen to changes in user status
    _auth.authStateChanges().listen(
      (user) {
        _onStatusChanged(user);
      },
    );
  }
  Status get status => _status;
  User? get user => _user;
  //Handling email sign in
  Future<bool> signIn(String email, String password) async {
    try {
      // //change the status of the user
      // _status = Status.authenticating;
      //notify the listeners
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status = Status.authenticated;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      // _status = Status.authenticating;
      notifyListeners();
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        throw FirebaseAuthException(code: 'Sign in failed');
      } else {
        //Obtain the auth details from the request
        GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        //create new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        debugPrint('credential:${credential.signInMethod}');
        final UserCredential authResult = await _auth.signInWithCredential(
            credential); //automatically triggers any authSate changes
        print(
            'authResult: ${authResult.additionalUserInfo!.username} isNewUser: ${authResult.additionalUserInfo!.isNewUser}');
        if (authResult.additionalUserInfo!.isNewUser) {
          //if(user!=null)
          //{
          Map<String, dynamic> values = {
            id: user!.uid,
            username: user!.displayName,
            email: user!.email,
            profilePicture: user!.photoURL,
          };
          userServices.createUser(values);
          //}
        }
        _status = Status.authenticated;
        notifyListeners();
        return true;
      }
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  // Future<bool> signUpWithGoogle() async {
  //   try {
  //     _status = Status.authenticating;
  //     notifyListeners();
  //
  //     if ((await _userAuth.googleSignIn()) == null) {
  //       throw FirebaseAuthException(code: 'Not able to sign in using Google');
  //     }
  //     Map<String, dynamic> values = {
  //       id: user!.uid,
  //       username: user!.displayName,
  //       email: user!.email,
  //       profilePicture: user!.photoURL,
  //     };
  //     userServices.createUser(values);
  //     _status = Status.authenticated;
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     _status = Status.unauthenticated;
  //     notifyListeners();
  //     print(e.toString());
  //     return false;
  //   }
  // }

  Future<bool> signUp(String firstName, String? middleName, String lastName,
      String email, String password) async {
    try {
      // //change the status of the user
      // _status = Status.authenticating;
      //notify the listeners
      notifyListeners();
      // UserCredential credential =
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Map<String, dynamic> values = {
        'id': user!.uid,
        'email': email,
        'firstName': firstName,
        'middleName': middleName ?? '',
        'lastName': lastName,
      };
      userServices.createUser(values);
      _status = Status.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    print('entered signOut');
    await _auth.signOut();
    await _googleSignIn.signOut();
    _status = Status.unauthenticated;
    print('Exiting signOut');

    return Future.delayed(Duration
        .zero); //duration to return is set to zero (can work without it)
  }

  Future<void> _onStatusChanged(User? user) async {
    if (user == null) {
      _status = Status.unauthenticated;
    } else {
      _user = user;
      _status = Status.authenticated;
    }
    notifyListeners();
  }
}
