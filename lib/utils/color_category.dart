// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 Color bgColor = "#FAFAFA".toColor();
 // Color bgColor = "#FAFAFA".toColor();
 Color maximumOrange = "#F46F4C".toColor();
Color regularBlack = "#000000".toColor();
Color regularWhite  = "#FFFFFF".toColor();
Color grey = '#696969'.toColor();
Color grey20 = '#EEEEEE'.toColor();
Color grey10 = bgColor;
Color grey30 = '#D7D7D7'.toColor();
Color lightGrey = '#F8F8F8'.toColor();
Color indicatorColor = '#D6D8D8'.toColor();


extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}


setStatusBarColor(Color color){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: color,
  ));
}

