import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  AddNewCategoryScreenController addNewCategoryScreenController =
  Get.put(AddNewCategoryScreenController());

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
            child: GetBuilder<AddNewCategoryScreenController>(
              init: AddNewCategoryScreenController(),
              builder: (addNewCategoryScreenController) => Column(
                children: [
                  getCustumAppbar(
                      leftIcon: Get.isDarkMode
                          ? "left_arrow_white.svg"
                          : "back_arrow.svg",
                      rightPermission: false,
                      title: "Add Category",
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
                                      getCustomFont("Category name", 15.h,
                                          context.theme.primaryColor, 1,
                                          fontWeight: FontWeight.w600),
                                      getVerSpace(6.h),
                                      getTextField(context.theme.focusColor, "Category Name"),
                                      getVerSpace(20.h),
                                      getCustomFont("PDF File", 15.h,
                                          context.theme.primaryColor, 1,
                                          fontWeight: FontWeight.w600),
                                      getVerSpace(6.h),
                                      getTextField(context.theme.focusColor, "Enter URL",suffixIconPermission: true,height: 56.h,suffixWidget: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.h),
                                            color:lightGrey ),
                                        child:getCustomFont("Choose File", 15.sp, grey, 1,fontWeight: FontWeight.w500).paddingSymmetric(horizontal: 13.h,vertical: 7.h),
                                      ).paddingAll(10.h)),
                                      getVerSpace(10.h),

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
