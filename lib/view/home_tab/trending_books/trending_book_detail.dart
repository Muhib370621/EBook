// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../datafile/datafile.dart';
// import '../../../models/trending_books_model.dart';
// import '../../../routes/app_routes.dart';
// import '../../../utils/color_category.dart';
// import '../../../utils/constant.dart';
// import '../../../utils/constantWidget.dart';
//
// class TrendingBookDetailScreen extends StatefulWidget {
//   const TrendingBookDetailScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TrendingBookDetailScreen> createState() =>
//       _TrendingBookDetailScreenState();
// }
//
// class _TrendingBookDetailScreenState extends State<TrendingBookDetailScreen> {
//   List<TrenDingBook> trendingBook = DataFile.getTrendingBookData();
//
//   void backClick() {
//     Constant.backToFinish();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     initializeScreenSize(context);
//     return WillPopScope(
//       onWillPop: () async {
//         backClick();
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: context.theme.scaffoldBackgroundColor,
//         body: SafeArea(
//             child: GetBuilder<TrenDingBookScreenController>(
//           init: TrenDingBookScreenController(),
//           builder: (trenDingBookScreenController) {
//             TrenDingBook trnding =
//                 trendingBook[trenDingBookScreenController.setindex];
//             return Column(
//               children: [
//                 getCustumAppbar(
//                   colorPermition: Get.isDarkMode ? true : false,
//                   titlePermission: false,
//                   leftIcon: Get.isDarkMode
//                       ? "left_arrow_white.svg"
//                       : "back_arrow.svg",
//                   rightIcon: Get.isDarkMode
//                       ? trenDingBookScreenController.like
//                           ? "white_fill_heart.svg"
//                           : "white_heart.svg"
//                       : trenDingBookScreenController.like
//                           ? "black_fill_heart.svg"
//                           : "heart_icon.svg",
//                   leftFunction: () {
//                     backClick();
//                   },
//                   rightFunction: () {
//                     trenDingBookScreenController.onSetLike();
//                   },
//                   givecolor: context.theme.focusColor,
//                 ),
//                 Expanded(
//                   child: ListView(
//                     physics: const BouncingScrollPhysics(),
//                     children: [
//                       Stack(children: [
//                         Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(16.h),
//                                     topRight: Radius.circular(16.h)),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       offset: const Offset(0, -2),
//                                       blurRadius: 12,
//                                       color: context.theme.primaryColor
//                                           .withOpacity(0.04))
//                                 ],
//                                 color: context.theme.focusColor),
//                             child: Column(
//                               children: [
//                                 getVerSpace(106.h),
//                                 getCustomFont(trnding.bookName!, 24.sp,
//                                     context.theme.primaryColor, 1,
//                                     fontWeight: FontWeight.w700),
//                                 getVerSpace(5.h),
//                                 getCustomFont(
//                                     trnding.authorName!, 16.sp, grey, 1,
//                                     fontWeight: FontWeight.w400),
//                                 getVerSpace(20.h),
//                                 Container(
//                                   height: 56.h,
//                                 color: Get.theme.focusColor,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(16.h)),
//                                             color:
//                                                 Get.isDarkMode ? grey : grey10),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             getCustomFont("500K", 16.sp,
//                                                 context.theme.primaryColor, 1,
//                                                 fontWeight: FontWeight.w700),
//                                             getHorSpace(16.h),
//                                             getCustomFont("Readers", 16.sp,
//                                                 context.theme.primaryColor, 1,
//                                                 fontWeight: FontWeight.w400),
//                                           ],
//                                         ).paddingSymmetric(
//                                             horizontal: 16.h, vertical: 16.h),
//                                       ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(16.h)),
//                                             color:
//                                                 Get.isDarkMode ? grey : grey10),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 getSvgImage("star_icon.svg",
//                                                     height: 20.h, width: 20.h),
//                                                 getCustomFont("4.3", 16.sp,
//                                                     context.theme.primaryColor, 1,
//                                                     fontWeight: FontWeight.w700),
//                                               ],
//                                             ),
//                                             getHorSpace(16.h),
//                                             getCustomFont("Reviews", 16.sp,
//                                                 context.theme.primaryColor, 1,
//                                                 fontWeight: FontWeight.w400),
//                                           ],
//                                         ).paddingSymmetric(
//                                             horizontal: 16.h, vertical: 16.h),
//                                       ),
//                                       Container(
//                                         height: 56.h,
//                                         width: 56.h,
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(16.h)),
//                                             color: Get.isDarkMode
//                                                 ? grey
//                                                 : regularWhite,
//                                             border: Border.all(
//                                                 color: Get.isDarkMode
//                                                     ? grey
//                                                     : grey20)),
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             trenDingBookScreenController
//                                                 .setSavePosition();
//                                           },
//                                           child: getSvgImage(Get.isDarkMode
//                                                   ? trenDingBookScreenController
//                                                           .save
//                                                       ? "white_fill_save.svg"
//                                                       : "white_border_save_icon.svg"
//                                                   : trenDingBookScreenController
//                                                           .save
//                                                       ? "black_save_fill.svg"
//                                                       : "saveIconBlackBorder.svg")
//                                               .paddingAll(16.h),
//                                         ),
//                                       )
//                                     ],
//                                   ).paddingSymmetric(horizontal: 20.h),
//                                 ),
//                                 getVerSpace(20.h),
//                                 getMultilineCustomFont(
//                                         ' "This is a rare thing: an original, intelligent novel that\'s not just a perfect summer beach read, but one that deserves serious awards consideration as well. Put down your phone and pick it up... A major accomplishment."',
//                                         16.h,
//                                         context.theme.primaryColor,
//                                         fontWeight: FontWeight.w400,
//                                         textAlign: TextAlign.center,
//                                         txtHeight: 1.5.h)
//                                     .paddingSymmetric(horizontal: 20.h),
//                                 getVerSpace(20.h),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Container(
//                                             height: 56.h,
//                                             width: 56.h,
//                                             decoration: const BoxDecoration(
//                                                 shape: BoxShape.circle),
//                                             child: getAssetImage(
//                                                 "user_iage.png",
//                                                 boxFit: BoxFit.fill)),
//                                         getHorSpace(16.h),
//                                         getCustomFont("Carter Bays", 16.sp,
//                                             context.theme.primaryColor, 1,
//                                             fontWeight: FontWeight.w700)
//                                       ],
//                                     ),
//                                     getCustomButton("Follow", () {},
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: maximumOrange),
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(16.h)),
//                                             color: context.theme.focusColor),
//                                         buttonHeight: 40.h,
//                                         buttonWidth: 90.h,
//                                         color: maximumOrange)
//                                   ],
//                                 ).paddingSymmetric(horizontal: 20.h),
//                                 getVerSpace(16.h)
//                               ],
//                             )).paddingOnly(top: 241.h),
//                         getAssetImage(trnding.image!,
//                                 height: 337.h, width: 236.h)
//                             .paddingSymmetric(horizontal: 96.h),
//                       ]),
//                       getVerSpace(20.h),
//                       Container(
//                         color: context.theme.focusColor,
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 getCustomFont("Reviews", 20.sp,
//                                     context.theme.primaryColor, 1,
//                                     fontWeight: FontWeight.w700),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Constant.sendToNext(context,
//                                         Routes.othorReviewsScreenRoute);
//                                   },
//                                   child: getCustomFont("View all", 14.sp,
//                                       Get.isDarkMode ? regularWhite : grey, 1,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                             getVerSpace(20.h),
//                             review_format(
//                                 "user1st.png",
//                                 "Maria Sana",
//                                 "This Novel Is Awasome I Love It But End is So Sad.",
//                                 "1 h Ago",
//                                 context.theme.focusColor,
//                                 context.theme.primaryColor),
//                             getVerSpace(10.h),
//                             Divider(color: grey20),
//                             getVerSpace(10.h),
//                             review_format(
//                                 "user2nd.png",
//                                 "Maria Sana",
//                                 "This Novel Is Awasome I Love It But End is So Sad.",
//                                 "2 d ago",
//                                 context.theme.focusColor,
//                                 context.theme.primaryColor),
//                             getVerSpace(10.h),
//                             Divider(color: grey20),
//                             getVerSpace(10.h),
//                             review_format(
//                                 "user3rd.png",
//                                 "Maria Sana",
//                                 "This Novel Is Awasome I Love It But End is So Sad.",
//                                 "2 d ago",
//                                 context.theme.focusColor,
//                                 context.theme.primaryColor),
//                           ],
//                         ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
//                       )
//                     ],
//                   ),
//                 ),
//                 getCustomButton("Subscribe now", () {
//
//
//                   // Constant.sendToNextWithResult(context, SubscriptionScreen(storyModel: widget.storyModel),(value){});
//                   Constant.sendToNext(context, Routes.subscriptionScreenRoute);
//                 }).paddingOnly(left: 20.h, right: 20.h, bottom: 20.h, top: 24.h)
//               ],
//             );
//           },
//         )),
//       ),
//     );
//   }
// }
