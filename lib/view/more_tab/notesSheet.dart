import 'package:ebook_app/controller/controller.dart';
import 'package:ebook_app/utils/constantWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotesSheet extends StatelessWidget {
  NotesSheet({super.key});

  final TextEditingController notesText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getCustumAppbar(
                rightPermission: false,
                leftIcon:
                    Get.isDarkMode ? "left_arrow_white.svg" : "back_arrow.svg",
                title: "Notes Sheet",
                leftFunction: () {
                  // backClick()
                  Get.back();
                  HomeMainScreenController mainScreenController = Get.find();
                  mainScreenController.onChange(2.obs);
                },
                givecolor: context.theme.focusColor,
                titlecolor: context.theme.primaryColor),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    getVerSpace(20.h),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   "Practice Text",
                          //   style: TextStyle(
                          //     fontSize: 22.sp,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          15.h.verticalSpace,
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.theme.primaryColor,
                                // Border color
                                width: 1.0, // Border width
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8.0)), // Border radius
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: notesText,
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                    hintText: 'Type your text here...',
                                    contentPadding: EdgeInsets.all(10.0),
                                    // Padding inside the TextField
                                    border: InputBorder
                                        .none, // Remove the default TextField border
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
