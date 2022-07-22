import 'package:e_shoppie/pages/home_page.dart';
import 'package:e_shoppie/pages/register_new_user_page.dart';
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
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Firebase.initializeApp();
    isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.purple[50],
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   title: Text(
      //     'Login',
      //     style: TextStyle(
      //       color: Colors.red.shade900,
      //     ),
      //   ),
      //   elevation: 5,
      // ),
      body: Stack(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(top: 300),
          //   child: Center(
          //     // alignment: Alignment.center,
          //     child: Center(
          //       child: Form(
          //         key: _formKey,
          //         child: Column(
          //           children: [
          //             Padding(
          //               padding: EdgeInsets.all(8.0),
          //               child: Material(
          //                 borderRadius: BorderRadius.circular(20.0),
          //                 color: Colors.red.withOpacity(0.5),
          //                 elevation: 0.0,
          //                 child: Padding(
          //                   padding: EdgeInsets.only(left: 12.0),
          //                   child: TextFormField(
          //                     controller: _emailTextController,
          //                     decoration: InputDecoration(
          //                       // labelText: "Email*",
          //                       hintText: "Email",
          //                       // border: OutlineInputBorder().,
          //                       icon: Icon(
          //                         Icons.email,
          //                       ),
          //                       // isDense:true
          //                     ),
          //                     keyboardType: TextInputType.emailAddress,
          //                     validator: (value) {
          //                       if (value!.isEmpty) {
          //                         Pattern pattern =
          //                             r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          //                         RegExp regex =
          //                             new RegExp(pattern.toString());
          //                         if (!regex.hasMatch(value))
          //                           return 'Please make sure your email address is valid';
          //                         else
          //                           return null;
          //                       }
          //                     },
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: EdgeInsets.all(8.0),
          //               child: Material(
          //                 borderRadius: BorderRadius.circular(20.0),
          //                 color: Colors.red.withOpacity(0.5),
          //                 elevation: 0.0,
          //                 child: Padding(
          //                   padding: EdgeInsets.only(left: 12.0),
          //                   child: TextFormField(
          //                     controller: _passwordTextController,
          //                     decoration: InputDecoration(
          //                       // labelText: "Email*",
          //                       hintText: "Password",
          //                       // border: OutlineInputBorder().,
          //                       icon: Icon(
          //                         Icons.lock,
          //                       ),
          //                       // isDense:true
          //                     ),
          //                     keyboardType: TextInputType.visiblePassword,
          //                     validator: (value) {
          //                       if (value!.isEmpty) {
          //                         return "The password field cannot be empty";
          //                       } else if (value.length < 8) {
          //                         return "The password has to be atleast 8 characters long";
          //                       }
          //                       return null;
          //                     },
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: EdgeInsets.all(8.0),
          //               child: Material(
          //                   borderRadius: BorderRadius.circular(30.0),
          //                   color: Colors.blue.withOpacity(0.8),
          //                   elevation: 0.0,
          //                   child: MaterialButton(
          //                     minWidth: MediaQuery.of(context).size.width,
          //                     child: Text(
          //                       'Login: ',
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                         color: Colors.white,
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                     ),
          //                     onPressed: () {
          //                       //
          //                     },
          //                   )),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Text(
                    'E Shoppie'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 50,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Material(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.purple[400]!.withOpacity(0.9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  obscureText: false,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  controller: _emailTextController,
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white70),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),

                                      // labelText: "Email*",
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      hintText: "Email",
                                      // border: OutlineInputBorder().,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.email_outlined,
                                          color: Colors.white,
                                        ),
                                      )
                                      // isDense:true
                                      ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex =
                                          new RegExp(pattern.toString());
                                      if (!regex.hasMatch(value))
                                        return 'Please make sure your email address is valid';
                                      else
                                        return null;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  obscureText: true,
                                  cursorColor: Colors.black,
                                  controller: _passwordTextController,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    hintText: "Password",
                                    // border: OutlineInputBorder().,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.password,
                                        color: Colors.white,
                                      ),
                                    ),

                                    // isDense:true
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex =
                                          new RegExp(pattern.toString());
                                      if (!regex.hasMatch(value))
                                        return 'Please make sure your password is at least 8 characters long';
                                      else
                                        return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Material(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.purple[900],
                          elevation: 0.0,
                          child: MaterialButton(
                            // minWidth: MediaQuery.of(context).size.width.,
                            child: Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              //
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Column(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              //Go to sign up page
                              Navigator.pushNamed(context, SignUp.id);
                            },
                            child: Text(
                              'Don\'t have an account? Sign Up',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          )
                          // RichText(
                          //   text: TextSpan(
                          //     // text: 'Don\'t have an account?',
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.w700,
                          //       fontSize: 15,
                          //     ),
                          //     children: [
                          //       TextSpan(
                          //         text: "Don't have an account?   ",
                          //         // style:
                          //         //     TextStyle(fontWeight: FontWeight.bold)
                          //       ),
                          //       TextSpan(
                          //         text: 'Sign Up!',
                          //         style: TextStyle(
                          //           color: Colors.purple[900],
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 15,
                          //           decoration: TextDecoration.underline,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'OR'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //====GOOGLE SIGN IN BUTTON====

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.purple[900],
                      elevation: 10,
                      side: BorderSide(width: 0.5, color: Colors.red),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage("images/google_logo.png"),
                            height: 35.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      handleSignIn();
                    },
                  ),
                ),
              ),
            ],
          ),
          Visibility(
              visible: isLoading,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.7),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ))
        ],
      ),
      // bottomNavigationBar:
    );
  }

  void isSignedIn() async {
    // setState(() {
    //   isLoading = true;
    // });
    preferences = await SharedPreferences.getInstance();

    User? currentUser = await FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      isLoggedIn = await googleSignIn.isSignedIn();
    }
    if (isLoggedIn) {
      Navigator.popAndPushNamed(context, HomePage.id);
      setState(() {
        // isLoading = false;
      });
    }
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
            .collection('users')
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
        Navigator.popAndPushNamed(context, HomePage.id);
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
