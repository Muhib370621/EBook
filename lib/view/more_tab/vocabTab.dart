import 'dart:developer';

import 'package:ebook_app/controller/controller.dart';
import 'package:ebook_app/utils/constantWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VocabTab extends StatelessWidget {
  VocabTab({super.key, required this.mistakes});

  final List<String> mistakes;

  @override
  Widget build(BuildContext context) {
    log("mistakes" + mistakes.toString());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getCustumAppbar(
                rightPermission: false,
                leftIcon:
                    Get.isDarkMode ? "left_arrow_white.svg" : "back_arrow.svg",
                title: "Vocab Sheet",
                leftFunction: () {
                  // backClick()
                  Get.back();
                  HomeMainScreenController mainScreenController = Get.find();
                  mainScreenController.onChange(2.obs);
                },
                givecolor: context.theme.focusColor,
                titlecolor: context.theme.primaryColor),
            getVerSpace(20.h),
            ListView.builder(
                itemCount: mistakes.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.orange.shade500,
                    child: Container(
                      height: 0.05.sh,
                      width: 0.5.sw,
                      child: Center(
                        child: Text(
                          mistakes[index],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // width: 0.2.sw,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
