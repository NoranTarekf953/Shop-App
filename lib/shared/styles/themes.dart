import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';

var darkTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: HexColor('#262626'),
    appBarTheme: AppBarTheme(
      color: Colors.white,
        actionsIconTheme:  IconThemeData(color:  HexColor('#262626')),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.white),
        backgroundColor: Colors.white,
        elevation: 0),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor('#262626'),
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey),
    textTheme: const TextTheme(
        bodyMedium: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white)));

var lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  // applyElevationOverlayColor: false,
  textTheme:  TextTheme(
    headlineMedium: TextStyle(
          //fontSize: 30,
           fontWeight: FontWeight.w900, 
           color: defaultColor),
      bodyMedium: const TextStyle(
          fontSize: 18,
           fontWeight: FontWeight.w400, 
           color: Colors.black)),
  appBarTheme: AppBarTheme(
    actionsIconTheme: const IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.grey[200]),
    titleTextStyle: GoogleFonts.merriweather(
        fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500),
    backgroundColor: Colors.white,
    elevation: 0,

    //systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.grey[200])
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[200],
      
      elevation: 0,
      type: BottomNavigationBarType.fixed),

  primarySwatch: defaultColor,
  // useMaterial3: true,
);
