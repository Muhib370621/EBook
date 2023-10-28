import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingScreenController settingScreenController = Get.put(SettingScreenController());

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
        body: SafeArea(child:GetBuilder<SettingScreenController>(
          init: SettingScreenController(),
          builder: (settingScreenController) => Column(
            children: [
              getCustumAppbar(
                  leftIcon: Get.isDarkMode?"left_arrow_white.svg":"back_arrow.svg",
                  rightPermission: false,
                  title: "Settings",
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
