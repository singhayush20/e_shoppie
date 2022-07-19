import 'package:e_shoppie/pages/cart_page.dart';
import 'package:e_shoppie/pages/home_page.dart';
import 'package:e_shoppie/pages/item_details.dart';
import 'package:e_shoppie/pages/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          elevation: 15,
          color: Colors.lightGreen,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.indigo,
          ),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.white,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        listTileTheme: ListTileThemeData(
          iconColor: Colors.green[900],
          textColor: Colors.black,
        ),
        dividerTheme: DividerThemeData(
            color: Colors.black12, thickness: 0.5, indent: 10, endIndent: 10),
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomePage.id: (context) => HomePage(),
        ItemDetails.id: (context) => ItemDetails(),
        Cart.id: (context) => Cart(),
      },
    );
  }
}
