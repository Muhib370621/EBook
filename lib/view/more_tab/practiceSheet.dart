import 'package:ebook_app/controller/controller.dart';
import 'package:ebook_app/utils/constantWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PracticeSheet extends StatefulWidget {
   PracticeSheet({super.key, required this.practiceString});
   final String practiceString;

  @override
  State<PracticeSheet> createState() => _PracticeSheetState();
}

class _PracticeSheetState extends State<PracticeSheet> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController.text = widget.practiceString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getCustumAppbar(
                rightPermission: false,
                leftIcon: Get.isDarkMode
                    ? "left_arrow_white.svg"
                    : "back_arrow.svg",
                title: "Practice Sheet",
                leftFunction: () {
                  // backClick()
                  Get.back();
                  HomeMainScreenController mainScreenController = Get.find();
                  mainScreenController.onChange(2.obs);
                },
                givecolor: context.theme.focusColor,
                titlecolor: context.theme.primaryColor),
            getVerSpace(20.h),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.theme.primaryColor, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)), // Border radius
                ),
                child: TextField(
                  controller: _textController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Type your text here...',
                    contentPadding: EdgeInsets.all(10.0), // Padding inside the TextField
                    border: InputBorder.none, // Remove the default TextField border
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
