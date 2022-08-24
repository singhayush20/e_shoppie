import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData AppTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.indigo,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: true,
    ),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(),
  ),
  listTileTheme: ListTileThemeData(
    iconColor: Colors.black,
    textColor: Colors.black,
  ),
  dividerTheme: DividerThemeData(
      color: Colors.black12, thickness: 4, indent: 10, endIndent: 10),
);

InputDecoration formInputDecoration = InputDecoration(
  hintStyle: TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.black45,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.black54,
      width: 1,
      style: BorderStyle.solid,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.black,
      width: 1,
      style: BorderStyle.solid,
    ),
  ),
);
