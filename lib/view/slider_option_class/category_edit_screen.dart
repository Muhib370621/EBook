import 'package:ebook_app/utils/color_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class EditCategoriesScreen extends StatefulWidget {
  const EditCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<EditCategoriesScreen> createState() => _EditCategoriesScreenState();
}

class _EditCategoriesScreenState extends State<EditCategoriesScreen> {
  EditCategoriesScreenController editCategoriesScreenController =
      Get.put(EditCategoriesScreenController());

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
            child: GetBuilder<EditCategoriesScreenController>(
          init: EditCategoriesScreenController(),
          builder: (editCategoriesScreenController) => Column(
            children: [
              getCustumAppbar(
                  leftIcon: Get.isDarkMode
                      ? "left_arrow_white.svg"
                      : "back_arrow.svg",
                  rightPermission: false,
                  title: "Edit Category",
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
                        offset: const Offset(0, 16),
                        blurRadius: 31,
                        color: const Color(0XFFACBFC1).withOpacity(0.10),
                      )
                    ],
                    color: context.theme.focusColor,
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
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
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.h),
                            color: Get.isDarkMode?context.theme.scaffoldBackgroundColor:lightGrey),child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(

                                children: [
                                  getSvgImage("pdf_logo.svg",height: 44.h,width: 44.h),
                                  getHorSpace(16.h),
                                  Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont("01_history_description.pdf", 15.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w500),
                                      getVerSpace(5.h),
                                      getCustomFont("2 MB", 14.sp,grey, 1,fontWeight: FontWeight.w500),
                                    ],
                                  )
                                ],
                              ),getSvgImage("delete_icon.svg",height: 24.h,width: 24.h)
                            ],
                          ).paddingSymmetric(horizontal: 20.h,vertical: 22.h),
                          ),
                          getVerSpace(30.h),
                          getCustomFont("Category image", 15.h,
                              context.theme.primaryColor, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(6.h),
                          getTextField(context.theme.focusColor, "Enter Image URL",suffixIconPermission: true,height: 56.h,suffixWidget: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.h),
                                color:lightGrey ),
                            child:getCustomFont("Choose File", 15.sp, grey, 1,fontWeight: FontWeight.w500).paddingSymmetric(horizontal: 13.h,vertical: 7.h),
                          ).paddingAll(10.h)),
                          getVerSpace(20.h),
                          Stack(children:[
                            getAssetImage("edit_category_book.png",height: 270.h,width: 200.h),
                            Container(
                              height: 22.h,
                              width: 22.h,
                              decoration: BoxDecoration(shape: BoxShape.circle,color: regularWhite),
                              child: getSvgImage("close_icon.svg").paddingAll(7.h),
                            ).paddingOnly(left: 168.h,top: 10.h)
                          ]
                          ),
                          getVerSpace(30.h),
                          getCustomButton("Save", (){
                            backClick();
                          },buttonWidth: 112.h)

                        ],
                      ).paddingSymmetric(vertical: 20.h, horizontal: 20.h)
                    ],
                  ),
                ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
              )
            ],
          ),
        )),
      ),
    );
  }
}
