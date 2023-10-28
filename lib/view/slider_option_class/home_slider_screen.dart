import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class HomeSliderScreen extends StatefulWidget {
  const HomeSliderScreen({Key? key}) : super(key: key);

  @override
  State<HomeSliderScreen> createState() => _HomeSliderScreenState();
}

class _HomeSliderScreenState extends State<HomeSliderScreen> {
  HomeSliderScreenController homeSliderScreenController = Get.put(HomeSliderScreenController());

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
        body: SafeArea(child:GetBuilder<HomeSliderScreenController>(
          init: HomeSliderScreenController(),
          builder: (homeSliderScreenController) => Column(
            children: [
              getCustumAppbar(
                  leftIcon: Get.isDarkMode?"left_arrow_white.svg":"back_arrow.svg",
                  rightPermission: false,
                  title: "Home Slider",
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
