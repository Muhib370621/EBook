import 'package:ebook_app/datafile/datafile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../models/drawer_categoy_class_data_model.dart';
import '../../routes/app_routes.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoriesScreenController categoriesScreenController =
      Get.put(CategoriesScreenController());

  List<CategoriesData> categoriesData = DataFile.getCategoriesData();

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
            child: GetBuilder<CategoriesScreenController>(
          init: CategoriesScreenController(),
          builder: (categoriesScreenController) => Column(
            children: [
              getCustumAppbar(
                  leftIcon: Get.isDarkMode
                      ? "left_arrow_white.svg"
                      : "back_arrow.svg",
                  rightPermission: false,
                  title: "Categories",
                  leftFunction: () {
                    backClick();
                  },
                  givecolor: context.theme.focusColor,
                  titlecolor: context.theme.primaryColor),
              getVerSpace(20.h),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.h),
                    ),
                    color: context.theme.focusColor,
                  ),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      getVerSpace(20.h),
                      kIsWeb?webRow(context.theme.focusColor, context.theme.primaryColor):
                      mobileRow(),
                      getVerSpace(30.h),
                      Table(
                        // border: TableBorder.all(color: Colors.black),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: context.theme.scaffoldBackgroundColor),
                              children: [
                                Center(
                                    child: getMultilineCustomFont("Id", 15.sp,
                                            context.theme.primaryColor,
                                            fontWeight: FontWeight.w600)
                                        .paddingOnly(top: 10.h, bottom: 10.h)),
                                Center(
                                  child: getMultilineCustomFont("Category name",
                                          15.sp, context.theme.primaryColor,
                                          fontWeight: FontWeight.w600)
                                      .paddingOnly(top: 10.h, bottom: 10.h),
                                ),
                                Center(
                                  child: getMultilineCustomFont(
                                          "Category image",
                                          15.sp,
                                          context.theme.primaryColor,
                                          fontWeight: FontWeight.w600)
                                      .paddingOnly(top: 10.h, bottom: 10.h),
                                ),
                                Center(
                                  child: getMultilineCustomFont("Actions",
                                          15.sp, context.theme.primaryColor,
                                          fontWeight: FontWeight.w600)
                                      .paddingOnly(
                                          top: 10.h, bottom: 10.h, right: 20.h),
                                ),
                              ]),
                          ...categoriesData.asMap().entries.map(
                            (student) {
                              return TableRow(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Get.isDarkMode?context.theme.primaryColor:context.theme.scaffoldBackgroundColor))),
                                  children: [
                                    Center(
                                      child: getCustomFont(
                                              student.value.id.toString(),
                                              16.h,
                                              context.theme.primaryColor,
                                              1,
                                              fontWeight: FontWeight.w500,
                                              textAlign: TextAlign.center)
                                          .paddingSymmetric(vertical: 52.h),
                                    ),
                                    Center(
                                      child: getCustomFont(
                                              student.value.name!.toString(),
                                              16.h,
                                              context.theme.primaryColor,
                                              1,
                                              fontWeight: FontWeight.w500,
                                              textAlign: TextAlign.center)
                                          .paddingSymmetric(vertical: 52.h),
                                    ),
                                    Center(
                                      child: getAssetImage(student.value.image!,
                                              height: 88.h, width: 61.h)
                                          .paddingSymmetric(vertical: 20.h),
                                    ),
                                    Center(
                                      child:
                                      PopupMenuButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(12.h)),
                                          child: getSvgImage("mor_vert_rounded.svg",
                                     height: 24.h, width: 24.h),
                                          itemBuilder:
                                              (BuildContext context) =>
                                          <PopupMenuEntry>[
                                            PopupMenuItem(
                                              value: 1,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Constant.sendToNext(context, Routes.editCategoriesScreenRoute);
                                                },
                                                child: getCustomFont("Edit", 16.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w500)
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 2,
                                              child: GestureDetector(
                                                onTap: () {
                                                  getDeleteDialogueFormat("Are you sure you want to delete category!",context.theme.primaryColor, (){}, (){backClick();});
                                                },
                                                child:  getCustomFont("Delete", 16.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w500)
                                              ),
                                            ),
                                          ]).paddingSymmetric(vertical: 52.h),
                                      // getSvgImage("mor_vert_rounded.svg",
                                      //         height: 24.h, width: 24.h)
                                      //     .paddingSymmetric(vertical: 52.h),
                                    ),
                                  ]);
                            },
                          )
                        ],
                      ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
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
  Widget mobileRow(){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getCustomFont("Show entries", 16.sp,
                context.theme.primaryColor, 1,
                fontWeight: FontWeight.w500),
            getHorSpace(18.h),
            Container(
              height: 44.h,
              width: 95.h,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(16.h)),
                  color: context.theme.focusColor,
                  border: Border.all(
                      color: context.theme.primaryColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getCustomFont("${categoriesData.length}", 15.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w400),
                  GestureDetector(onTap: (){

                  },child: getSvgImage(Get.isDarkMode?"white_down_arrow_icon.svg":"down_arrow_icon.svg",height: 16.h,width: 16.h))
                ],
              ).paddingSymmetric(horizontal: 14.h),
            ),
          ],
        ),
        getVerSpace(20.h),
        getSearchTextField(horPadding: 0.h),
        getVerSpace(20.h),
        getCustomButton("Add new category", () {
          print("press");
          Constant.sendToNext(context, Routes.addNewCategoryScreenRoute);
        },)
      ],
    ).paddingSymmetric(horizontal: 20.h);
  }
  Widget webRow(Color containerColor,Color textColor){
    return Row(
      children: [
        getCustomFont("Show entries", 16.sp,
            textColor, 1,
            fontWeight: FontWeight.w500),
        getHorSpace(18.h),
        Container(
          height: 44.h,
          width: 95.h,
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(16.h)),
              color: containerColor,
              border: Border.all(
                  color: textColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getCustomFont("${categoriesData.length}", 15.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w400),
              GestureDetector(onTap: (){

              },child: getSvgImage(Get.isDarkMode?"white_down_arrow_icon.svg":"down_arrow_icon.svg",height: 16.h,width: 16.h))
            ],
          ).paddingSymmetric(horizontal: 14.h),
        ),
        getHorSpace(118.h),
        Expanded(
          child: SizedBox(height: 44.h,child: getSearchTextField(horPadding: 0.h,iconleftPadding: 14.h,icontopPadding: 10.h, iconbottomPadding: 10.h, iconrightPadding: 10.h)),
        ),
        getHorSpace(20.h),
        Expanded(
          child: SizedBox(
            height: 44.h,
            child:  getCustomButton("Add new category", () {
              Constant.sendToNext(context, Routes.addNewCategoryScreenRoute);
            },),
          ),)
      ],
    );

  }
}
