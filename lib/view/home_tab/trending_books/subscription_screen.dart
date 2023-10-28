import 'package:ebook_app/models/book_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';
import '../../../utils/color_category.dart';
import '../../../utils/constant.dart';
import '../../../utils/constantWidget.dart';


// ignore: must_be_immutable
class SubscriptionScreen extends StatefulWidget {
  StoryModel storyModel;
  SubscriptionScreen({Key? key,required this.storyModel});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  SubscritionScreenController subcriptionScreenController =
      Get.put(SubscritionScreenController());

  void backClick() {
    Constant.backToFinish();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SafeArea(
            child: GetBuilder<SubscritionScreenController>(
          init: SubscritionScreenController(),
          builder: (subcriptionScreenController) => Column(
            children: [
              getCustumAppbar(
                  rightPermission: false,
                  leftIcon: Get.isDarkMode?"left_arrow_white.svg":"back_arrow.svg",
                  title: "Upgrade Plans",
                  leftFunction: () {
                    backClick();
                  },
              titlecolor: context.theme.primaryColor,
              givecolor: context.theme.focusColor),
              getVerSpace(20.h),
              Container(
                height: 180.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.h),
                    color: context.theme.focusColor,
                    image: DecorationImage(
                        image: AssetImage(
                          "${Constant.assetImagePath}upgrade_plans_banner.png",
                        ),
                        fit: BoxFit.fill)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getVerSpace(33.h),
                    getMultilineCustomFont(
                            "Read any book", 20.sp, maximumOrange,
                            fontWeight: FontWeight.w700, txtHeight: 1.5.h)
                        .paddingOnly(left: 24.h, right: 227.h),
                    getVerSpace(11.sp),
                    getMultilineCustomFont(
                            "Get plan to access", 14.sp, regularBlack,
                            fontWeight: FontWeight.w400, txtHeight: 1.5.h)
                        .paddingOnly(left: 24.h, right: 269.h),
                  ],
                ),
              ).paddingSymmetric(horizontal: 20.h),
              getVerSpace(20.h),
              Container(
                color: context.theme.focusColor,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getCustomFont("Choose your plan", 20.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w700),
                    getVerSpace(12.h),
                   your_plane("Access all features", "\$50.00 / Month", 1,context.theme.focusColor,context.theme.primaryColor),
                    getVerSpace(20.h),
                   your_plane("Access all features", "\$120.00 / 3 Month", 2,context.theme.focusColor,context.theme.primaryColor),
                    getVerSpace(20.h),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.h),
                          color: Get.isDarkMode?grey:grey10,
                        ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap:(){
                              subcriptionScreenController.onRemoveAds();
                            },
                            child: Row(
                              children: [
                                getSvgImage(subcriptionScreenController.removeAds?"select_icon.svg":"orange_circle.svg",height: 16.h,width: 16.h),
                                getHorSpace(8.h),
                                getCustomFont("Remove Ads", 14.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w400,txtHeight: 1.5.h),
                              ],
                            ),
                          ),
                          getVerSpace(12.h),
                          GestureDetector(
                            onTap: (){
                              subcriptionScreenController.onUnlimitedPlane();
                            },
                            child: Row(
                              children: [
                                getSvgImage(subcriptionScreenController.unlimitedPlane?"select_icon.svg":"orange_circle.svg",height: 16.h,width: 16.h),
                                getHorSpace(8.h),
                                getCustomFont("Unlimited workouts plans", 14.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w400,txtHeight: 1.5.h),
                              ],
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 20.h,vertical: 20.h),
                    ),
                    getVerSpace(20.h),
                    getMultilineCustomFont("There are many variations of passages of lorem ipsum available, but the majority have suffered alteration", 14.sp, context.theme.primaryColor,fontWeight: FontWeight.w400,txtHeight: 1.5.h),
                    getVerSpace(30.h),
                    getCustomButton("Continue", (){

                      // Constant.sendToNextWithResult(context, ReadBookScreen(storyModel: widget.storyModel,topAuthors: ),(){});


                      // Constant.sendToNext(context, Routes.readBookScreenRoute);
                    }).paddingOnly(bottom: 3.h)

                  ],
                ).paddingSymmetric(vertical: 20.h,horizontal: 20.h),
              )
            ],
          ),
        )),
      ),
    );
  }
}

Widget your_plane(String planeName,String planeRate,int id,Color color,Color fontColor){
  return  GetBuilder<SubscritionScreenController>(
    init: SubscritionScreenController(),
    builder:(upgradePlanScreenController) => GestureDetector(
      onTap: (){
        upgradePlanScreenController.onSetplaneId(id);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.h),
            color: color,
            border: Border.all(color: upgradePlanScreenController.planeId==id?maximumOrange:grey30)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getCustomFont(planeName, 16.sp, fontColor, 1,fontWeight: FontWeight.w700),
                    getVerSpace(6.h),
                    getCustomFont(planeRate, 16.sp, fontColor, 1,fontWeight: FontWeight.w400),
                  ],
                ),
                upgradePlanScreenController.planeId==id?getSvgImage("select_icon.svg",height: 24.h,width: 24.h):const SizedBox(),
              ],
            ).paddingOnly(left: 20.h,right: 23.h,top: 20.h,bottom: 20.h)
          ],
        ),
      ),
    ),
  );
}

Widget plane_features(String featuresName,Function function){
  return   GestureDetector(
    onTap: (){
      function();
    },
    child: Row(
      children: [
        getSvgImage("select_icon.svg",height: 16.h,width: 16.h),
        getHorSpace(8.h),
        getCustomFont(featuresName, 14.sp, regularBlack, 1,fontWeight: FontWeight.w400),
      ],
    ),
  );
}
