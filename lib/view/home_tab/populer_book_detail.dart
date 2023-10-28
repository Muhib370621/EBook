import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/ads/AdsFile.dart';
import 'package:ebook_app/main.dart';
import 'package:ebook_app/routes/app_routes.dart';
import 'package:ebook_app/view/home_tab/trending_books/read_book_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../datafile/firebase_data/firebasedata.dart';
import '../../models/book_list_model.dart';
import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../../utils/pref_data.dart';

// ignore: must_be_immutable
class PopularBookDetailScreen extends StatefulWidget {
  StoryModel storyModel;

  PopularBookDetailScreen({super.key, required this.storyModel});

  @override
  State<PopularBookDetailScreen> createState() =>
      _PopularBookDetailScreenState();
}

class _PopularBookDetailScreenState extends State<PopularBookDetailScreen> {
  PopulerBookScreenController controller =
      Get.put(PopulerBookScreenController());

  void backClick() {


    Future.delayed(Duration.zero,() async {
      String isBack = await PrefData.getStoryId();

      if(isBack.isNotEmpty){

        PrefData.setStoryId('');
        Constant.sendToNext(context, Routes.homeMainScreenRoute);

      }else{
        Constant.backToFinish();
      }

    },);



  }

  AdsFile adsFile = AdsFile();

  @override
  void initState() {
    super.initState();


    Future.delayed(Duration.zero, () async {
      await adsFile.createInterstitialAd();
    });

    Future.delayed(Duration.zero, () async {
      controller.getFavDataList();
      controller.getBookMarkList();
    });

    Future.delayed(
      Duration.zero,
      () {
        controller.checkInFav(widget.storyModel.id.toString());
      },
    );

    Future.delayed(
      Duration.zero,
      () {
        controller.checkInBookMark(widget.storyModel.id.toString());
      },
    );

    // if(kIsWeb)
    //   {
    //     return WebPage();  //your web page with web package import in it
    //   }
    // else if (!kIsWeb && io.Platform.isWindows) {
    //   return WindowsPage(); //your window page with window package import in it
    // }
    // else if(!kIsWeb && io.Platform.isAndroid) {
    //   return AndroidPage();  //your android page with android package import in it
    // }

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
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SafeArea(
            child: GetBuilder<PopulerBookScreenController>(
          init: PopulerBookScreenController(),
          builder: (popularBookScreenController) =>
              GetBuilder<PopularBookDetailScreenController>(
            init: PopularBookDetailScreenController(),
            builder: (popularBookDetailScreenController) {
              return getDefaultWidget(Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getCustumAppbar(
                    titlePermission: false,
                    leftIcon: Get.isDarkMode
                        ? "left_arrow_white.svg"
                        : "back_arrow.svg",

                    rightIcon: popularBookScreenController
                        .save.value
                        ? (Get.isDarkMode)
                        ? "white_fill_save.svg"
                        : "black_save_fill.svg"
                        : (Get.isDarkMode)
                        ? "white_border_save_icon.svg"
                        : "saveIconBlackBorder.svg",

                    // rightIcon: Get.isDarkMode
                    //     ? popularBookScreenController.like.value
                    //         ? "white_fill_heart.svg"
                    //         : "white_heart.svg"
                    //     : popularBookScreenController.like.value
                    //         ? "black_fill_heart.svg"
                    //         : "heart_icon.svg",

                    leftFunction: () {
                      backClick();
                    },

                    rightFunction: (){
                      popularBookScreenController
                          .checkInBookMarkList(
                          widget.storyModel);

                      popularBookScreenController
                          .checkInBookMark(widget
                          .storyModel.id ??
                          "");

                      if (popularBookScreenController
                          .save.value) {
                        showCustomToast(
                            message:
                            "Mark as Favourite");
                      } else {
                        showCustomToast(
                            message:
                            "Mark as UnFavourite");
                      }
                    },

                    // rightFunction: () {
                    //   popularBookScreenController
                    //       .checkInFavouriteList(widget.storyModel);
                    //
                    //   // List<String> strList =
                    //   // populerBookScreenController.favouriteList
                    //   //     .map((i) => i
                    //   //     .toString())
                    //   //     .toList();
                    //
                    //   popularBookScreenController
                    //       .checkInFav(widget.storyModel.id ?? "");
                    //
                    //   if (popularBookScreenController.like.value) {
                    //     showCustomToast(message: "Mark as Favourite");
                    //   } else {
                    //     showCustomToast(message: "Mark as UnFavourite");
                    //   }
                    // },
                    givecolor: context.theme.focusColor,
                  ),

                  Expanded(
                    child: Container(
                      color: context.theme.focusColor,
                      child: Obx(() {
                        if (networkManager.isNetwork.value) {
                          return ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              getVerSpace(10.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Container(
                                    height: 337.h,
                                    width: 236.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.r),
                                        image: getDecorationNetworkImage(context, widget.storyModel.image ?? "",fit: BoxFit.cover)
                                    ),
                                  )

                                ],
                              ),
                              getVerSpace(20.h),
                              getCustomFont(
                                  widget.storyModel.name ?? "",
                                  24.sp,
                                  context.theme.primaryColor,
                                  2,
                                  fontWeight: FontWeight.w700,textAlign: TextAlign.center).marginSymmetric(horizontal: 20.h),
                              getVerSpace(8.h),
                              StreamBuilder<QuerySnapshot>(
                                stream: FireBaseData.getAuthorById(
                                    id: widget.storyModel.authId ?? []),

                                // FirebaseFirestore.instance
                                //     .collection(KeyTable.authorList).doc(widget.storyModel.authId)
                                //     .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null &&
                                      snapshot.connectionState ==
                                          ConnectionState.active) {

                                    List<DocumentSnapshot> list = snapshot.data!.docs;

                                    String auth = FireBaseData.getAuthorName(author: widget.storyModel.authId!, list: list);

                                    // TopAuthors auth =
                                    //     TopAuthors.fromFirestore(
                                    //         snapshot.data!);

                                    return getCustomFont(
                                        auth,
                                        16.sp,
                                        grey,
                                        2,
                                        fontWeight: FontWeight.w400,textAlign: TextAlign.center).marginSymmetric(horizontal: 20.h);
                                  } else {
                                    return getCustomFont(
                                        "", 16.sp, grey, 1,
                                        fontWeight: FontWeight.w400);
                                  }
                                },
                              ),
                              // Container(
                              //   height: 56.h,
                              //   color: Get.theme.focusColor,
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Container(
                              //         decoration: BoxDecoration(
                              //             borderRadius:
                              //                 BorderRadius.all(
                              //                     Radius.circular(
                              //                         16.h)),
                              //             color: Get.isDarkMode
                              //                 ? grey
                              //                 : grey10),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment
                              //                   .spaceBetween,
                              //           children: [
                              //             getAssetImage("view.png",height: 18.h,color: Colors.grey.shade400,width: 18.h),
                              //             getHorSpace(16.h),
                              //             getCustomFont(
                              //                 widget.storyModel.views
                              //                     .toString(),
                              //                 16.sp,
                              //                 context
                              //                     .theme.primaryColor,
                              //                 1,
                              //                 fontWeight:
                              //                     FontWeight.w700),
                              //
                              //             // getCustomFont(
                              //             //     "Readers",
                              //             //     16.sp,
                              //             //     context
                              //             //         .theme.primaryColor,
                              //             //     1,
                              //             //     fontWeight:
                              //             //         FontWeight.w400),
                              //
                              //           ],
                              //         ).paddingSymmetric(
                              //             horizontal: 16.h,
                              //             vertical: 16.h),
                              //       ),
                              //       // Container(
                              //       //   decoration: BoxDecoration(
                              //       //       borderRadius: BorderRadius.all(
                              //       //           Radius.circular(16.h)),
                              //       //       color:  Get.isDarkMode?grey:grey10),
                              //       //   child: Row(
                              //       //     mainAxisAlignment:
                              //       //     MainAxisAlignment.spaceBetween,
                              //       //     children: [
                              //       //       Row(
                              //       //         children: [
                              //       //           getSvgImage("star_icon.svg",
                              //       //               height: 20.h, width: 20.h),
                              //       //           getCustomFont(
                              //       //               "4.3", 16.sp, context.theme.primaryColor, 1,
                              //       //               fontWeight: FontWeight.w700),
                              //       //         ],
                              //       //       ),
                              //       //       // getHorSpace(16.h),
                              //       //       // getCustomFont(
                              //       //       //     "Reviews", 16.sp, context.theme.primaryColor, 1,
                              //       //       //     fontWeight: FontWeight.w400),
                              //       //     ],
                              //       //   ).paddingSymmetric(
                              //       //       horizontal: 16.h, vertical: 16.h),
                              //       // ),
                              //       Container(
                              //         decoration: BoxDecoration(
                              //             borderRadius:
                              //                 BorderRadius.all(
                              //                     Radius.circular(
                              //                         16.h)),
                              //             color: Get.isDarkMode
                              //                 ? grey
                              //                 : regularWhite,
                              //             border: Border.all(
                              //                 color: Get.isDarkMode
                              //                     ? grey
                              //                     : grey20)),
                              //         child: GestureDetector(
                              //           onTap: () {
                              //             popularBookScreenController
                              //                 .checkInBookMarkList(
                              //                     widget.storyModel);
                              //
                              //             popularBookScreenController
                              //                 .checkInBookMark(widget
                              //                         .storyModel.id ??
                              //                     "");
                              //
                              //             if (popularBookScreenController
                              //                 .save.value) {
                              //               showCustomToast(
                              //                   message:
                              //                       "Mark as Read");
                              //             } else {
                              //               showCustomToast(
                              //                   message:
                              //                       "Mark as UnRead");
                              //             }
                              //             // populerBookScreenController.setSavePosition();
                              //           },
                              //           child: getSvgImage(popularBookScreenController
                              //                       .save.value
                              //                   ? (Get.isDarkMode)
                              //                       ? "white_fill_save.svg"
                              //                       : "black_save_fill.svg"
                              //                   : (Get.isDarkMode)
                              //                       ? "white_border_save_icon.svg"
                              //                       : "saveIconBlackBorder.svg")
                              //               .paddingAll(16.h),
                              //         ),
                              //       )
                              //     ],
                              //   ).paddingSymmetric(horizontal: 20.h),
                              // ),
                              getVerSpace(32.h),
                              HtmlWidget(
                                decode(widget.storyModel.desc ?? ""),
                                textStyle: TextStyle(
                                  color: context.theme.primaryColor,
                                  fontSize: 16.h,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5.h

                                ),

                              ).paddingSymmetric(horizontal: 20.h),
                              // getMultilineCustomFont(
                              //         removeAllHtmlTags(
                              //             widget.storyModel.desc ?? ""),
                              //         16.h,
                              //         context.theme.primaryColor,
                              //         fontWeight: FontWeight.w400,
                              //         textAlign: TextAlign.center,
                              //         txtHeight: 1.5.h)
                              //     ,
                              getVerSpace(20.h),
                              // Row(
                              //   mainAxisAlignment:
                              //   MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Container(
                              //             height: 56.h,
                              //             width: 56.h,
                              //             decoration: BoxDecoration(
                              //                 shape: BoxShape.circle),
                              //             child: getAssetImage(
                              //                 "user_iage.png",
                              //                 boxFit: BoxFit.fill)),
                              //         getHorSpace(16.h),
                              //         getCustomFont("Carter Bays", 16.sp,
                              //             context.theme.primaryColor, 1,
                              //             fontWeight: FontWeight.w700)
                              //       ],
                              //     ),
                              //     getCustomButton("Follow", () {},
                              //         decoration: BoxDecoration(
                              //             border: Border.all(
                              //                 color: maximumOrange),
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(16.h)),
                              //             color: context.theme.focusColor),
                              //         buttonheight: 40.h,
                              //         buttonwidth: 90.h,
                              //         color: maximumOrange)
                              //   ],
                              // ).paddingSymmetric(horizontal: 20.h),
                              // getVerSpace(16.h)
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              getVerSpace(10.h),
                              getShimmerWidget(context, Container(
                                height: 337.h,
                                width: 236.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    image: getDecorationNetworkImage(context, widget.storyModel.image ?? "",fit: BoxFit.cover)
                                ),
                              )),

                              getVerSpace(20.h),

                              getShimmerWidget(
                                  context,
                                  Container(
                                    color: Colors.grey,
                                    child: getShimmerWidget(context, getCustomFont(widget.storyModel.name ?? "", 24.sp,
                                        context.theme.primaryColor, 1,
                                        fontWeight: FontWeight.w700)),
                                  )),
                              getVerSpace(5.h),
                              getShimmerWidget(context, Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.h),
                                color: Colors.grey,
                                child: getCustomFont(widget.storyModel.authId.toString(), 16.sp, grey, 1,
                                    fontWeight: FontWeight.w400),
                              )),
                              getVerSpace(20.h),
                              // Container(
                              //   height: 56.h,
                              //   color: Get.theme.focusColor,
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       getShimmerWidget(context, Container(
                              //         decoration: BoxDecoration(
                              //             borderRadius:
                              //             BorderRadius.all(
                              //                 Radius.circular(
                              //                     16.h)),
                              //             color: Get.isDarkMode
                              //                 ? grey
                              //                 : grey10),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //           MainAxisAlignment
                              //               .spaceBetween,
                              //           children: [
                              //             getCustomFont(
                              //                 widget.storyModel.views
                              //                     .toString(),
                              //                 16.sp,
                              //                 context
                              //                     .theme.primaryColor,
                              //                 1,
                              //                 fontWeight:
                              //                 FontWeight.w700),
                              //             getHorSpace(16.h),
                              //             getCustomFont(
                              //                 "Readers",
                              //                 16.sp,
                              //                 context
                              //                     .theme.primaryColor,
                              //                 1,
                              //                 fontWeight:
                              //                 FontWeight.w400),
                              //           ],
                              //         ).paddingSymmetric(
                              //             horizontal: 16.h,
                              //             vertical: 16.h),
                              //       )),
                              //
                              //       // getShimmerWidget(context, Container(
                              //       //   decoration: BoxDecoration(
                              //       //       borderRadius:
                              //       //       BorderRadius.all(
                              //       //           Radius.circular(
                              //       //               16.h)),
                              //       //       color: Get.isDarkMode
                              //       //           ? grey
                              //       //           : regularWhite,
                              //       //       border: Border.all(
                              //       //           color: Get.isDarkMode
                              //       //               ? grey
                              //       //               : grey20)),
                              //       //   child: GestureDetector(
                              //       //     onTap: () {
                              //       //       popularBookScreenController
                              //       //           .checkInBookMarkList(
                              //       //           widget.storyModel);
                              //       //
                              //       //       popularBookScreenController
                              //       //           .checkInBookMark(widget
                              //       //           .storyModel.id ??
                              //       //           "");
                              //       //
                              //       //       if (popularBookScreenController
                              //       //           .save.value) {
                              //       //         showCustomToast(
                              //       //             message:
                              //       //             "Mark as Read");
                              //       //       } else {
                              //       //         showCustomToast(
                              //       //             message:
                              //       //             "Mark as UnRead");
                              //       //       }
                              //       //       // populerBookScreenController.setSavePosition();
                              //       //     },
                              //       //     child: getSvgImage(popularBookScreenController
                              //       //         .save.value
                              //       //         ? (Get.isDarkMode)
                              //       //         ? "white_fill_save.svg"
                              //       //         : "black_save_fill.svg"
                              //       //         : (Get.isDarkMode)
                              //       //         ? "white_border_save_icon.svg"
                              //       //         : "saveIconBlackBorder.svg")
                              //       //         .paddingAll(16.h),
                              //       //   ),
                              //       // ))
                              //     ],
                              //   ).paddingSymmetric(horizontal: 20.h),
                              // ),
                              getVerSpace(20.h),
                              getShimmerWidget(context, Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.h),
                                color: Colors.grey,
                                child: getMultilineCustomFont(

                                    removeAllHtmlTags(
                                        widget.storyModel.desc ?? ""),

                                    16.h,
                                    context.theme.primaryColor,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.center,
                                    txtHeight: 1.5.h).paddingSymmetric(horizontal: 20.h),
                              )),
                              getVerSpace(20.h),
                              // Row(
                              //   mainAxisAlignment:
                              //   MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Container(
                              //             height: 56.h,
                              //             width: 56.h,
                              //             decoration: BoxDecoration(
                              //                 shape: BoxShape.circle),
                              //             child: getAssetImage(
                              //                 "user_iage.png",
                              //                 boxFit: BoxFit.fill)),
                              //         getHorSpace(16.h),
                              //         getCustomFont("Carter Bays", 16.sp,
                              //             context.theme.primaryColor, 1,
                              //             fontWeight: FontWeight.w700)
                              //       ],
                              //     ),
                              //     getCustomButton("Follow", () {},
                              //         decoration: BoxDecoration(
                              //             border: Border.all(
                              //                 color: maximumOrange),
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(16.h)),
                              //             color: context.theme.focusColor),
                              //         buttonheight: 40.h,
                              //         buttonwidth: 90.h,
                              //         color: maximumOrange)
                              //   ],
                              // ).paddingSymmetric(horizontal: 20.h),
                              // getVerSpace(16.h)
                            ],
                          );
                        }
                      }),
                    ),
                  ),

                  Obx(() {
                    if(networkManager.isNetwork.value){
                      return getCustomReadButton("Read Book", () {
                        if (kIsWeb) {
                          Constant.sendToNextWithResult(context,
                              ReadBookScreen(storyModel: widget.storyModel), () {});
                        } else {
                          adsFile.showInterstitialAd(() {
                            Constant.sendToNextWithResult(
                                context,
                                ReadBookScreen(storyModel: widget.storyModel),
                                    () {});

                            // Constant.sendToNextWithResult(context, CustomSearchPdfViewer(), (){});
                          });
                        }
                        // Constant.launchURL(widget.storyModel.pdf!);

                        // html.window.open(url, "_blank");
                        // html.Url.revokeObjectUrl(url);

                        // Constant.sendToNextWithResult(context, SubscriptionScreen(storyModel: widget.storyModel),(value){});
                      },isIcon: true).paddingOnly(
                          left: 20.h, right: 20.h, bottom: 20.h, top: 24.h);
                    }else{
                      return getShimmerWidget(context, getCustomButton("Read Book", () {

                      }).paddingOnly(
                          left: 20.h, right: 20.h, bottom: 20.h, top: 24.h));
                    }
                  })
                ],
              ));
            },
          ),
        )),
      ),
    );
  }
}
