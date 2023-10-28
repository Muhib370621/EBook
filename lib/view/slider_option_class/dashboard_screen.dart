import 'package:ebook_app/datafile/datafile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../models/dashboard_screen_data_model.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

void backClick() {
  Constant.backToFinish();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardScreenController dashboardScreenControllerController =
      Get.put(DashboardScreenController());
  List<DeshBoardData> dashboard = DataFile.getDashboardData();

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
            child: GetBuilder<DashboardScreenController>(
          init: DashboardScreenController(),
          builder: (dashboardScreenControllerController) => Column(
            children: [
              getCustumAppbar(
                  leftIcon: Get.isDarkMode
                      ? "left_arrow_white.svg"
                      : "back_arrow.svg",
                  rightPermission: false,
                  title: "Dashboard",
                  leftFunction: () {
                    backClick();
                  },
                  givecolor: context.theme.focusColor,
                  titlecolor: context.theme.primaryColor),
              getVerSpace(20.h),
              Expanded(
                  child: GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: kIsWeb ? 3 : 1,
                              mainAxisExtent: 180.h,
                              mainAxisSpacing: 20.h,
                              crossAxisSpacing: 20.h),
                      itemCount: dashboard.length,
                      itemBuilder: (BuildContext context, int index) {
                        DeshBoardData deshBoardData = dashboard[index];
                        return Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 16),
                                    blurRadius: 31,
                                    color:
                                        const Color(0XFFACBFC1).withOpacity(0.10))
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.h),
                              ),
                              color: context.theme.focusColor),
                          child: Column(
                            children: [
                              Container(
                                height: 96.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.h),
                                        topRight: Radius.circular(16.h)),
                                    color: deshBoardData.backgroundColor),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        getSvgImage(deshBoardData.icon!,
                                            height: 40.h, width: 40.h),
                                        getHorSpace(14.h),
                                        getMultilineCustomFont(
                                            deshBoardData.title!,
                                            18.sp,
                                            Get.isDarkMode?context.theme.scaffoldBackgroundColor:context.theme.primaryColor,
                                            fontWeight: FontWeight.w500,overflow: TextOverflow.visible)
                                      ],
                                    ),
                                    getCustomFont(deshBoardData.number!,
                                        40.h, Get.isDarkMode?context.theme.scaffoldBackgroundColor:context.theme.primaryColor, 1,
                                        fontWeight: FontWeight.w700)
                                  ],
                                ).paddingSymmetric(horizontal: 20.h),
                              ),
                              getVerSpace(28.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {},
                                      child: getCustomFont(
                                          "View All",
                                          16.sp,
                                          context.theme.primaryColor,
                                          1,
                                          fontWeight: FontWeight.w500)),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 36.h,
                                      width: 36.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: deshBoardData.buttonColor),
                                      child: getSvgImage("add_icon.svg")
                                          .paddingAll(8.18.h),
                                    ),
                                  )
                                ],
                              ).paddingSymmetric(horizontal: 20.h)
                            ],
                          ),
                        );
                      }))
            ],
          ),
        )),
      ),
    );
  }
}
