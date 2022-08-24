import 'package:e_shoppie/provider/user_provider.dart';
import 'package:e_shoppie/themes/lightTheme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static final String id = 'Register Screen';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isVisible = true;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _middleNameTextController = TextEditingController();
  TextEditingController _firstNameTextController = TextEditingController();
  TextEditingController _lastNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('SignUp'),
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),

                  //=====Form====
                  Container(
                    width: screenWidth * 0.90,
                    height: screenHeight * 0.75,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //====IMAGE====
                                    //====First Name====
                                    SizedBox(
                                      height: constraints.maxHeight * 0.02,
                                    ),
                                    //15
                                    Row(
                                      //15
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height:
                                                constraints.maxHeight * 0.15,
                                            child: TextFormField(
                                              cursorColor: Colors.black,
                                              controller:
                                                  _firstNameTextController,
                                              keyboardType: TextInputType.name,
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value.trim() == '') {
                                                  return 'Name cannot be empty';
                                                } else
                                                  return null;
                                              },
                                              decoration:
                                                  formInputDecoration.copyWith(
                                                hintText: 'First Name',
                                                prefixIcon: Icon(
                                                  Icons.person,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: constraints.maxWidth * 0.02,
                                        ),
                                        //==== Middle Name====
                                        Expanded(
                                          child: Container(
                                            height:
                                                constraints.maxHeight * 0.15,
                                            child: TextFormField(
                                              cursorColor: Colors.black,
                                              controller:
                                                  _middleNameTextController,
                                              keyboardType: TextInputType.name,
                                              validator: (value) {
                                                if (value!.isNotEmpty &&
                                                    value.trim() == '') {
                                                  return 'Middle should either be empty or should have valid characters';
                                                } else
                                                  return null;
                                              },
                                              decoration:
                                                  formInputDecoration.copyWith(
                                                hintText: 'Middle Name',
                                                prefixIcon: Icon(
                                                  Icons.person,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //====Last Name=====  //15
                                    Container(
                                      height: constraints.maxHeight * 0.15,
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        controller: _lastNameTextController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.trim() == '') {
                                            return 'Last name cannot be empty';
                                          } else
                                            return null;
                                        },
                                        decoration:
                                            formInputDecoration.copyWith(
                                          hintText: 'Last Name',
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //=====Email====  //15
                                    Container(
                                      height: constraints.maxHeight * 0.15,
                                      child: TextFormField(
                                        obscureText: false,
                                        cursorColor: Colors.black,
                                        controller: _emailTextController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter email';
                                          } else {
                                            if (!EmailValidator.validate(
                                                value)) {
                                              return 'Wrong email id';
                                            } else {
                                              return null;
                                            }
                                          }
                                        },
                                        decoration:
                                            formInputDecoration.copyWith(
                                          hintText: 'Email',
                                          prefixIcon: Icon(
                                            Icons.email_sharp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //=====Password=====  //15
                                    Container(
                                      height: constraints.maxHeight * 0.15,
                                      child: TextFormField(
                                        obscureText: _isVisible,
                                        cursorColor: Colors.black,
                                        controller: _passwordTextController,
                                        decoration:
                                            formInputDecoration.copyWith(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              _isVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                _isVisible = !_isVisible;
                                              });
                                            },
                                          ),
                                          hintText: 'Password',
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.black,
                                          ),
                                        ),
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
                                      ),
                                    ),
                                    //=====Confirm Password====  //15
                                    Container(
                                      height: constraints.maxHeight * 0.15,
                                      child: TextFormField(
                                        obscureText: _isVisible,
                                        cursorColor: Colors.black,
                                        controller: _confirmPasswordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "The password field cannot be empty!";
                                          } else if (value.length < 8) {
                                            return "The password length should be not less than 8";
                                          } else if (_passwordTextController
                                                  .text !=
                                              value) {
                                            return "Passwords do not match";
                                          }
                                          return null;
                                        },
                                        decoration:
                                            formInputDecoration.copyWith(
                                          hintText: 'Confirm Password',
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //10
                                    Container(
                                      height: constraints.maxHeight * 0.10,
                                      child: Center(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.purple[900]),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (!await provider.signUp(
                                                _firstNameTextController.text,
                                                _middleNameTextController.text,
                                                _lastNameTextController.text,
                                                _emailTextController.text,
                                                _passwordTextController.text,
                                              )) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            ' In Failed')));
                                              }
                                              Navigator.pop(context);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    content: Text('Failed')),
                                              );
                                            }
                                          },
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 2),
                                              child: Text(
                                                'Register',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  Container(
                    height: screenHeight * 0.04,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Already have an account? Log In!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox(), flex: 4),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
