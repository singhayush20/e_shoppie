import 'package:e_shoppie/pages/home_page.dart';
import 'package:e_shoppie/pages/login_screen.dart';
import 'package:e_shoppie/pages/splash_screen.dart';
import 'package:e_shoppie/provider/user_provider.dart';
import 'package:e_shoppie/themes/lightTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider.initialize(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme,
        // initialRoute: LoginScreen.id,
        // routes: {
        //   SignUp.id: (context) => SignUp(),
        //   LoginScreen.id: (context) => LoginScreen(),
        //   HomePage.id: (context) => HomePage(),
        //   ItemDetails.id: (context) => ItemDetails(),
        //   Cart.id: (context) => Cart(),
        // },
        home: ScreenController(),
      ),
    );
  }
}

class ScreenController extends StatelessWidget {
  const ScreenController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.uninitialized:
        return SplashScreen();
      // case Status.authenticating:
      //   return AlertDialog(
      //     content: new Row(
      //       children: [
      //         CircularProgressIndicator(),
      //         Container(
      //             margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      //       ],
      //     ),
      //   );
      case Status.unauthenticated:
        return LoginScreen();
      case Status.authenticated:
        return HomePage();
      default:
        return LoginScreen();
    }
  }
}
