import 'package:e_shoppie/pages/home_page.dart';
import 'package:e_shoppie/pages/login_screen.dart';
import 'package:e_shoppie/pages/register_new_user_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'Login Screen':
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case 'Sign Up Screen':
        return MaterialPageRoute(builder: (context) => SignUp());

      case 'Home Screen':
        return MaterialPageRoute(builder: (context) => HomePage());
      default:
        return MaterialPageRoute(builder: (context) => LoginScreen());
    }
  }
}
