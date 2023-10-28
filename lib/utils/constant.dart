import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Constant{
  static String assetImagePath = "assets/images/";
  static const String fontsFamily = "SF UI Text";

  static String saveDirectory = '/ebook';
  static const double defScreenWidth = 414;
  static const double width = 480;
  static const double defScreenHeight = 896;
  static format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  static closeApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemNavigator.pop();
    });
  }

  static sendToNext(BuildContext context, String route, {Object? arguments}) {
    if (arguments != null) {
      Get.toNamed(route, arguments: arguments);
    } else {
      Get.toNamed(route);
    }
  }

  static sendToNextWithResult(BuildContext context, Widget route,Function function) {
    Get.to(route)!.then((value) {
      function();
    });
  }


  static launchURL(String url) async {
    if (await launchUrl((Uri.parse(url)))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static backToFinish() {
    Get.back();
  }

  static String getTimeFromSec(int sec) {
    final d1 = Duration(seconds: sec);
    return format(d1);
  }

  }

initializeScreenSize(BuildContext context,
    {double width = 428, double height = 896}) {
    // {double width = 414, double height = 896}) {
  ScreenUtil.init(context, designSize: Size(width, height), minTextAdapt: true);
}


launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch ';
  }
}


