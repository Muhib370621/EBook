// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';
import '../../../utils/color_category.dart';
import '../../../utils/constant.dart';
import '../../../utils/constantWidget.dart';

class OthorReviewsScreen extends StatefulWidget {
  const OthorReviewsScreen({Key? key}) : super(key: key);

  @override
  State<OthorReviewsScreen> createState() => _OthorReviewsScreenState();
}

class _OthorReviewsScreenState extends State<OthorReviewsScreen> {

  ReviewsScreenController reviewsScreenController = Get.put(ReviewsScreenController());
  void backClick() {
    Constant.backToFinish();
  }

  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Scaffold(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              getCustumAppbar(
                  leftIcon: Get.isDarkMode?"left_arrow_white.svg":"back_arrow.svg",
                  rightPermission: false,
                  title: "Reviews",
                  leftFunction: () {
                    backClick();
                  },
                  givecolor: context.theme.focusColor,
                  titlecolor: context.theme.primaryColor),
              getVerSpace(20.h),
              Expanded(child: Container(
                color: context.theme.focusColor,
                child: ListView(
                  physics: BouncingScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 20.h),
                  children: [

                    review_format("user1st.png", "Maria Sana",
                        "This Novel Is Awasome I Love It But End is So Sad.",
                        "1 h Ago", context.theme.focusColor,
                        context.theme.primaryColor),
                    getVerSpace(10.h),
                    Divider(color: grey20),
                    getVerSpace(10.h),
                    review_format("user2nd.png", "Maria Sana",
                        "This Novel Is Awasome I Love It But End is So Sad.",
                        "2 d ago", context.theme.focusColor,
                        context.theme.primaryColor),
                    getVerSpace(10.h),
                    Divider(color: grey20),
                    getVerSpace(10.h),
                    review_format("user3rd.png", "Maria Sana",
                        "This Novel Is Awasome I Love It But End is So Sad.",
                        "2 d ago", context.theme.focusColor,
                        context.theme.primaryColor),
                  ],
                ),
              ).paddingOnly(bottom: 20.h))
            ]),
      ),
    ));
  }
}
