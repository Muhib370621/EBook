import 'package:ebook_app/utils/constantWidget.dart';
import 'package:ebook_app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      backgroundColor: getLoginBackgroundColor(context),
      body: SafeArea(
        child: Column(
          children: [
            getSvgImage("pass.svg",height: 112.h,width: 112.h),
            getVerSpace(40.h),
            getCustomFont("Password Changed", 28.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w700,textAlign: TextAlign.center)
          ],
        ),
        
      ),
    ), onWillPop: () async {return false;});
  }
}
