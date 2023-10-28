import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class AddAuthorScreen extends StatefulWidget {
  const AddAuthorScreen({Key? key}) : super(key: key);

  @override
  State<AddAuthorScreen> createState() => _AddAuthorScreenState();
}

class _AddAuthorScreenState extends State<AddAuthorScreen> {
  AddAuthorScreenController addAuthorScreenControllerController =
  Get.put(AddAuthorScreenController());

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
        resizeToAvoidBottomInset: false,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SafeArea(
            child: GetBuilder<AddAuthorScreenController>(
              init: AddAuthorScreenController(),
              builder: (addAuthorScreenController) => Column(
                children: [
                  getCustumAppbar(
                      leftIcon: Get.isDarkMode
                          ? "left_arrow_white.svg"
                          : "back_arrow.svg",
                      rightPermission: false,
                      title: "Add Author",
                      leftFunction: () {
                        backClick();
                      },
                      givecolor: context.theme.focusColor,
                      titlecolor: context.theme.primaryColor),
                  getVerSpace(20.h),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.h),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 16),
                            blurRadius: 31,
                            color: Color(0XFFACBFC1).withOpacity(0.10),
                          )
                        ],
                        color: context.theme.focusColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                getCustomFont("Name", 15.h,
                                                    context.theme.primaryColor, 1,
                                                    fontWeight: FontWeight.w600,textAlign: TextAlign.right),
                                                getVerSpace(6.h),
                                                getTextField(context.theme.focusColor, "Enter Name"),
                                              ],
                                            ),
                                          ),
                                          getHorSpace(19.h),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                getCustomFont("Designation", 15.h,
                                                    context.theme.primaryColor, 1,
                                                    fontWeight: FontWeight.w600),
                                                getVerSpace(6.h),
                                                getTextField(context.theme.focusColor, "Enter Designation"),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),

                                      getVerSpace(20.h),
                                      getCustomFont("Description", 15.h,
                                          context.theme.primaryColor, 1,
                                          fontWeight: FontWeight.w600),
                                      getVerSpace(6.h),
                                      getTextField(context.theme.focusColor, "Enter description...",height: 124.h,line: 6,topContant: 17.h),
                                      getVerSpace(20.h),
                                      getCustomFont("Select status", 15.h,
                                          context.theme.primaryColor, 1,
                                          fontWeight: FontWeight.w600,textAlign: TextAlign.right),
                                      getVerSpace(6.h),
                                      getTextField(context.theme.focusColor, "Select status",suffixIconPermission: true,suffixWidget: Container(
                                        height: 24.h,width: 24.h,child: getSvgImage(Get.isDarkMode?"white_down_arrow_icon.svg":"down_arrow_icon.svg",height: 4.48.h,width: 10.h)).paddingAll(14.h)),
                                      getVerSpace(20.h),

                                      getCustomFont("Category image", 15.h,
                                          context.theme.primaryColor, 1,
                                          fontWeight: FontWeight.w600),
                                      getVerSpace(6.h),
                                      getTextField(context.theme.focusColor, "Enter Image URL",suffixIconPermission: true,height: 56.h,suffixWidget: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.h),
                                            color:lightGrey ),
                                        child:getCustomFont("Choose File", 15.sp, grey, 1,fontWeight: FontWeight.w500).paddingSymmetric(horizontal: 13.h,vertical: 7.h),
                                      ).paddingAll(10.h)),


                                    ],
                                  ).paddingSymmetric(vertical: 20.h, horizontal: 20.h),

                                ],
                              ),
                            ),
                          ),
                          getCustomButton("Submit", (){
                            backClick();
                          },buttonWidth: 112.h).paddingOnly(left: 20.h,right: 20.h,bottom: 20.h)
                        ],
                      ),
                    ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
                  ),


                ],
              ),
            )),
      ),
    );
  }
}
