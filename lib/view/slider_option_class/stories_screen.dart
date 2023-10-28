import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  StoriesScreenController storiesScreenController = Get.put(StoriesScreenController());

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
        body: SafeArea(child:GetBuilder<StoriesScreenController>(
              init: StoriesScreenController(),
              builder: (storiesScreenController) => Column(
                children: [
                  getCustumAppbar(
                      leftIcon: Get.isDarkMode?"left_arrow_white.svg":"back_arrow.svg",
                      rightPermission: false,
                      title: "Stories",
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
