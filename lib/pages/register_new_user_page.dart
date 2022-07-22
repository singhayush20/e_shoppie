import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/user_services.dart';
import 'home_page.dart';

class SignUp extends StatefulWidget {
  static final String id = 'Register Screen';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth? firebaseAuth = FirebaseAuth.instance;
  User? user;
  UserServices userServices = new UserServices();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _NameTextController = TextEditingController();
  String gender = "male";
  String groupValue = 'male';
  SharedPreferences? preferences;
  bool isLoading = false;
  bool isLoggedIn = false;

  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.purple[50],
      body: Stack(
        children: [
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
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  controller: _NameTextController,
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
                                    hintText: "Name",
                                    // border: OutlineInputBorder().,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // isDense:true
                                  ),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      Pattern pattern =
                                          'The Name cannot be empty';
                                      RegExp regex =
                                          new RegExp(pattern.toString());
                                      if (!regex.hasMatch(value))
                                        return 'Name cannot be empty';
                                      else
                                        return null;
                                    }
                                  },
                                ),
                              ),
                              Row(
                                children: [
                                  // Text(
                                  //   'Gender: ',
                                  //   style: TextStyle(
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'Male',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: Radio(
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Colors.white),
                                        value: "male",
                                        groupValue: groupValue,
                                        onChanged: (e) => valueChanged(e),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'Female',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: Radio(
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Colors.white),
                                        value: "female",
                                        groupValue: groupValue,
                                        onChanged: (e) => valueChanged(e),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                  obscureText: _isVisible,
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
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _isVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _isVisible = !_isVisible;
                                          });
                                        },
                                      ),
                                    ),
                                    // isDense:true
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      // Pattern pattern =
                                      //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      // RegExp regex =
                                      //     new RegExp(pattern.toString());
                                      // if (!regex.hasMatch(value))
                                      //   return 'Please make sure your password is at least 8 characters long';
                                      // else
                                      //   return null;
                                      if (value.isEmpty) {
                                        return "The password field cannot be empty";
                                      } else if (value.length < 8) {
                                        return "Password length should be greater than 8";
                                      }
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  obscureText: _isVisible,
                                  cursorColor: Colors.black,
                                  controller: _confirmPasswordController,
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
                                    hintText: "Confirm Password",
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
                                    // if (value!.isEmpty) {
                                    //   Pattern pattern =
                                    //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    //   RegExp regex =
                                    //       new RegExp(pattern.toString());
                                    //   if (!regex.hasMatch(value))
                                    //     return 'Please make sure your password is at least 8 characters long';
                                    //   else if()
                                    //     return null;
                                    // }
                                    if (value!.isEmpty) {
                                      return "The password field cannot be empty!";
                                    } else if (value.length < 8) {
                                      return "The password length should be not less than 8";
                                    } else if (_passwordTextController.text !=
                                        value) {
                                      return "Passwords do not match";
                                    }
                                    return null;
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
                              'Sign Up and Register',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              //
                              validateForm();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      // Column(
                      //   children: [
                      //     TextButton(
                      //       style: TextButton.styleFrom(
                      //         textStyle: const TextStyle(fontSize: 20),
                      //       ),
                      //       onPressed: () {},
                      //       child: const Text(
                      //         'Forgot Password',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           decoration: TextDecoration.underline,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Log In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),

              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width * 0.05),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         flex: 2,
              //         child: Divider(
              //           thickness: 2,
              //           color: Colors.black,
              //         ),
              //       ),
              //       Expanded(
              //         flex: 1,
              //         child: Text(
              //           'OR'.toUpperCase(),
              //           style: TextStyle(
              //             fontWeight: FontWeight.w600,
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //       Expanded(
              //         flex: 2,
              //         child: Divider(
              //           thickness: 2,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.05,
              // ),
              //====GOOGLE SIGN IN BUTTON====

              //     Padding(
              //       padding: EdgeInsets.symmetric(
              //           horizontal: MediaQuery.of(context).size.width * 0.1),
              //       child: Material(
              //         borderRadius: BorderRadius.circular(30),
              //         child: OutlinedButton(
              //           style: OutlinedButton.styleFrom(
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(30),
              //             ),
              //             backgroundColor: Colors.purple[900],
              //             elevation: 10,
              //             side: BorderSide(width: 0.5, color: Colors.red),
              //           ),
              //           child: Padding(
              //             padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              //             child: Row(
              //               mainAxisSize: MainAxisSize.min,
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: <Widget>[
              //                 Image(
              //                   image: AssetImage("images/google_logo.png"),
              //                   height: 35.0,
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(left: 10),
              //                   child: Text(
              //                     'Sign in with Google',
              //                     style: TextStyle(
              //                       fontSize: 20,
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.w600,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           onPressed: () async {
              //             handleSignIn();
              //           },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
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
        ],
      ),
    );
  }

  void isSignedIn() async {
    // setState(() {
    //   isLoading = true;
    // });
    preferences = await SharedPreferences.getInstance();
    if (isLoggedIn) {
      Navigator.popAndPushNamed(context, HomePage.id);
      setState(() {
        // isLoading = false;
      });
    }
  }

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = e;
      } else if (e == 'female') {
        groupValue = e;
        gender = e;
      }
    });
  }

  Future validateForm() async {
    setState(() {
      isLoading = true;
    });
    FormState? formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.reset();
      User? currentUser = await FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('currentUser=null: true');
        UserCredential credential = await firebaseAuth!
            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text);
        user = credential.user;
        FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
          "id": user!.uid,
          "email": user!.email,
          "username": _NameTextController.text.toString(),
          "gender": gender.toString()
        });
        // userServices.createUser(value.user!.uid.toString(), {
        //   "username": value.user!.displayName,
        //   "email": value.user!.email,
        //   "id": value.user!.uid,
        //   "gender": gender
        // }).catchError((e) => {print(e.toString())})

        print('User created');
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.id, (route) => false);
      }
    }
  }
}
