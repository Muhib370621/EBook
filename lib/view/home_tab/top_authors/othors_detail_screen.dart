import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/datafile/firebase_data/firebasedata.dart';
import 'package:ebook_app/datafile/firebase_data/key_table.dart';
import 'package:ebook_app/main.dart';
import 'package:ebook_app/models/book_list_model.dart';
import 'package:ebook_app/view/home_tab/populer_book_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';
import '../../../models/top_authors_model.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/color_category.dart';
import '../../../utils/constant.dart';
import '../../../utils/constantWidget.dart';

// ignore: must_be_immutable
class TopAuthorDetailScreen extends StatefulWidget {
  TopAuthors authModel;

  TopAuthorDetailScreen({super.key, required this.authModel});

  @override
  State<TopAuthorDetailScreen> createState() => _TopAuthorDetailScreenState();
}

class _TopAuthorDetailScreenState extends State<TopAuthorDetailScreen> {
  AuthorDetailScreenController authorDetailScreenController =
      Get.put(AuthorDetailScreenController());

  // List<TopAuthors1> topAuthors = DataFile.getTopAuthorsData();
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
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SafeArea(
            child: getDefaultWidget(Column(
              children: [
                //getCustumAppbar(rightPermission: false,leftIcon: "back_arrow.svg",titlePermission: false,colorPermition: false,leftFunction: (){backClick();}),
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [


                      Container(
                        color: context.theme.focusColor,
                        child: Obx(() {
                          if(networkManager.isNetwork.value){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                getVerSpace(26.h),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                      onTap: () {
                                        backClick();
                                      },
                                      child: getSvgImage(Get.isDarkMode
                                          ? "left_arrow_white.svg"
                                          : "back_arrow.svg")),
                                ),
                                getVerSpace(26.h),

                                Obx(() {
                                  if(networkManager.isNetwork.value){
                                    return ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(274.h / 2),
                                        child: getNetWorkImage(
                                            context,
                                            widget.authModel.image ?? "",
                                            144.h,
                                            144.h,
                                            boxFit: BoxFit.fill));
                                  }else{
                                    return getShimmerWidget(context, ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(274.h / 2),
                                        child: Container(
                                          height: 144.h,
                                          width: 144.h,
                                          color: Colors.grey,


                                        )

                                      // getNetWorkImage(
                                      //     context,
                                      //     widget.authModel.image ?? "",
                                      //
                                      //     boxFit: BoxFit.fill))
                                    ));
                                  }
                                }),
                                getVerSpace(24.h),
                                getCustomFont(
                                    widget.authModel.authorName ?? "",
                                    24.sp,
                                    context.theme.primaryColor,
                                    1,
                                    fontWeight: FontWeight.w700),
                                getVerSpace(5.h),
                                getCustomFont(
                                    widget.authModel.designation ?? "",
                                    16.sp,
                                    grey,
                                    1,
                                    fontWeight: FontWeight.w400),

                                getVerSpace(24.h),

                                Align(alignment: Alignment.centerLeft,child: getCustomFont("About", 20.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w600,textAlign: TextAlign.start)),
                                getVerSpace(6.h),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: getMultilineCustomFont(
                                      removeAllHtmlTags(
                                          widget.authModel.desc ?? ""),
                                      16.h,
                                      context.theme.primaryColor,
                                      fontWeight: FontWeight.w400,
                                      textAlign: TextAlign.start,
                                      txtHeight: 1.5.h),
                                ),
                                getVerSpace(20.h)
                              ],
                            ).paddingSymmetric(horizontal: 20.h);
                          }else{
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                getVerSpace(26.h),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                      onTap: () {
                                        backClick();
                                      },
                                      child: getSvgImage(Get.isDarkMode
                                          ? "left_arrow_white.svg"
                                          : "back_arrow.svg")),
                                ),
                                getVerSpace(26.h),

                                getShimmerWidget(context, ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(274.h / 2),
                                    child: Container(
                                      height: 144.h,
                                      width: 144.h,
                                      color: Colors.grey,


                                    )

                                  // getNetWorkImage(
                                  //     context,
                                  //     widget.authModel.image ?? "",
                                  //
                                  //     boxFit: BoxFit.fill))
                                )),
                                getVerSpace(24.h),
                                getShimmerWidget(context,
                                  Container(
                                    color: Colors.grey,
                                    child: getCustomFont(
                                        widget.authModel.authorName ?? "",
                                        24.sp,
                                        context.theme.primaryColor,
                                        1,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                getVerSpace(5.h),
                                getShimmerWidget(
                                  context,
                                  Container(
                                    color: Colors.grey,
                                    child: getCustomFont(
                                        widget.authModel.designation ?? "",
                                        16.sp,
                                        grey,
                                        1,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),

                                getVerSpace(24.h),

                                Align(alignment: Alignment.centerLeft,child: getShimmerWidget(context,Container(color: grey,child: getCustomFont("About", 20.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w600,textAlign: TextAlign.start)))),
                                getVerSpace(6.h),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: getShimmerWidget(
                                    context,
                                    Container(
                                      color: Colors.grey,
                                      child: getMultilineCustomFont(
                                          removeAllHtmlTags(
                                              widget.authModel.desc ?? ""),
                                          16.h,
                                          context.theme.primaryColor,
                                          fontWeight: FontWeight.w400,
                                          textAlign: TextAlign.start,
                                          txtHeight: 1.5.h),
                                    ),
                                  ),
                                ),
                                getVerSpace(20.h)
                              ],
                            ).paddingSymmetric(horizontal: 20.h);
                          }
                        }),
                      ),
                      getVerSpace(20.h),
                      Obx((){
                        if(networkManager.isNetwork.value){
                          return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore
                                .instance
                                .collection(KeyTable.storyList)
                                .where(KeyTable.authId,
                                arrayContains: widget
                                    .authModel.id)
                                .snapshots(),
                            builder: (context, snapshot) {
                              return getWidgetFromStatus(
                                  context: context,
                                  data: snapshot,
                                  child: Builder(
                                    builder: (context) {
                                      if(snapshot.data != null &&
                                          snapshot.data!.size > 0 &&
                                          snapshot.data!.docs.isNotEmpty){
                                        List<DocumentSnapshot>
                                        list =
                                            snapshot.data!
                                                .docs;
                                        return Container(

                                          padding: EdgeInsets.symmetric(vertical: 20.h),
                                          margin: EdgeInsets.only(bottom: 20.h),
                                          width: double.infinity,
                                          color: context.theme.focusColor,
                                          child: Column(
                                            children: [

                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  getCustomFont(
                                                      "Author's Books",
                                                      20.sp,
                                                      context.theme.primaryColor,
                                                      1,
                                                      fontWeight:
                                                      FontWeight.w700),
                                                  // GestureDetector(
                                                  //     onTap: () {
                                                  //       Constant.sendToNext(context, Routes.populerBookScreenRoute);
                                                  //     },
                                                  //     child: getCustomFont(
                                                  //         "View all",
                                                  //         14.sp,
                                                  //         grey,
                                                  //         1,
                                                  //         fontWeight:
                                                  //         FontWeight.w400))
                                                ],
                                              ).paddingSymmetric(
                                                  horizontal: 20.h),
                                              getVerSpace(16.h),

                                              SizedBox(
                                                height: 252.h,
                                                child: ListView
                                                    .builder(
                                                  physics:
                                                  BouncingScrollPhysics(),
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      10.h),
                                                  itemCount:
                                                  list.length,
                                                  scrollDirection:
                                                  Axis.horizontal,
                                                  itemBuilder:
                                                      (context,
                                                      index) {
                                                    StoryModel
                                                    story =
                                                    StoryModel
                                                        .fromFirestore(
                                                        list[index]);

                                                    return StreamBuilder<QuerySnapshot>(
                                                      stream: FireBaseData.getAuthorById(id: story.authId ?? []),
                                                      builder: (context, snapshot1) {

                                                        if(snapshot1.data != null){
                                                          List<DocumentSnapshot> list = snapshot1.data!.docs;

                                                          String auth = FireBaseData.getAuthorName(author: story.authId!, list: list);


                                                          // TopAuthors auth = TopAuthors.fromFirestore(snapshot1.data!);
                                                          return getCommonBookWidget(
                                                              context,
                                                              story
                                                                  .image ?? "",
                                                              story
                                                                  .name ?? "",
                                                              auth,
                                                                  () {
                                                                Constant.sendToNextWithResult(context, PopularBookDetailScreen(storyModel: story), (){});
                                                              })
                                                              .paddingSymmetric(
                                                              horizontal:
                                                              10.h);
                                                        }else{
                                                          return getCommonBookWidget(
                                                              context,
                                                              story
                                                                  .image!,
                                                              story
                                                                  .name!,
                                                              "",
                                                                  () {
                                                                Constant.sendToNextWithResult(context, PopularBookDetailScreen(storyModel: story), (){});
                                                              })
                                                              .paddingSymmetric(
                                                              horizontal:
                                                              10.h);
                                                        }

                                                      },);





                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }else{
                                        return Container();
                                      }
                                    },
                                  ));
                            },
                          );
                        }else{
                          return Column(
                            children: [

                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  getCustomFont(
                                      "Related Books",
                                      20.sp,
                                      context.theme.primaryColor,
                                      1,
                                      fontWeight:
                                      FontWeight.w700),
                                  // GestureDetector(
                                  //     onTap: () {
                                  //       Constant.sendToNext(context, Routes.populerBookScreenRoute);
                                  //     },
                                  //     child: getCustomFont(
                                  //         "View all",
                                  //         14.sp,
                                  //         grey,
                                  //         1,
                                  //         fontWeight:
                                  //         FontWeight.w400))
                                ],
                              ).paddingSymmetric(
                                  horizontal: 20.h),
                              getVerSpace(16.h),

                              SizedBox(
                                height: 252.h,
                                child: ListView
                                    .builder(
                                  physics:
                                  BouncingScrollPhysics(),
                                  padding: EdgeInsets
                                      .symmetric(
                                      horizontal:
                                      10.h),
                                  itemCount:
                                  5,
                                  scrollDirection:
                                  Axis.horizontal,
                                  itemBuilder:
                                      (context,
                                      index) {


                                    return getCommonBookShimmerWidget(
                                      context,)
                                        .paddingSymmetric(
                                        horizontal:
                                        10.h);





                                  },
                                ),
                              ),
                            ],
                          ).paddingSymmetric(vertical: 20.h);
                        }
                      }),

                      Container(
                          color: context.theme.focusColor,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  getCustomFont(
                                      "Popular Books",
                                      20.sp,
                                      context.theme.primaryColor,
                                      1,
                                      fontWeight:
                                      FontWeight.w700),
                                  GestureDetector(
                                      onTap: () {
                                        Constant.sendToNext(context, Routes.populerBookScreenRoute);
                                      },
                                      child: getCustomFont(
                                          "View all",
                                          14.sp,
                                          grey,
                                          1,
                                          fontWeight:
                                          FontWeight.w400))
                                ],
                              ).paddingSymmetric(
                                  horizontal: 20.h),
                              getVerSpace(16.h),
                              Obx(() {
                                if(networkManager.isNetwork.value){
                                  return SizedBox(
                                    height: 252.h,
                                    child:
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FireBaseData.getPopularList(limit: 3),

                                      // FirebaseFirestore
                                      //     .instance
                                      //     .collection(
                                      //     KeyTable.storyList)
                                      // // .where(KeyTable.authId,
                                      // //     isEqualTo: widget
                                      // //         .authModel.refId)
                                      //     .snapshots(),
                                      builder: (context, snapshot) {
                                        return getWidgetFromStatus(
                                            context: context,
                                            data: snapshot,
                                            child: checkEmptyData(
                                                context: context,
                                                querySnapshot:
                                                snapshot,
                                                child: Builder(
                                                  builder: (context) {
                                                    List<DocumentSnapshot>
                                                    list =
                                                        snapshot.data!
                                                            .docs;
                                                    return ListView
                                                        .builder(
                                                      physics:
                                                      BouncingScrollPhysics(),
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          10.h),
                                                      itemCount:
                                                      list.length,
                                                      scrollDirection:
                                                      Axis.horizontal,
                                                      itemBuilder:
                                                          (context,
                                                          index) {
                                                        StoryModel
                                                        story =
                                                        StoryModel
                                                            .fromFirestore(
                                                            list[index]);

                                                        return StreamBuilder<QuerySnapshot>(
                                                          stream: FireBaseData.getAuthorById(id: story.authId ?? []),
                                                          builder: (context, snapshot1) {

                                                            if(snapshot1.data != null){

                                                              List<DocumentSnapshot> list = snapshot1.data!.docs;

                                                              String auth = FireBaseData.getAuthorName(author: story.authId!, list: list);

                                                              // TopAuthors auth = TopAuthors.fromFirestore(snapshot1.data!);
                                                              return getCommonBookWidget(
                                                                  context,
                                                                  story
                                                                      .image ?? "",
                                                                  story
                                                                      .name ?? "",
                                                                  auth,
                                                                      () {
                                                                    Constant.sendToNextWithResult(context, PopularBookDetailScreen(storyModel: story), (){});
                                                                  })
                                                                  .paddingSymmetric(
                                                                  horizontal:
                                                                  10.h);
                                                            }else{
                                                              return getCommonBookWidget(
                                                                  context,
                                                                  story
                                                                      .image!,
                                                                  story
                                                                      .name!,
                                                                  "",
                                                                      () {
                                                                    Constant.sendToNextWithResult(context, PopularBookDetailScreen(storyModel: story), (){});
                                                                  })
                                                                  .paddingSymmetric(
                                                                  horizontal:
                                                                  10.h);
                                                            }

                                                          },);





                                                      },
                                                    );
                                                  },
                                                )));
                                      },
                                    ),
                                  );
                                }else{
                                  return SizedBox(
                                    height: 252.h,
                                    child:
                                      ListView
                                      .builder(
                                      physics:
                                      BouncingScrollPhysics(),
                                padding: EdgeInsets
                                    .symmetric(
                                horizontal:
                                10.h),
                                itemCount:
                                5,
                                scrollDirection:
                                Axis.horizontal,
                                itemBuilder:
                                (context,
                                index) {

                                  return getCommonBookShimmerWidget(
                                      context)
                                      .paddingSymmetric(
                                      horizontal:
                                      10.h);





                                },
                                )
                                  );
                                }
                              })
                            ],
                          ).paddingSymmetric(vertical: 20.h))
                      // Container(
                      //   color: context.theme.focusColor,
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment:
                      //             MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           getCustomFont("Reviews", 20.sp,
                      //               context.theme.primaryColor, 1,
                      //               fontWeight: FontWeight.w700),
                      //           GestureDetector(
                      //             onTap: () {
                      //               Constant.sendToNext(context,
                      //                   Routes.othorReviewsScreenRoute);
                      //             },
                      //             child: getCustomFont(
                      //                 "View all", 14.sp, grey, 1,
                      //                 fontWeight: FontWeight.w400),
                      //           ),
                      //         ],
                      //       ),
                      //       getVerSpace(20.h),
                      //       riview_formate(
                      //           "user1st.png",
                      //           "Maria Sana",
                      //           "This Novel Is Awasome I Love It But End is So Sad.",
                      //           "1 h Ago",
                      //           context.theme.focusColor,
                      //           context.theme.primaryColor),
                      //       getVerSpace(10.h),
                      //       Divider(color: grey20),
                      //       getVerSpace(10.h),
                      //       riview_formate(
                      //           "user2nd.png",
                      //           "Maria Sana",
                      //           "This Novel Is Awasome I Love It But End is So Sad.",
                      //           "2 d ago",
                      //           context.theme.focusColor,
                      //           context.theme.primaryColor),
                      //       getVerSpace(10.h),
                      //       Divider(color: grey20),
                      //       getVerSpace(10.h),
                      //       riview_formate(
                      //           "user3rd.png",
                      //           "Maria Sana",
                      //           "This Novel Is Awasome I Love It But End is So Sad.",
                      //           "2 d ago",
                      //           context.theme.focusColor,
                      //           context.theme.primaryColor),
                      //     ],
                      //   ).paddingSymmetric(
                      //       horizontal: 20.h, vertical: 20.h),
                      // ).paddingOnly(bottom: 20.h)
                    ],
                  ),
                ),
              ],
            ))),
      ),
    );
  }


  ListView getRelatedBookProgressWidget() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return getCommonBookShimmerWidget(context)
            .paddingSymmetric(horizontal: 10.h);
      },
    );
  }

}
