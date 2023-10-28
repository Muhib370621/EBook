import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({Key? key}) : super(key: key);

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}


class _NotificationTabState extends State<NotificationTab> {
  NotificationTabController notificationTabController =
      Get.put(NotificationTabController());

  void backClick() {
    Constant.closeApp();
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
        body: GetBuilder<NotificationTabController>(
          init: NotificationTabController(),
          builder: (notificationTabController) => SafeArea(
              child: Column(
            children: [
              getCustumAppbar(
                  rightPermission: false,
                  leftIcon: Get.isDarkMode
                      ? "left_arrow_white.svg"
                      : "back_arrow.svg",
                  title: "Notifications",
                  leftFunction: () {
                    backClick();
                  },
                  givecolor: context.theme.focusColor,
                  titlecolor: context.theme.primaryColor),
              getVerSpace(26.h),
              Expanded(
                  child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  getCustomFont("Today", 16.sp, context.theme.primaryColor, 1,
                          fontWeight: FontWeight.w400)
                      .paddingSymmetric(horizontal: 20.h),
                  getVerSpace(10.h),
                  Container(
                    color: context.theme.focusColor,
                    child: Column(
                      children: [
                        getNotificationFormate(
                            "save_icon_orange.svg",
                            "Saved book",
                            "Harry potter book saved successfully.",
                            "10 min ago",
                            const Color(0XFFFFEDE2),
                            context.theme.focusColor,
                            context.theme.primaryColor),
                        getVerSpace(20.h),
                        getNotificationFormate(
                            "star_icon.svg",
                            "Thanks for rate us!",
                            "Thank you for share your thought and rate us.",
                            "10 min ago",
                            const Color(0XFFFAF3E1),
                            context.theme.focusColor,
                            context.theme.primaryColor),
                      ],
                    ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
                  ),
                  getVerSpace(20.h),
                  getCustomFont(
                          "Yesterday", 16.sp, context.theme.primaryColor, 1,
                          fontWeight: FontWeight.w400)
                      .paddingSymmetric(horizontal: 20.h),
                  getVerSpace(10.h),
                  getNotificationFormate(
                      "category_icon_blue.svg",
                      "Lorem ipsum dolor",
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                      "1 day ago",
                      const Color(0XFFECF6FF),
                      roundeddBorderPermition: false,
                      context.theme.focusColor,
                      context.theme.primaryColor),
                  getVerSpace(20.h),
                  getNotificationFormate(
                      "save_icon_purple.svg",
                      "Lorem ipsum dolor",
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                      "1 day ago",
                      const Color(0XFFF1EEFF),
                      roundeddBorderPermition: false,
                      context.theme.focusColor,
                      context.theme.primaryColor),
                  getVerSpace(20.h),
                  getNotificationFormate(
                      "save_icon_green.svg",
                      "Lorem ipsum dolor",
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                      "1 day ago",
                      const Color(0XFFE8F7F0),
                      roundeddBorderPermition: false,
                      context.theme.focusColor,
                      context.theme.primaryColor),
                  getVerSpace(20.h),
                ],
              ))
            ],
          )),
        ),
      ),
    );
  }
}

/*
 getVerSpace(217.h),
                getSvgImage("no_notification_icon.svg", height: 94.h, width: 94.h),
                getVerSpace(26.h),
                getCustomFont("No notifications yet!", 22.sp, regularBlack, 1,
                    fontWeight: FontWeight.w700)
 */
