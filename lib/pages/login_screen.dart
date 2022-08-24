import 'package:e_shoppie/pages/register_new_user_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Consumer<UserProvider>(builder: (context, provider, child) {
      return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //==== TITLE ====
                Expanded(child: SizedBox(), flex: 2),

                Expanded(
                  flex: 8,
                  child: Container(
                    color: Colors.white,
                    height: (screenSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.08,
                    width: screenSize.width * 0.9,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'E Shoppie'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox(), flex: 2),
                Expanded(
                  flex: 30,
                  child: Container(
                    height: (screenSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.42,
                    width: screenSize.width * 1,
                    child: Image.asset(
                      'images/logo.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(child: SizedBox(), flex: 2),
                Expanded(
                  flex: 44,
                  child: Container(
                    width: screenSize.width * 0.90,
                    height: (screenSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: LayoutBuilder(
                      builder: (context, formConstraints) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: formConstraints.maxWidth * 0.02,
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //====EMAIL====
                                    TextFormField(
                                      obscureText: false,
                                      cursorColor: Colors.black,
                                      textInputAction: TextInputAction.next,
                                      controller: _emailTextController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Email field cannot be empty!';
                                        } else {
                                          if (!EmailValidator.validate(value)) {
                                            return 'Please make sure your email address is valid';
                                          } else {
                                            return null;
                                          }
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black45,
                                        ),
                                        prefixIcon: Icon(
                                          Icons.email_sharp,
                                          color: Colors.black,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.black54,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: formConstraints.maxHeight * 0.05,
                                    ),
                                    //====PASSWORD=====
                                    TextFormField(
                                      obscureText: true,
                                      cursorColor: Colors.black,
                                      controller: _passwordTextController,
                                      textInputAction: TextInputAction.done,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter password';
                                        } else {
                                          RegExp regex = RegExp(
                                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                          if (!regex.hasMatch(value)) {
                                            return 'Enter valid password';
                                          } else {
                                            return null;
                                          }
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black45,
                                        ),
                                        prefixIcon: Icon(
                                          Icons.password_sharp,
                                          color: Colors.black,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.black54,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //====Forgot Password====
                                    SizedBox(
                                      height: formConstraints.maxHeight * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: FittedBox(
                                            child: Text(
                                              'Forgot Password',
                                              style: TextStyle(
                                                color: Colors.black,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //====LOGIN BUTTON====
                            Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.purple[900]),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                child: Container(
                                  height: formConstraints.maxHeight * 0.1,
                                  width: formConstraints.maxWidth * 0.5,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      child: Text(
                                        'Login',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (!await provider.signIn(
                                        _emailTextController.text,
                                        _passwordTextController.text)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Sign In Failed'),
                                        ),
                                      );
                                    }
                                  } else {
                                    SnackBar(
                                        backgroundColor: Colors.black,
                                        content: Text('Failed'));
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: formConstraints.maxWidth * 0.02,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      //Go to sign up page
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignUp()));
                                      // Navigator.pushNamed(context, SignUp.id);
                                    },
                                    child: FittedBox(
                                      child: Text(
                                        'Create Account',
                                        style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //====GOOGLE SIGN IN BUTTON====

                                  InkWell(
                                    onTap: () async {
                                      provider.signInWithGoogle();
                                    },
                                    child: FittedBox(
                                      child: Text(
                                        'Sign In With Google',
                                        style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Expanded(child: SizedBox(), flex: 10),
              ],
            ),
          ),
        ),
      );
    });
  }
}
