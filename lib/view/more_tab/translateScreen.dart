import 'dart:developer';

import 'package:ebook_app/controller/controller.dart';
import 'package:ebook_app/utils/constantWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:translator/translator.dart';

class TranslateScreen extends StatefulWidget {
  TranslateScreen({super.key, required this.stringToBeTranslated});

  final String stringToBeTranslated;

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final TextEditingController actualText = TextEditingController();

  final translator = GoogleTranslator();
  RxBool isLoading = false.obs;
  final input = "How are you";
  String translated = "";
  String dropDownValue = "";
  String selectedLanguage = "";

  Future<String> translateTo(String language) async {
    isLoading.value = true;
    var res = await translator.translate(actualText.text, to: language);
    translated = "$res";
    log("translated" + translated);
    setState(() {});
    isLoading.value = false;

    return translated;
  }

  var items = {
    'English': 'en',
    'Spanish': 'es',
    'German': 'de',
    'Korean': 'ko',
// Add more languages as needed
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownValue = items.keys.first;
    actualText.text = widget.stringToBeTranslated;
    // translateTo("en");
  }

  @override
  Widget build(BuildContext context) {
    // translator
    //     .translate(input, to: 'ur')
    //     .then((result) => print("Source: $input\nTranslated: $result"));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getCustumAppbar(
                rightPermission: false,
                leftIcon:
                    Get.isDarkMode ? "left_arrow_white.svg" : "back_arrow.svg",
                title: "Translate Sheet",
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
                          Text(
                            "Actual Text",
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                                  controller: actualText,
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
                    getVerSpace(20.h),
                    15.h.verticalSpace,
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Language",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            10.h.verticalSpace,
                            DropdownButton(
                              // Initial Value
                              value: dropDownValue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.keys.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownValue = newValue!;
                                  log("Dop down value" + dropDownValue);
                                  var abc = items[dropDownValue];
                                  selectedLanguage = abc ?? 'es';
                                  log("selectedLanguage" +
                                      selectedLanguage.toString());
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    getVerSpace(20.h),
                    Visibility(
                      visible: translated != "",
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Translated Text",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            15.h.verticalSpace,
                            Container(
                                width: 0.9.sw,
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
                                child: Text(translated)),
                            35.h.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: 0.05.sh,
                        width: 0.5.sw,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange.shade500,
                            // Background color
                            primary: Colors.white,
                            // Text color
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            // Padding
                            textStyle: TextStyle(
                              fontSize: 16,
                            ), // Text style
                          ),
                          onPressed: () {
                            translateTo(selectedLanguage);
                            setState(() {});
                          },
                          child: Obx(() {
                            return isLoading.value
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.w,
                                      color: Colors.white,
                                    ))
                                : Text("Translate");
                          }),
                        ),
                      ),
                    )
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
