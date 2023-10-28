import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({Key? key}) : super(key: key);

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  SendNotificationScreenController sendNotificationScreenController = Get.put(SendNotificationScreenController());

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
        body: SafeArea(child:GetBuilder<SendNotificationScreenController>(
          init: SendNotificationScreenController(),
          builder: (sendNotificationScreenController) => Column(
            children: [
              getCustumAppbar(
                  leftIcon: Get.isDarkMode?"left_arrow_white.svg":"back_arrow.svg",
                  rightPermission: false,
                  title: "Send Notification",
                  leftFunction: () {
                    backClick();
                  },
                  givecolor: context.theme.focusColor,
                  titlecolor: context.theme.primaryColor),
              getVerSpace(20.h),

            ],
          ),
        )),
      ),
    );
  }
}
