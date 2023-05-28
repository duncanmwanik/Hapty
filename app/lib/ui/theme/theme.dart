import 'package:flutter/material.dart';

// --------------------------------- Styling ---------------------------------
Color primaryColor = Color.fromARGB(0, 0, 0, 0);
Color secondaryColor = Color(0xFF141515);
Color themeColor = Colors.red;
Color customColor = Colors.white24;
Color custom2Color = Colors.white10;

double borderRadius =  20;

ThemeData appTheme = ThemeData(
  primaryColor: Color.fromARGB(0, 0, 0, 0),
  // fontFamily: "Poppins",
);

TextStyle alarmAddDescriptions = TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

BoxDecoration backgoundImage = BoxDecoration(
  image: DecorationImage(
    image: AssetImage("assets/images/back.jpg"),
    fit: BoxFit.cover,
  ),
);
