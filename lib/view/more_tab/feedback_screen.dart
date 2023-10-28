import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mailto/mailto.dart';
import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {

  void backClick() {
    Constant.backToFinish();
  }

  TextEditingController feedBackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SafeArea(
            child: getDefaultWidget(Column(
              children: [
                getCustumAppbar(
                    leftIcon: Get.isDarkMode?"left_arrow_white.svg":"back_arrow.svg",
                    rightPermission: false,
                    title: "Feedback",
                    leftFunction: () {
                      backClick();
                    },
                    givecolor: context.theme.focusColor,
                    titlecolor: context.theme.primaryColor),
                getVerSpace(20.h),
                Expanded(
                  child: Container(
                    color: context.theme.focusColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getVerSpace(21.h),
                        getCustomFont("Give us feedback", 20.sp, context.theme.primaryColor, 1,
                            fontWeight: FontWeight.w700),
                        getVerSpace(8.h),
                        getCustomFont(
                            "Your opinion matters to us!", 16.sp, context.theme.primaryColor, 1,
                            fontWeight: FontWeight.w400),
                        getVerSpace(40.h),
                        getCustomFont("What do you like about this app?", 16.sp,
                            context.theme.primaryColor, 1,
                            fontWeight: FontWeight.w700),
                        getVerSpace(10.h),
                        TextFormField(
                          controller: feedBackController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12.h))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.h),
                                  borderSide: BorderSide(
                                      color: maximumOrange, width: 1.w)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.h),
                                  borderSide: BorderSide(
                                      color: grey20, width: 1.w)),
                              hintText: 'Write your feedback...',
                              hintStyle: TextStyle(
                                  color: Color(0XFF7D7883),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: Constant.fontsFamily)),
                          maxLines: 14,
                        ),
                        Spacer(),
                        getCustomButton("Submit", () async {

                          String feedback = "";

                          if (feedBackController.value.text.isNotEmpty) {
                            feedback = feedBackController.text.toString();
                          }
                          final mailtoLink = Mailto(
                            to: ['to@example.com'],

                            subject: 'Feedback',
                            body: feedback,
                          );
                          await launchURL('$mailtoLink');

                          // backClick();

                        }),
                        getVerSpace(20.h)
                      ],
                    ).paddingSymmetric(horizontal: 20.h),
                  ).paddingOnly(bottom: 20.h),
                ),

              ],
            )),
        ),
      ),
    );
  }
}
