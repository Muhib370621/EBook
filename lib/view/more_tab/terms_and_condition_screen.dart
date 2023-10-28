import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {

  void backClick() {
    Constant.backToFinish();
  }


  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Scaffold(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            body: getDefaultWidget(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              getCustumAppbar(
                  leftIcon: Get.isDarkMode?"left_arrow_white.svg":"back_arrow.svg",
                  rightPermission: false,
                  title: "Terms & conditions",
                  leftFunction: () {
                    backClick();
                  },
                  givecolor: context.theme.focusColor,
                  titlecolor: context.theme.primaryColor),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      color: context.theme.focusColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          question('1.Types of data we collect'),
                          getVerSpace(16.h),
                          answer(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),

                        ],
                      ).paddingSymmetric(horizontal: 20.h,vertical: 20.h),
                    ).paddingSymmetric(vertical: 10.h),
                    Container(
                      color: context.theme.focusColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          question('2. Use of your personal Data'),
                          getVerSpace(16.h),
                          answer(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                        ],
                      ).paddingSymmetric(horizontal: 20.h,vertical: 20.h),
                    ).paddingSymmetric(vertical: 10.h),
                    Container(
                      color: context.theme.focusColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          question('3. Disclosure of your personal Data'),
                          getVerSpace(16.h),
                          answer(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                        ],
                      ).paddingSymmetric(horizontal: 20.h,vertical: 20.h),
                    ).paddingSymmetric(vertical: 10.h),
                  ],
                ),
              )
            ]))),
      ),
    );
  }

  question(String s) {
    return getMultilineCustomFont(s, 18.sp, context.theme.primaryColor,fontWeight: FontWeight.w700,txtHeight: 1.5.h);


  }

  answer(String s) {
    return getMultilineCustomFont(s, 14.sp, grey,fontWeight: FontWeight.w400,txtHeight: 1.5.h);


  }
}
