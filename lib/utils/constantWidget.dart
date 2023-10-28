import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ebook_app/models/book_list_model.dart';
import 'package:ebook_app/utils/color_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:launch_review/launch_review.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/controller.dart';
import '../datafile/firebase_data/firebasedata.dart';
import '../routes/app_routes.dart';
import 'constant.dart';

Widget getAssetImage(String image,
    {double? width,
    double? height,
    Color? color,
      BoxFit boxFit = BoxFit.contain}) {
    return Image.asset(
      Constant.assetImagePath + image,
      color: color,
      width: width,
      height: height,
      fit: boxFit,
    );
  }

  Widget getNetWorkImage(
      BuildContext context, String image, double width, double height,
      {Color? color, BoxFit boxFit = BoxFit.contain, bool listen = true}) {
    return Image.network(
      image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
  );
}

Widget getSvgImage(String image,
    {double? width,
    double? height,
    Color? color,
      // Function? onTap,
    BoxFit boxFit = BoxFit.contain}) {
  return SvgPicture.asset(
    Constant.assetImagePath + image,
    // ignore: deprecated_member_use
    color: color,
    width: width,
    height: height,
    fit: boxFit,
  );
}


getCommonLoginAppBar(BuildContext context,{required String title,bool withLeading = false,Function? onTap}){
  return AppBar(
    elevation: 0,
    title: getCustomFont(title, 22.sp, context.theme.primaryColor, 1,
        fontWeight: FontWeight.w700, textAlign: TextAlign.center),
    centerTitle: true,
    leading: (withLeading)?GestureDetector(onTap: (){
      if(onTap != null){
        onTap();
      }
    },child: Center(child: getSvgImage("back_arrow.svg",height: 24.h,color: context.theme.primaryColor))):Container(),
    backgroundColor: Colors.transparent,

  );
}

Widget getCommonOtherWidget(
    {required BuildContext context,
      required String s1,
      required String s2,
      required Function function}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      getCustomFont(s1, 15, context.theme.primaryColor, 1,
          fontWeight: FontWeight.w400, textAlign: TextAlign.end),
      getHorSpace(7.h),
      InkWell(
        onTap: () {
          function();
        },
        child: getCustomFont(s2, 16.sp, context.theme.primaryColor, 1,
            fontWeight: FontWeight.w700, textAlign: TextAlign.end),
      ),
    ],
  );
}

Widget getVerSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}

Widget getHorSpace(double horSpace) {
  return SizedBox(
    width: horSpace,
  );
}

Widget getCustomFont(String text, double fontSize, Color fontColor, int maxLine,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
      decoration: decoration,
      fontSize: fontSize,
      color: fontColor,
      fontFamily: fontFamily,
      height: txtHeight ?? 1.5.h,
      fontWeight: fontWeight,
    ),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
  );
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(
    r"<[^>]*>",
    multiLine: true,
    caseSensitive: true,
  );

  return htmlText.replaceAll(exp, '');
}

Widget getMultilineCustomFont(String text, double fontSize, Color fontColor,
    {TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight = 1.0,
    String? fontFamily}) {
  return Text(
    text,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily ?? Constant.fontsFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    textAlign: textAlign,
  );
}

Widget getCustomButton(String text, Function function,
    {double? buttonHeight,
    double? buttonWidth,
    double? fontSize,
    FontWeight? weight,
      Key? key,
      bool? isProgress,
    Color? color,
      BuildContext? context,
    BoxDecoration? decoration}) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      key: key,
      height: buttonHeight ?? 54.h,
      width: buttonWidth ?? double.infinity,
      decoration: decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: maximumOrange,
          ),
      child: Center(
          child: (isProgress != null && isProgress)?getProgressDialog(context!,color: Colors.white):Text(
            text,
            style: TextStyle(
                fontSize: fontSize ?? 18.sp,
                color: color ?? const Color(0XFFFFFFFF),
                fontFamily: Constant.fontsFamily,
                fontWeight: weight ?? FontWeight.w700),
          )),
    ),
  );
}



Widget getCustomReadButton(String text, Function function,
    {double? buttonHeight,
      double? buttonWidth,
      double? fontSize,
      FontWeight? weight,
      Key? key,
      bool? isProgress,
      bool isIcon = false,
      Color? color,
      BuildContext? context,
      BoxDecoration? decoration}) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      key: key,
      height: buttonHeight ?? 54.h,
      width: buttonWidth ?? double.infinity,
      decoration: decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: maximumOrange,
          ),
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (isIcon)?getSvgImage("book1.svg",height: 20.h,width: 20.h).marginOnly(right: 10.h):Container(),

              (isProgress != null && isProgress)?getProgressDialog(context!,color: Colors.white):Text(
                text,
                style: TextStyle(
                    fontSize: fontSize ?? 18.sp,
                    color: color ?? const Color(0XFFFFFFFF),
                    fontFamily: Constant.fontsFamily,
                    fontWeight: weight ?? FontWeight.w700),
              )
            ],
          )),
    ),
  );
}

showCustomToast(
    {required String message, String? title}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 20.sp);
}

Widget getCustumAppbar(
    {Color? color,
    String? leftIcon,
    Color? titlecolor,
    Color? givecolor,
    String? title,
    String? rightIcon,
    bool leftPermission = true,
    bool rightPermission = true,
    bool titlePermission = true,
    bool colorPermition = true,
    Function? leftFunction,
    Function? rightFunction}) {
  return Container(
    color: colorPermition ? givecolor : bgColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftPermission
            ? GestureDetector(
                onTap: () {
                  leftFunction!();
                },
                child: getSvgImage(leftIcon!))
            : const SizedBox(),
        titlePermission
            ? Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: getCustomFont(
                          title!, 24.sp, titlecolor ?? regularBlack, 1,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        rightPermission
            ? GestureDetector(
                onTap: () {
                  rightFunction!();
                },
                child: getSvgImage(rightIcon!))
            : SizedBox(
                width: 20.h,
              ),
      ],
    ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
  );
}


bool isNotEmpty(String s) {
  return (s.isNotEmpty);
}

bool isValidEmail(String email) {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}



Widget getCommonBookWidget(BuildContext context, String image, String bookName,
    String authorName, Function function) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      height: 252.h,
      width: 136.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.h),
          border: Border.all(color: grey20)),
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              // height: 170.h,
              // width: 112.h,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.h),
                  image: getDecorationNetworkImage(context, image,
                      fit: BoxFit.cover),

                  // DecorationImage(
                  //     image: AssetImage(Constant.assetImagePath + image))

                  ),
            ),
          ),
          getVerSpace(10.h),
          getCustomFont(
              bookName, 16.sp, Get.isDarkMode ? regularWhite : regularBlack, 1,
              fontWeight: FontWeight.w700,textAlign: TextAlign.center),
          getVerSpace(1.h),
          getCustomFont(authorName, 14.sp, grey, 1,
              fontWeight: FontWeight.w400,textAlign: TextAlign.center),
        ],
      ).paddingSymmetric(vertical: 12.h),
    ),
  );
}


Widget getBook(BuildContext context,StoryModel model,String auth,Function function){
  return GestureDetector(
    onTap: () {
      // populerBookScreenController.onSetIndex(index);
      function();
    },
    child: Container(

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.h),
          border: Border.all(color: grey20)),
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              // height: 230.h,
              // width: 160.h,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(16.h),
                  image: getDecorationNetworkImage(context, model.image ?? "",fit: BoxFit.fill)

                // DecorationImage(
                //     image: AssetImage(
                //         Constant.assetImagePath +
                //             populer.image!),
                //     fit: BoxFit.fill)
              ),
            ),
          ),
          getVerSpace(12.h),
          getCustomFont(model.name ?? "", 16.sp,
              context.theme.primaryColor, 1,
              fontWeight: FontWeight.w700),
          getVerSpace(1.h),
          getCustomFont(
              auth, 14.sp, grey, 1,
              fontWeight: FontWeight.w400),
        ],
      ).paddingSymmetric(vertical: 12.h),
    ),
  );
}

Widget getCommonBookShimmerWidget(BuildContext context) {
  return getShimmerWidget(
      context,
      Container(
        height: 252.h,
        width: 136.h,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(16.h),
            border: Border.all(color: grey20)),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                // height: 170.h,
                width: 112.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.h),
                  // image: getDecorationNetworkImage(context, image,fit: BoxFit.cover)

                  // DecorationImage(
                  //     image: AssetImage(Constant.assetImagePath + image))
                ),
              ),
            ),
            getVerSpace(12.h),
            getCustomFont(
                " ", 16.sp, Get.isDarkMode ? regularWhite : regularBlack, 1,
                fontWeight: FontWeight.w700),
            getVerSpace(1.h),
            getCustomFont(" ", 14.sp, grey, 1, fontWeight: FontWeight.w400),
          ],
        ).paddingSymmetric(vertical: 12.h),
      ));
}

Widget review_format(String image, String userName, String messege,
    String time, Color containerColor, Color userNameColor) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
          height: 40.h,
          width: 40.h,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: containerColor),
          child: getAssetImage(image)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCustomFont(userName, 14.sp, userNameColor, 1,
              fontWeight: FontWeight.w700),
          getVerSpace(4.h),
          getMultilineCustomFont(messege, 14.sp, userNameColor,
              fontWeight: FontWeight.w400),
          getVerSpace(14.h),
          GetBuilder<ReviewsScreenController>(
            init: ReviewsScreenController(),
            builder: (reviewsScreenController) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        reviewsScreenController.setReviewLike();
                      },
                      child: getSvgImage(
                          Get.isDarkMode
                              ? "white_heart.svg"
                              : "heart_icon.svg",
                          height: 16.h,
                          width: 16.h),
                    ),
                    getHorSpace(8.h),
                    getSvgImage(
                        Get.isDarkMode
                            ? "white_repley_icon.svg"
                            : "reply_icon.svg",
                        height: 16.h,
                        width: 16.h),
                  ],
                ),
                getHorSpace(252.h),
                getCustomFont(time, 13.sp, grey, 1,
                    fontWeight: FontWeight.w400)
              ],
            ),
          )
        ],
      ),
    ],
  );
}

Widget getSearchFigmaWidget(
    BuildContext context,
    TextEditingController searchController,
    Function filterClick,
    ValueChanged<String> onChanged,
    {bool readOnly = false}) {
  double height = 50.h;
  // ignore: unused_local_variable
  double iconSize = 16.h;
  double fontSize = 18.sp;

  // ignore: unused_local_variable
  final mqData = MediaQuery.of(context);
  // final mqDataNew =
  // mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());

  return Container(
    width: double.infinity,
    height: height,
    // padding: EdgeInsets.symmetric(horizontal: 19.h),

    decoration:BoxDecoration(
      // color: context.theme.focusColor,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: grey10)
    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // getSvgImage(Get.isDarkMode?"search_normal.svg":"searchIcon.svg", height: iconSize, width: iconSize,
        //     color: grey10),
        // getHorSpace(13.h),
        Expanded(
          flex: 1,
          child: IntrinsicHeight(
            child: TextField(
              readOnly: readOnly,
              controller: searchController,
              onChanged: onChanged,

              decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  // isDense: true,
                  // isCollapsed: true,
                  hintText: 'Search...',
                  prefixIcon: getSvgImage("searchIcon.svg",
                      color: Get.isDarkMode
                          ? regularWhite
                          : null)
                      .paddingOnly(
                      top: 16.h,
                      left: 16.w,
                      bottom: 16.h,
                      right: 13.h),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.h),
                      borderSide: BorderSide(color: grey10)),
                  hintStyle: TextStyle(
                      color: grey,
                      fontFamily: Constant.fontsFamily,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                  fillColor: Get.isDarkMode
                      ? Colors.grey.shade900
                      : grey10,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.h),
                      borderSide: BorderSide(color: grey10)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.h),
                      borderSide:
                      BorderSide(color: maximumOrange))
              ),
              style: TextStyle(
                  fontFamily: Constant.fontsFamily,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: context.theme.hintColor),
              textAlign: TextAlign.start,

              maxLines: 1,
            ),
          ),
        ),
        // getHorSpace(FetchPixels.getPixelWidth(3)),
        // InkWell(
        //   child: getSvgImageWithSize(context, "filter.svg", iconSize, iconSize),
        //   onTap: () {
        //     filterClick();
        //   },
        // )
      ],
    ),
  );
}


Widget getSearchTextField(
    {double? height,
    double? horPadding,
    double? iconleftPadding,
    double? icontopPadding,
    double? iconbottomPadding,
    double? iconrightPadding}) {
  return TextFormField(
          cursorColor: maximumOrange,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              prefixIcon: getSvgImage("searchIcon.svg").paddingOnly(
                  top: icontopPadding ?? 16.h,
                  left: iconleftPadding ?? 16.w,
                  bottom: iconbottomPadding ?? 16.h,
                  right: iconrightPadding ?? 13.h),
              hintText: 'Search...',
              hintStyle: TextStyle(
                  color: grey,
                  fontFamily: Constant.fontsFamily,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400),
              filled: true,
              fillColor: grey10,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.h),
                  borderSide: BorderSide(color: grey10)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.h),
                  borderSide: BorderSide(color: maximumOrange))))
      .paddingSymmetric(horizontal: horPadding ?? 20.h);
}

Widget getTabSearchTextField(
    {TextEditingController? controller,
    double? height,
    double? horPadding,
    double? iconleftPadding,
    double? icontopPadding,
    double? iconbottomPadding,
    double? iconrightPadding,
    RxString? text}) {
  return TextFormField(
          cursorColor: maximumOrange,
          onChanged: (value) {
            text!.value = value;
          },
          controller: controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              prefixIcon: getSvgImage("searchIcon.svg").paddingOnly(
                  top: icontopPadding ?? 16.h,
                  left: iconleftPadding ?? 16.w,
                  bottom: iconbottomPadding ?? 16.h,
                  right: iconrightPadding ?? 13.h),
              hintText: 'Search...',
              hintStyle: TextStyle(
                  color: grey,
                  fontFamily: Constant.fontsFamily,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400),
              filled: true,
              fillColor: grey10,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.h),
                  borderSide: BorderSide(color: grey10)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.h),
                  borderSide: BorderSide(color: maximumOrange))))
      .paddingSymmetric(horizontal: horPadding ?? 20.h);
}



Widget getDefaultTextFiledWidget(
    BuildContext context, String s, TextEditingController textEditingController,
    {bool? isEnabled,
      var inputType,
      RxString? errorText,
      var inputFormatters,
      var onChanged,
      var focus,
      double? height,
      FormFieldValidator? validator,
      Function? onTapFunction}) {
  double fontSize = 16.sp;

  return TextFormField(
    maxLines: 1,
    validator: validator,
    controller: textEditingController,
    textAlign: TextAlign.start,
    textAlignVertical: TextAlignVertical.center,
    style: TextStyle(
        fontFamily: Constant.fontsFamily,
        color: context.theme.primaryColor,
        fontWeight: FontWeight.w400,
        fontSize: fontSize),
    decoration: InputDecoration(
      prefixIconConstraints: BoxConstraints(
        maxHeight: 60.h,
        minHeight: 60.h
      ),
      prefixIcon: SizedBox(
        height: 60.h,
        width: 20.h,
      ),
      isDense: true,
      errorText: errorText?.value,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.h, color: grey30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.h, color: grey30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.h, color: grey30),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.h, color: Colors.red),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.h, color: grey30),
        ),
        hintText: s,
        filled: true,
        fillColor: Get.isDarkMode ? Colors.grey.shade900 : context.theme.focusColor,
        hintStyle: TextStyle(
            fontFamily: Constant.fontsFamily,
            color: grey,
            fontWeight: FontWeight.w400,
            fontSize: fontSize)),
  );
}

Widget getPasswordTextFiledWidget(BuildContext context, String s,
    TextEditingController textEditingController,
    {bool? isEnabled,
      var inputType,
      var inputFormatters,
      var onChanged,
      FormFieldValidator? validator,
      var focus,
      double? height,
      Function? onTapFunction,}) {
  double fontSize = 16.sp;


  RxBool isSecure = true.obs;

  return Obx(() => TextFormField(
    obscureText: isSecure.value,
    maxLines: 1,
    enabled: (isEnabled != null) ? isEnabled : true,
    controller: textEditingController,
    textAlign: TextAlign.start,
    textAlignVertical: TextAlignVertical.center,
    keyboardType: (inputType != null) ? inputType : null,
    // autofocus: true,
    onTap: () {
      // setState(() {});
      // if (onTapFunction != null) {
      //   onTapFunction();
      // }
    },
    inputFormatters: (inputFormatters != null) ? inputFormatters : null,
    onChanged: (onChanged != null) ? onChanged : null,
    style: TextStyle(
        fontFamily: Constant.fontsFamily,
        color: context.theme.primaryColor,
        fontWeight: FontWeight.w400,
        fontSize: fontSize),
    validator: validator,
    decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(
            maxHeight: 60.h,
            minHeight: 60.h
        ),
        prefixIcon: SizedBox(
          height: 60.h,
          width: 20.h,
        ),
        filled: true,
        fillColor: Get.isDarkMode ? Colors.grey.shade900 : context.theme.focusColor,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.h, color: grey30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.h, color: grey30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.h, color: grey30),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.h, color: Colors.red),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.h, color: grey30),
        ),
        hintText: s,
        // isDense: true,
        suffixIconConstraints: BoxConstraints(
          minWidth: 6.h,
          minHeight: 6.h,
        ),
        suffixIcon: GestureDetector(
            onTap: () {
              // isObscureText.n = !isObscureText;
              // function(isObscureText);
              // // setState(() {});

              (isSecure.value)?isSecure.value = false:isSecure.value = true;

            },
            child: Container(
              padding: EdgeInsets.only(
                  right: 20.h),
              child: Container(
                  height: 18.h,
                  width: 18.h,
                  child: (isSecure.value)?getSvgImage("hide.svg",height: 18.h):getSvgImage(
                      "eye.svg", height: 18.h)),
            )),
        hintStyle: TextStyle(
            fontFamily: Constant.fontsFamily,
            fontWeight: FontWeight.w400,
            color: grey,
            fontSize: fontSize)),
  ));
}




Widget getTextField(Color containerColor, String hintText,
    {bool suffixIconPermission = false,
    Widget? suffixWidget,
    double? height,
    int? line,
    double? topContant,
    ValueChanged<String>? onChanged,
    TextEditingController? controller}) {
  return Container(
    height: height ?? 46.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.h), color: containerColor),
    child: TextFormField(
      maxLines: line ?? 1,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
          suffixIcon: suffixIconPermission ? suffixWidget : null,
          hintText: hintText,
          hintStyle: TextStyle(
              color: grey,
              fontWeight: FontWeight.w500,
              fontSize: 15.h,
              fontFamily: Constant.fontsFamily),
          filled: true,
          fillColor: containerColor,
          contentPadding: EdgeInsets.only(left: 16.h, top: topContant ?? 0.h),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.h),
              borderSide: BorderSide(color: grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.h),
              borderSide: BorderSide(color: maximumOrange))),
    ),
  );
}

Widget getSavedBookItemFormate(String bookImage, Function deleteFunction,
    String bookName, String authorName, Color textColor,
    {bool percentindicaterPermmition = false, double? persentIndicate}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.h),
        border: Border.all(color: grey20)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            getAssetImage(bookImage, height: 90.h, width: 59.h),
            getHorSpace(14.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getVerSpace(5.h),
                getCustomFont(bookName, 16.sp, textColor, 1,
                    fontWeight: FontWeight.w700),
                getVerSpace(3.h),
                getCustomFont(authorName, 14.sp, textColor, 1,
                    fontWeight: FontWeight.w400),
                getVerSpace(11.h),
                percentindicaterPermmition
                    ? Row(
                        children: [
                          LinearPercentIndicator(
                            backgroundColor: grey20,
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: 8.h,
                            barRadius: Radius.circular(3.h),
                            padding: EdgeInsets.zero,
                            width: 250.h,
                            percent: persentIndicate!,
                            progressColor: maximumOrange,
                          ),
                          getHorSpace(10.h),
                        ],
                      )
                    : const SizedBox(),
              ],
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                      barrierDismissible: false,
                      title: '',
                      content: Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Column(
                          children: [
                            getCustomFont(
                                "Are you sure you want to delete this plant from cart?",
                                18.sp,
                                textColor,
                                2,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center),
                            Padding(
                              padding: EdgeInsets.only(top: 25.h, bottom: 13.h),
                              child: Row(
                                children: [
                                  SizedBox(width: 10.w),
                                  Expanded(
                                      child: getCustomButton("No", () {
                                    Get.back();
                                  },
                                          color: maximumOrange,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: maximumOrange,
                                              style: BorderStyle.solid,
                                              width: 1.0.w,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.h),
                                          ),
                                          buttonHeight: 60.h)),
                                  getHorSpace(20.h),
                                  Expanded(
                                      child: getCustomButton("Yes", () {},
                                          buttonHeight: 60.h)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                },
                child: getSvgImage("delete_icon.svg")),
            getVerSpace(44.h),
            percentindicaterPermmition
                ? getCustomFont("${(persentIndicate! * 100).toInt()}%", 14.sp,
                    maximumOrange, 1,
                    fontWeight: FontWeight.w400)
                : const SizedBox(),
          ],
        ),
      ],
    ).paddingOnly(left: 12.h, top: 12.h, bottom: 12.h, right: 12.h),
  );
}

Widget getNotificationFormate(String image, String nameOfNotification,
    String messege, String time, Color? bacColor, Color color, Color textColor,
    {bool roundeddBorderPermition = true}) {
  return Container(
    decoration: roundeddBorderPermition
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(16.h),
            border: Border.all(color: grey20))
        : BoxDecoration(color: color),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50.h,
              width: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.h),
                color: bacColor ?? regularWhite,
              ),
              child: getSvgImage(image).paddingAll(13.h),
            ),
            getHorSpace(16.h),
            SizedBox(
              width: 161.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomFont(nameOfNotification, 16.sp, textColor, 1,
                      fontWeight: FontWeight.w700),
                  getVerSpace(6.h),
                  getMultilineCustomFont(messege, 14.sp, textColor,
                      fontWeight: FontWeight.w400, txtHeight: 1.5.h)
                ],
              ),
            )
          ],
        ),
        getCustomFont(time, 14.sp, grey, 1, fontWeight: FontWeight.w400)
      ],
    ).paddingAll(20.h),
  );
}

Widget getMoreTabOption(String icon, String optionName, String rightIcon,
    Function function, Color color, Color textColor) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      height: 61.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.h),
          color: color,
          border: Border.all(color: grey20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              getSvgImage(icon, color: maximumOrange),
              getHorSpace(10.h),
              getCustomFont(optionName, 16.sp, textColor, 1,
                  fontWeight: FontWeight.w500)
            ],
          ),
          getSvgImage(rightIcon)
        ],
      ).paddingOnly(left: 16.h, right: 20.h),
    ).paddingSymmetric(horizontal: 20.h),
  );
}


TextStyle buildTextStyle(BuildContext context, Color fontColor,
    FontWeight fontWeight, double fontSize,
    {double txtHeight = 1, TextOverflow overflow = TextOverflow.ellipsis}) {
  return TextStyle(
      color: fontColor,
      fontWeight: fontWeight,
      fontFamily: Constant.fontsFamily,
      fontSize: fontSize,
      overflow: overflow,
      height: txtHeight);
}



Widget getHtmlWidget(BuildContext context, String desc, double fontSize) {
  return HtmlWidget(
    decode(desc),
    renderMode: RenderMode.column,
    textStyle: buildTextStyle(
      context,
        (Get.isDarkMode)?regularWhite:regularBlack,
      FontWeight.w400,
      fontSize,
      txtHeight: 1.5.h,
    ),
  );
}


String decode(String codeUnits) {
  var unescape = HtmlUnescape();

  codeUnits = codeUnits.replaceAll("<pre>", '');
  codeUnits = codeUnits.replaceAll("</pre>", '');
  String singleConvert = unescape
      .convert(codeUnits.replaceAll("\\n\\n", "<br>"))
      .replaceAll("\\n", "<br>");
  return unescape.convert(singleConvert);
}

Future getRateUsDialogue() {

  double rate=5;


  return Get.generalDialog(
    pageBuilder: (context, animation, secondaryAnimation) {
      return getDefaultWidget(Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.h)),
          // insetPadding: EdgeInsets.zero,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getVerSpace(30.h),
              getCustomFont(
                  "Rate your experience", 22.sp, context.theme.primaryColor, 1,
                  fontWeight: FontWeight.w700),
              getVerSpace(14.h),
              getMultilineCustomFont(
                      "Please let us know how do you feel about this app.",
                      16.sp,
                      context.theme.primaryColor,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center)
                  .paddingSymmetric(horizontal: 28.h),
              getVerSpace(38.h),
              RatingBar(
                initialRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                glow: false,
                ratingWidget: RatingWidget(
                  full: getSvgImage("orange_star.svg"),
                  half: getSvgImage("rating_empty_star.svg"),
                  empty: getSvgImage("rating_empty_star.svg"),
                ),
                itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                onRatingUpdate: (rating) {

                  rate = rating;


                  print("rate--------$rating--------$rate");

                  if (kDebugMode) {
                    print(rating);
                  }
                },
              ),
              getVerSpace(51.h),
              Row(
                children: [
                  Expanded(
                      child: getCustomButton("No", () {
                    Get.back();
                  },
                          color: maximumOrange,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: maximumOrange,
                              style: BorderStyle.solid,
                              width: 1.0.w,
                            ),
                            borderRadius: BorderRadius.circular(16.h),
                          ),
                          buttonHeight: 56.h)),
                  getHorSpace(20.h),
                  Expanded(
                      child: getCustomButton("Yes", () {
                        if(rate < 3) {


                          Constant.backToFinish();
                          Constant.sendToNext(context, Routes.feedBackScreenRoute);
                        }else{

                          LaunchReview.launch();

                        }

                    // Get.back();
                  }, buttonHeight: 56.h)),
                ],
              ).paddingSymmetric(horizontal: 30.h),
              getVerSpace(30.h)
            ],
          )));
    },
  );
}


Future getDeleteDialogueFormat(
    String title, Color fontColor, Function yesFunction, Function noFunction) {
  return Get.defaultDialog(
      title: '',
      content: Column(
        children: [
          getMultilineCustomFont(title, 24.sp, fontColor,
              fontWeight: FontWeight.w600, textAlign: TextAlign.center),
          Row(
            children: [
              Expanded(
                  child: getCustomButton(
                "Yes",
                () {
                  yesFunction();
                },
              )),
              getHorSpace(10.h),
              Expanded(
                  child: getCustomButton("No", () {
                noFunction();
              },
                      color: maximumOrange,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.h),
                          border: Border.all(color: maximumOrange))))
            ],
          ).paddingOnly(top: 30.h, bottom: 10.h)
        ],
      ).paddingSymmetric(horizontal: 15.h));
}

getShimmerWidget(BuildContext context, Widget child) {
  if (Get.isDarkMode) {
    return Shimmer.fromColors(
      baseColor: Colors.white24,
      highlightColor: Colors.white12,
      child: child,
    );
  } else {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade200,
      child: child,
    );
  }
}

DecorationImage getDecorationNetworkImage(
    BuildContext buildContext, String image,
    {BoxFit fit = BoxFit.contain}) {
  return (image.isNotEmpty)?DecorationImage(
    image: NetworkImage(image),
    fit: fit,
  ):DecorationImage(image: AssetImage("${Constant.assetImagePath}place.png",),fit: fit);
}

Widget checkEmptyData(
    {required BuildContext context,
    required AsyncSnapshot querySnapshot,
    required Widget child}) {
  if (querySnapshot.data != null &&
      querySnapshot.data.size > 0 &&
      querySnapshot.data.docs.isNotEmpty) {
    return child;
  } else {
    return noDataFound(context);
  }
}

int getStatus(AsyncSnapshot data) {
  if (data.data == null && data.connectionState == ConnectionState.waiting) {
    return FireBaseData.waiting;
  } else if (data.data == null &&
      data.connectionState == ConnectionState.active) {
    return FireBaseData.dataNotAvailable;
  } else if (data.data != null &&
      data.connectionState == ConnectionState.active) {
    return FireBaseData.dataLoaded;
  } else {
    return FireBaseData.waiting;
  }
}

Future<bool> getNetwork() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}


getWidgetFromStatus(
    {required BuildContext context,
    required AsyncSnapshot data,
    Widget? progressWidget,
    required Widget child}) {
  int status = getStatus(data);

  // checkConnectivity();


  // bool isNetwork = await getNetwork();
  // if (isNetwork) {
    if (status == FireBaseData.waiting) {
      return (progressWidget == null)
          ? getProgressWidget(context)
          : progressWidget;
    } else if (status == FireBaseData.dataLoaded) {
      return child;
    } else if (status == FireBaseData.dataNotAvailable) {
      return noDataFound(context);
    } else {
      return Container();
    }
  // } else {
  //
  //   // getNoInternet(context);
  //   showCustomToast(context: context, message: "Please turn on Internet");
  //
  //   return null;
  // }

}

Widget noDataFound(BuildContext context) {
  return Center(
      child: getCustomFont('No Data Found', 25.sp,
          Get.isDarkMode ? regularWhite : regularBlack, 1));
}

getProgressWidget(BuildContext context) {
  return Center(
    child: SizedBox(
      height: 70.h,
      width: 70.h,
      child: getProgressDialog(context, color: context.theme.primaryColor),
    ),
  );
}


getLoaderWidget(BuildContext context) {
  return Center(
    child: SizedBox(
      height: 70.h,
      width: 70.h,
      child: getAssetImage("loader.gif"),
    ),
  );
}

getProgressDialog(BuildContext context,
    {Color? color, Color? backgroundColor, double? height, double? width}) {
  return SizedBox(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      // decoration: BoxDecoration(
      //   color: backgroundColor==null?getBackgroundColor(context):backgroundColor,
      // ),
      child: Center(
          child: CupertinoActivityIndicator(
        color: color ?? Colors.grey,
      )));
}





getDefaultWidget(Widget child) {

  if (kIsWeb) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              // color: !isWeb(context)?primaryBackgroundColor: getCardColor(context),
              ),
        ),
        SizedBox(
          width: Constant.width,
          child: child,
        ),
        Expanded(
          flex: 1,
          child: Container(
              // color: !isWeb(context)?primaryBackgroundColor: getCardColor(context),
              ),
        ),
      ],
    );
  } else {



    // return FutureBuilder<bool>(
    //   future: getNetwork(),
    //   builder: (context, snapshot) {
    //
    //     print("snap-----${snapshot.data}");
    //
    //     if(snapshot.data!){
    //       return child;
    //     }else{
    //
    //       showCustomToast(context: context, message: "Please connect to Internet");
    //       return Container(
    //
    //         color: Get.isDarkMode?regularBlack:regularWhite,
    //         child: Center(
    //             child: getCustomFont('No Internet Connection', 20.sp,
    //                 Get.isDarkMode ? regularWhite : regularBlack, 1)),
    //       );
    //     }
    //     }
    //
    // );

    return child;

    }






}


showCommonDialog({required Widget widget, required BuildContext context,}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return widget;
    },
  );
}

Widget getLottieAnimationWidget() {
  return Center(
      child: Lottie.asset('${Constant.assetImagePath}loading.json',
          height: (kIsWeb)?90.h:90.h,
          width: (kIsWeb)?90.h:90.h));
}


