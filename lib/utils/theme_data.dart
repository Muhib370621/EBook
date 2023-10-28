
import 'package:ebook_app/utils/color_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
/////whiteContainer ==focusColor
class Themes {
  static final light = ThemeData.light().copyWith(
   bottomAppBarTheme: BottomAppBarTheme(color: regularBlack),
    scaffoldBackgroundColor: bgColor,
    // backgroundColor: bgColor,
    // buttonColor: Colors.cyan,
    // ignore: deprecated_member_use
    bottomAppBarColor: Colors.cyan,
   indicatorColor: indicatorColor,
   primaryColor: regularBlack,
    focusColor: Colors.white,

    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.cyan,
      textTheme: ButtonTextTheme.primary,

    ),
  );
  static final dark = ThemeData.dark().copyWith(
    // backgroundColor: ,
    scaffoldBackgroundColor: Colors.black,
    // buttonColor: Colors.deepPurple,
    primaryColor: regularWhite,
    indicatorColor: indicatorColor,
    focusColor: Colors.black,
    // ignore: deprecated_member_use
    bottomAppBarColor: Colors.deepPurple,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.deepPurple,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}


getLoginBackgroundColor(BuildContext context){
    return context.theme.focusColor;
}