import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/datafile/firebase_data/firebasedata.dart';
import 'package:ebook_app/datafile/firebase_data/key_table.dart';
import 'package:ebook_app/models/top_authors_model.dart';
import 'package:ebook_app/utils/color_category.dart';
import 'package:ebook_app/utils/constant.dart';
import 'package:ebook_app/view/home_tab/populer_book_detail.dart';
import 'package:ebook_app/view/home_tab/top_authors/othors_detail_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/controller.dart';
import '../../main.dart';
import '../../models/book_list_model.dart';
import '../../models/slider_model.dart';
import '../../routes/app_routes.dart';
import '../../utils/constantWidget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabController homeTabController = Get.put(HomeTabController());

  RxInt sliderPos = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void backClick() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            SizedBox(
              height: 30.h,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: getCustomFont("No", 15.sp, regularWhite, 1,
                    fontWeight: FontWeight.w700),
                style: ElevatedButton.styleFrom(
                  backgroundColor: maximumOrange,
                  // primary: Colors.black, // Background color
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Constant.closeApp();
                },
                //return true when click on "Yes"
                child: getCustomFont("Yes", 15.sp, regularWhite, 1,
                    fontWeight: FontWeight.w700),
                style: ElevatedButton.styleFrom(
                  backgroundColor: maximumOrange,
                  // primary: Colors.black, // Background color
                ),
              ),
            ),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          titlePadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
          title: getCustomFont("Exit App", 20.sp, context.theme.primaryColor, 1,
              fontWeight: FontWeight.w700),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h),
          buttonPadding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
          actionsPadding:
              EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
          content: getCustomFont(
            "Do you want to exit an App?",
            18.sp,
            context.theme.primaryColor,
            2,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.start,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: GetBuilder<HomeTabController>(
        init: HomeTabController(),
        builder: (homeTabController) => Column(
          children: [
            buildTopAppBarView(context),
            getVerSpace(20.h),
            Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  primary: false,
                  // shrinkWrap: true,
                  child: AnimationLimiter(
                    child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 800),
                            childAnimationBuilder: (widget) => SlideAnimation(
                                  verticalOffset:
                                      MediaQuery.of(context).size.height / 4,
                                  child: FadeInAnimation(
                                    child: widget,
                                  ),
                                ),
                            children: [
                          buildBannerView(),

                          // getVerSpace(16.h),
                          // Container(
                          //     color: context.theme.focusColor,
                          //     child: Column(
                          //       children: [
                          //
                          //         // buildTabView(homeTabController),
                          //         // getVerSpace(24.h),
                          //         // buildBannerView(),
                          //       ],
                          //     )),
                          getVerSpace(16.h),
                          buildFeaturedBookView(context),
                          getVerSpace(20.h),
                          buildAuthorView(context),
                          getVerSpace(20.h),
                          buildPopularBookView(context)
                        ])),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  List<Widget> indicators(BuildContext context, imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        width: (kIsWeb) ? 3.w : 8.h,
        height: (kIsWeb) ? 3.w : 8.h,
        decoration: BoxDecoration(
            color: currentIndex == index
                ? maximumOrange
                : context.theme.indicatorColor,
            shape: BoxShape.circle),
      );
    });
  }

  Container buildFeaturedBookView(BuildContext context) {
    return Container(
        color: context.theme.focusColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCustomFont(
                    "Featured Books", 20.sp, context.theme.primaryColor, 1,
                    fontWeight: FontWeight.w700),
                GestureDetector(
                    onTap: () {
                      Constant.sendToNext(
                          context, Routes.trendindBookScreenRoute);
                    },
                    child: getCustomFont("View all", 14.sp,
                        Get.isDarkMode ? regularWhite : grey, 1,
                        fontWeight: FontWeight.w400))
              ],
            ).paddingSymmetric(horizontal: 20.h),
            getVerSpace(16.h),
            SizedBox(
              height: 252.h,
              child: Obx(() {
                print("snapshot-----${networkManager.isNetwork.value}");

                if (networkManager.isNetwork.value) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: FireBaseData.getFeaturedList(limit: 3),
                    builder: (context, snapshot) {
                      return getWidgetFromStatus(
                        context: context,
                        data: snapshot,
                        progressWidget: getFeaturedBookProgressWidget(),
                        child: checkEmptyData(
                          context: context,
                          querySnapshot: snapshot,
                          child: Builder(
                            builder: (context) {
                              List<DocumentSnapshot> list = snapshot.data!.docs;
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 10.h),
                                itemCount: list.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  StoryModel storyBook =
                                      StoryModel.fromFirestore(list[index]);
                                  // TrenDingBook trending = trendingBook[index];
                                  return StreamBuilder<QuerySnapshot>(
                                    stream: FireBaseData.getAuthorById(
                                        id: storyBook.authId ?? []),

                                    // FirebaseFirestore.instance
                                    //     .collection(KeyTable.authorList)
                                    //     .doc(storyBook.authId)
                                    //     .snapshots(),

                                    builder: (context, snapshot1) {
                                      if (snapshot1.data != null) {
                                        List<DocumentSnapshot> list =
                                            snapshot1.data!.docs;

                                        String auth =
                                        FireBaseData.getAuthorName(
                                            author: storyBook.authId!,
                                            list: list);

                                        // TopAuthors auth =
                                        //     TopAuthors.fromFirestore(
                                        //         snapshot1.data!);

                                        // return getCommonBookShimmerWidget(context)
                                        //     .paddingSymmetric(horizontal: 10.h);

                                        return getCommonBookWidget(
                                            context,
                                            storyBook.image ?? "",
                                            storyBook.name ?? "",
                                            auth, () {
                                          // trendingBookScreenController
                                          //     .onSetIndex(index);
                                          Constant.sendToNextWithResult(
                                              context,
                                              PopularBookDetailScreen(
                                                  storyModel: storyBook),
                                                  () {});
                                        }).paddingSymmetric(
                                            horizontal: 10.h);


                                      } else {
                                        return Container();
                                      }
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return getFeaturedBookProgressWidget();
                }
              }),
            )
          ],
        ).paddingSymmetric(vertical: 20.h));
  }

  ListView getFeaturedBookProgressWidget() {
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

  Container buildPopularBookView(BuildContext context) {
    return Container(
        color: context.theme.focusColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCustomFont(
                    "Popular Books", 20.sp, context.theme.primaryColor, 1,
                    fontWeight: FontWeight.w700),
                GestureDetector(
                    onTap: () {
                      print("${context.theme.primaryColor}");
                      Constant.sendToNext(
                          context, Routes.populerBookScreenRoute);
                    },
                    child: getCustomFont("View all", 14.sp,
                        Get.isDarkMode ? regularWhite : grey, 1,
                        fontWeight: FontWeight.w400))
              ],
            ).paddingSymmetric(horizontal: 20.h),
            getVerSpace(16.h),
            SizedBox(
              height: 252.h,
              child: Obx(() {
                if (networkManager.isNetwork.value) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: FireBaseData.getPopularList(limit: 3),
                    builder: (context, snapshot) {
                      return getWidgetFromStatus(
                          context: context,
                          data: snapshot,
                          child: checkEmptyData(
                              context: context,
                              querySnapshot: snapshot,
                              child: Builder(builder: (context) {
                                List<DocumentSnapshot> list =
                                    snapshot.data!.docs;
                                return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.h),
                                  itemCount: list.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    StoryModel storyBook =
                                        StoryModel.fromFirestore(list[index]);

                                    return StreamBuilder<QuerySnapshot>(
                                      stream: FireBaseData.getAuthorById(
                                          id: storyBook.authId ?? []),
                                      builder: (context, snapshot1) {
                                        if (snapshot1.data != null) {
                                          List<DocumentSnapshot> list =
                                              snapshot1.data!.docs;

                                          String auth =
                                              FireBaseData.getAuthorName(
                                                  author: storyBook.authId!,
                                                  list: list);

                                          // TopAuthors auth =
                                          //     TopAuthors.fromFirestore(
                                          //         snapshot1.data!);

                                          return getCommonBookWidget(
                                              context,
                                              storyBook.image ?? "",
                                              storyBook.name ?? "",
                                              auth, () {
                                            Constant.sendToNextWithResult(
                                                context,
                                                PopularBookDetailScreen(
                                                    storyModel: storyBook),
                                                () {});
                                          }).paddingSymmetric(horizontal: 10.h);

                                          // return GetBuilder<PopulerBookScreenController>(
                                          //     init: PopulerBookScreenController(),
                                          //     builder: (populerBookScreenController) {
                                          //
                                          //       TopAuthors auth = TopAuthors.fromFirestore(authList[index]);
                                          //
                                          //       return trending_populer_book_list_element_formate(
                                          //           storyBook.image ?? "",
                                          //           storyBook.name ?? "",
                                          //           auth.authorName ?? "", () {
                                          //         populerBookScreenController
                                          //               .onSetIndex(index);
                                          //         Constant.sendToNext(
                                          //             context,
                                          //             Routes
                                          //                 .populerBookDetailScreenRoute);
                                          //       }).paddingSymmetric(horizontal: 10.h);
                                          //     }
                                          // );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    );
                                  },
                                );
                              })),
                          progressWidget: getPopularProgressWidget());
                    },
                  );
                } else {
                  return getPopularProgressWidget();
                }
              }),
            )
          ],
        ).paddingSymmetric(vertical: 20.h));
  }

  ListView getPopularProgressWidget() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return getCommonBookShimmerWidget(context)
            .paddingSymmetric(horizontal: 10.h);
      },
    );
  }

  Container buildAuthorView(BuildContext context) {
    return Container(
        color: context.theme.focusColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCustomFont(
                    "Top Authors", 20.sp, context.theme.primaryColor, 1,
                    fontWeight: FontWeight.w700),
                GestureDetector(
                    onTap: () {
                      Constant.sendToNext(
                          context, Routes.topAuthorsScreenRoute);
                    },
                    child: getCustomFont("View all", 14.sp,
                        Get.isDarkMode ? regularWhite : grey, 1,
                        fontWeight: FontWeight.w400))
              ],
            ).paddingSymmetric(horizontal: 20.h),
            getVerSpace(16.h),
            SizedBox(
              height: 136.h,
              child: Obx(() {
                if (networkManager.isNetwork.value) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: FireBaseData.getAuthorList(limit: 4),
                    builder: (context, snapshot) {
                      return getWidgetFromStatus(
                          context: context,
                          data: snapshot,
                          progressWidget: getAuthorProgressWidget(),
                          child: checkEmptyData(
                              context: context,
                              querySnapshot: snapshot,
                              child: Builder(builder: (context) {
                                List<DocumentSnapshot> list =
                                    snapshot.data!.docs;
                                return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.h),
                                  itemCount: list.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    TopAuthors authors =
                                        TopAuthors.fromFirestore(list[index]);
                                    // TopAuthors1 authors =
                                    //     topAuthors[index];
                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // topAuthorsScreenController
                                            //     .onSetOthorIndex(index);
                                            Constant.sendToNextWithResult(
                                                context,
                                                TopAuthorDetailScreen(
                                                    authModel: authors),
                                                    () {});
                                          },
                                          child: buildCommonAuthorsWidget(
                                              context, authors),
                                        ),
                                        getHorSpace(16.5.h),
                                        index == list.length - 1
                                            ? const SizedBox()
                                            : Container(
                                                height: 136.h,
                                                width: 1.h,
                                                color: grey20,
                                              )
                                      ],
                                    ).paddingSymmetric(horizontal: 8.h);
                                  },
                                );
                              })));
                    },
                  );
                } else {
                  return getAuthorProgressWidget();
                }
              }),
            )
          ],
        ).paddingSymmetric(vertical: 20.h));
  }

  ListView getAuthorProgressWidget() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      itemCount: 4,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Row(
          children: [
            buildCommonAuthorsShimmerWidget(context),
            getHorSpace(16.5.h),
            index == 4
                ? const SizedBox()
                : Container(
                    height: 133.h,
                    width: 1.h,
                    color: grey20,
                  )
          ],
        ).paddingSymmetric(horizontal: 8.h);
      },
    );
  }

  Widget buildCommonAuthorsShimmerWidget(BuildContext context) {
    return getShimmerWidget(
        context,
        Container(
          color: Colors.grey,
          height: 136.h,
          child: Column(
            children: [
              Container(
                height: 77.h,
                width: 100.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // image: getDecorationNetworkImage(context, authors.image ?? "",
                  //     fit: BoxFit.cover),
                ),
              ),
              getCustomFont(" ", 16.sp, context.theme.primaryColor, 1,
                  fontWeight: FontWeight.w700),
              getVerSpace(3.h),
              getCustomFont(" ", 14.sp, grey, 1, fontWeight: FontWeight.w400),
            ],
          ),
        ));
  }

  Widget buildBannerView() {
    return FutureBuilder<List<DocumentSnapshot>?>(
      future: FireBaseData.fetchSliderData(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          List<DocumentSnapshot> list = snapshot.data!;

          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                (list.isNotEmpty) ? getVerSpace(20.h) : getVerSpace(0),
                Obx(() {
                  if (networkManager.isNetwork.value) {
                    return SizedBox(
                      height: 197.h,
                      width: double.infinity,
                      child: CarouselSlider(
                          items: List.generate(list.length, (index) {
                            Color color = "#8ABEC3".toColor();
                            // Color color = "#9274BA".toColor();
                            if (index % 3 == 1) {
                              // color = "#9274BA".toColor();
                              color = "#F67266".toColor();
                            } else if (index % 3 == 2) {
                              color = "#9274BA".toColor();
                              // color = "#8ABEC3".toColor();
                            }

                            SliderModel slider =
                                SliderModel.fromFirestore(list[index]);

                            // if(slider.storyId!.isNotEmpty && slider.storyId != null){
                            return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection(KeyTable.storyList)
                                  .doc(slider.storyId)
                                  .get(),
                              builder: (context, snap) {
                                if (snap.data != null &&
                                    snap.connectionState ==
                                        ConnectionState.done) {
                                  StoryModel book =
                                      StoryModel.fromFirestore(snap.data!);

                                  return StreamBuilder<QuerySnapshot>(
                                    stream: FireBaseData.getAuthorById(
                                        id: book.authId!),

                                    // FirebaseFirestore.instance
                                    //     .collection(KeyTable.authorList)
                                    //     .doc(book.authId)
                                    //     .get(),
                                    builder: (context, snapshot1) {
                                      if (snapshot1.data != null) {
                                        return getCommonBannerWidget(
                                            color, book, slider, context);
                                      } else {
                                        return Container();
                                      }
                                    },
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return getCommonBannerShimmerWidget(context);
                                } else {
                                  return Container();
                                }
                              },
                            );
                            // }else{
                            //   return getCommonBanner1View(
                            //     context, slider,true);
                            //
                            // }
                          }),
                          options: CarouselOptions(
                            viewportFraction: 0.8,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            onPageChanged: (position, reason) {
                              sliderPos.value = position;
                            },
                            scrollDirection: Axis.horizontal,
                          )),
                    );
                  } else {
                    return getCommonBannerShimmerWidget(context);
                  }
                }),
                (list.isNotEmpty) ? getVerSpace(18.h) : getVerSpace(0),
                (list.isNotEmpty)
                    ? ObxValue(
                        (p0) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: indicators(context, list.length, sliderPos.value)),
                        sliderPos)
                    : Container(),
              ],
            );
          } else {
            return getCommonBannerShimmerWidget(context);
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget getCommonBanner1View(
      BuildContext context, SliderModel slider, bool isCustom) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(slider.link ?? ""));
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 7.h),
        decoration: BoxDecoration(
            image: getDecorationNetworkImage(context,
                (isCustom) ? slider.customImg ?? "" : slider.image ?? "",
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(
              12.r,
            )),
      ),
    );
  }

  // SizedBox buildBannerView() {
  //   return SizedBox(
  //     height: 320.h,
  //     child: FutureBuilder<List<DocumentSnapshot>?>(
  //       future: FireBaseData.fetchSliderData(),
  //       builder: (context, snapshot) {
  //         if (snapshot.data != null) {
  //           List<DocumentSnapshot> list = snapshot.data!;
  //
  //           return SizedBox(
  //             height: 330.h,
  //             width: double.infinity,
  //             child: CarouselSlider(
  //                 items: List.generate(list.length, (index) {
  //                   Color color = const Color(0XFFFFE7E4);
  //                   if (index % 3 == 1) {
  //                     color = const Color(0XFFDBF2F7);
  //                   } else if (index % 3 == 2) {
  //                     color = const Color(0XFFE0E2FF);
  //                   }
  //
  //                   SliderModel book = SliderModel.fromFirestore(list[index]);
  //                   return FutureBuilder<DocumentSnapshot>(
  //                     future: FirebaseFirestore.instance
  //                         .collection(KeyTable.storyList)
  //                         .doc(book.storyId)
  //                         .get(),
  //                     builder: (context, snapshot) {
  //                       if (snapshot.data != null &&
  //                           snapshot.connectionState == ConnectionState.done) {
  //                         StoryModel book =
  //                             StoryModel.fromFirestore(snapshot.data!);
  //
  //                         return FutureBuilder<DocumentSnapshot>(
  //                           future: FirebaseFirestore.instance
  //                               .collection(KeyTable.authorList)
  //                               .doc(book.authId)
  //                               .get(),
  //                           builder: (context, snapshot1) {
  //                             if (snapshot1.data != null) {
  //                               TopAuthors auth =
  //                                   TopAuthors.fromFirestore(snapshot1.data!);
  //
  //                               return getCommonBannerWidget(
  //                                   color, book, auth, context);
  //                             } else {
  //                               return Container();
  //                             }
  //                           },
  //                         );
  //                       } else if (snapshot.connectionState ==
  //                           ConnectionState.waiting) {
  //                         print("connection----------waiting}");
  //
  //                         return getCommonBannerShimmerWidget(color, context);
  //                       } else {
  //                         return Container();
  //                       }
  //                     },
  //                   );
  //                 }),
  //                 options: CarouselOptions(
  //                   viewportFraction: 0.50,
  //                   autoPlay: true,
  //                   enlargeCenterPage: true,
  //                   onPageChanged: (position, reason) {
  //                     sliderPos.value = position;
  //                   },
  //                   scrollDirection: Axis.horizontal,
  //                 )),
  //           );
  //
  //           // return ScrollSnapList(
  //           //   updateOnScroll: true,
  //           //   scrollDirection: Axis.horizontal,
  //           //   itemSize: 220.h,
  //           //   focusOnItemTap: true,
  //           //   initialIndex: 1,
  //           //   shrinkWrap: true,
  //           //   dynamicItemSize: true,
  //           //   itemBuilder: (context, p1) {
  //           //
  //           //     // print("p1-----$p1-----$p0");
  //           //
  //           //   },
  //           //   // itemSize: 200.h,
  //           //   itemCount: list.length,
  //           //   onItemFocus: (int) {
  //           //     // return _onItemFocus(int);
  //           //   },
  //           // );
  //         } else {
  //           return SizedBox(
  //             height: 330.h,
  //             width: double.infinity,
  //             child: CarouselSlider(
  //                 items: List.generate(5, (index) {
  //                   Color color = const Color(0XFFFFE7E4);
  //                   if (index % 3 == 1) {
  //                     color = const Color(0XFFDBF2F7);
  //                   } else if (index % 3 == 2) {
  //                     color = const Color(0XFFE0E2FF);
  //                   }
  //
  //                   return getShimmerWidget(
  //                       context,
  //                       Container(
  //                         height: double.infinity,
  //                         // width: 236.h,
  //                         child: Stack(
  //                           children: [
  //                             Container(
  //                               // height: 223.h,
  //                               width: double.infinity,
  //                               decoration: BoxDecoration(
  //                                   color: color,
  //                                   borderRadius: BorderRadius.circular(16.h)),
  //                               margin: EdgeInsets.only(top: 66.h),
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.end,
  //                                 children: [
  //                                   getCustomFont("", 16.sp, regularBlack, 1,
  //                                       fontWeight: FontWeight.w700),
  //                                   getVerSpace(3.h),
  //                                   getCustomFont("", 14.sp, grey, 1,
  //                                       fontWeight: FontWeight.w400),
  //                                   getVerSpace(20.h),
  //                                 ],
  //                               ),
  //                             ).paddingOnly(top: 0.h),
  //                             Container(
  //                                 // width: 158.h,
  //                                 margin: EdgeInsets.only(
  //                                     bottom: 70.h, left: 35.h, right: 35.h),
  //                                 // height: 224.h,
  //                                 decoration: BoxDecoration(
  //                                     color: color,
  //                                     borderRadius: BorderRadius.circular(16.h),
  //                                     image: getDecorationNetworkImage(
  //                                         context, "",
  //                                         fit: BoxFit.cover)))
  //                           ],
  //                         ),
  //                       ));
  //                 }),
  //                 options: CarouselOptions(
  //                   viewportFraction: 0.50,
  //                   autoPlay: true,
  //                   enlargeCenterPage: true,
  //                   onPageChanged: (position, reason) {
  //                     sliderPos.value = position;
  //                   },
  //                   scrollDirection: Axis.horizontal,
  //                 )),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  Widget getCommonBannerWidget(
      Color color, StoryModel book, SliderModel slider, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constant.sendToNextWithResult(
            context, PopularBookDetailScreen(storyModel: book), () {});
      },
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(top: 36.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              image: getDecorationNetworkImage(context, slider.image ?? "",fit: BoxFit.cover),
            ),
            // decoration: BoxDecoration(
            //     color: color, borderRadius: BorderRadius.circular(12.r)),
            // color: (slider.color!.isNotEmpty && slider.color != null)?slider.color!.toColor():color, borderRadius: BorderRadius.circular(16.h)),

            // width: 236.h,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Expanded(child: Container()),

                getHorSpace(138.h),

                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(12.h),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: getCustomFont(
                                  book.name ?? "", 20.sp, regularWhite, 2,
                                  fontWeight: FontWeight.w700)
                              .marginSymmetric(horizontal: 10.h),
                        ),
                      ),

                      // getVerSpace(10.h),
                      // getCustomFont(auth.authorName ?? "", 14.sp, grey20, 1,
                      //     fontWeight: FontWeight.w400),
                      Container(
                        height: 24.h,
                        width: 24.h,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: regularWhite,
                        ),

                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_right_alt,
                            color: color, size: 20.h),

                        // child: Icon(Icons.arrow_right_alt,color: (slider.color!.isNotEmpty && slider.color != null)?slider.color!.toColor():color),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(top: 36.h, bottom: 80.h),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
            alignment: Alignment.topRight,
            child: getAssetImage("banner_view.png"),
          ),
          Container(
            height: 197.h,
            width: 122.h,
            margin: EdgeInsets.only(bottom: 16.h, left: 16.h),
            decoration: BoxDecoration(
                // color: grey,
                image: getDecorationNetworkImage(context, book.image ?? "",
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.r)),
          ),
        ],
      ),
    );
  }

  // Expanded(
  //   flex: 1,
  //   child: Container(
  //     // height: 223.h,
  //     width: double.infinity,
  //
  //     padding: EdgeInsets.all(10.h),
  //
  //     // margin: EdgeInsets.only(top: 66.h),
  //
  //   ).paddingOnly(top: 0.h),
  // ),

  // Container(
  //   // height: 200.h,
  //   margin: EdgeInsets.symmetric(
  //       horizontal:
  //       getDefaultHorSpace(
  //           context)),
  //   decoration: BoxDecoration(
  //       image:
  //       getDecorationNetworkImage(
  //           context,
  //           "",
  //           fit: BoxFit.cover),
  //       borderRadius:
  //       BorderRadius.all(
  //         Radius.circular(16.h),
  //       )),
  //
  //   child: Container(
  //     padding: EdgeInsets.only(
  //         bottom: 10.h),
  //     height: double.infinity,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       borderRadius:
  //       BorderRadius.circular(
  //           16.h),
  //       color:
  //       const Color(0x5e000000),
  //     ),
  //     alignment:
  //     Alignment.bottomCenter,
  //     child: getMaxLineFont(
  //         context,
  //         "",
  //         55,
  //         Colors.white,
  //         2,
  //         fontWeight:
  //         FontWeight.w700,
  //         txtHeight: 1.7.h,
  //         textAlign:
  //         TextAlign.center),
  //   ),
  // )

  // Container getCommonBannerWidget(
  //     Color color, StoryModel book, TopAuthors auth, BuildContext context) {
  //   return Container(
  //     height: double.infinity,
  //     // width: 236.h,
  //     child: Stack(
  //       children: [
  //         Container(
  //           // height: 223.h,
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //               color: color, borderRadius: BorderRadius.circular(16.h)),
  //           margin: EdgeInsets.only(top: 66.h),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               getCustomFont(book.name ?? "", 16.sp, regularBlack, 1,
  //                   fontWeight: FontWeight.w700),
  //               getVerSpace(3.h),
  //               getCustomFont(auth.authorName ?? "", 14.sp, grey, 1,
  //                   fontWeight: FontWeight.w400),
  //               getVerSpace(20.h),
  //             ],
  //           ),
  //         ).paddingOnly(top: 0.h),
  //         Container(
  //           // width: 158.h,
  //             margin: EdgeInsets.only(bottom: 70.h, left: 35.h, right: 35.h),
  //             // height: 224.h,
  //             decoration: BoxDecoration(
  //                 color: color,
  //                 borderRadius: BorderRadius.circular(16.h),
  //                 image: getDecorationNetworkImage(context, book.image ?? "",
  //                     fit: BoxFit.cover)))
  //       ],
  //     ),
  //   );
  // }

  Widget getCommonBannerShimmerWidget(BuildContext context) {
    print("call----shimer");
    return getShimmerWidget(
        context,
        Container(
          height: 170.h,
          margin: EdgeInsets.symmetric(horizontal: 20.h),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(16.h)),
        ));
  }

  // Container getCommonBannerShimmerWidget(Color color, BuildContext context) {
  //   return Container(
  //     height: double.infinity,
  //     // width: 236.h,
  //     child: Stack(
  //       children: [
  //         getShimmerWidget(
  //             context,
  //             Container(
  //               // height: 223.h,
  //               width: double.infinity,
  //               decoration: BoxDecoration(
  //                   color: color, borderRadius: BorderRadius.circular(16.h)),
  //               margin: EdgeInsets.only(top: 66.h),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   getCustomFont(" ", 16.sp, regularBlack, 1,
  //                       fontWeight: FontWeight.w700),
  //                   getVerSpace(3.h),
  //                   getCustomFont(" ", 14.sp, grey, 1,
  //                       fontWeight: FontWeight.w400),
  //                   getVerSpace(20.h),
  //                 ],
  //               ),
  //             ).paddingOnly(top: 0.h)),
  //         Shimmer.fromColors(
  //           baseColor: (Get.isDarkMode) ? Colors.white24 : Colors.grey.shade400,
  //           highlightColor:
  //               (Get.isDarkMode) ? Colors.white12 : Colors.grey.shade200,
  //           child: Container(
  //               // width: 158.h,
  //               margin: EdgeInsets.only(bottom: 70.h, left: 35.h, right: 35.h),
  //               // height: 224.h,
  //               decoration: BoxDecoration(
  //                 color: color,
  //                 borderRadius: BorderRadius.circular(16.h),
  //                 // image: getDecorationNetworkImage(
  //                 //     context, book.image ?? "",
  //                 //     fit: BoxFit.cover)
  //               )),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Container buildTopAppBarView(BuildContext context) {
    return Container(
      height: 76.h,
      color: context.theme.focusColor,
      child: GetBuilder<HomeMainScreenController>(
        init: HomeMainScreenController(),
        builder: (homeMainScreenController) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // GestureDetector(
            //     onTap: () {
            //       if (homeMainScreenController
            //           .scaffoldKey.currentState!.isDrawerOpen) {
            //         homeMainScreenController.scaffoldKey.currentState
            //             ?.openEndDrawer();
            //       } else {
            //         homeMainScreenController.scaffoldKey.currentState!
            //             .openDrawer();
            //       }
            //     },
            //     child: getSvgImage("menu_icon.svg")),
            getCustomFont(
                "Let’s Read Books", 24.sp, context.theme.primaryColor, 1,
                fontWeight: FontWeight.w700),
            GestureDetector(
              onTap: () {
                Constant.sendToNext(context, Routes.searchScreenRoute);
              },
              child: getSvgImage(
                Get.isDarkMode ? "search_normal.svg" : "searchIcon.svg",
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.h),
      ),
    );
  }
}

Widget buildCommonAuthorsWidget(BuildContext context, TopAuthors authors) {
  return SizedBox(
    height: 136.h,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 77.h,
          width: 77.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: getDecorationNetworkImage(context, authors.image ?? "",
                fit: BoxFit.cover),
            // DecorationImage(
            //     image: AssetImage(Constant
            //             .assetImagePath +
            //         authors
            //             .image!))
          ),
        ),
        getVerSpace(10.h),
        getCustomFont(authors.authorName!, 16.sp, context.theme.primaryColor, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(3.h),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(KeyTable.storyList)
              .where(KeyTable.authId, arrayContains: authors.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.data!.size > 0) {
              if (snapshot.connectionState == ConnectionState.active) {
                return getCustomFont(
                    "${snapshot.data!.size} Books", 14.sp, grey, 1,
                    fontWeight: FontWeight.w400);
              } else {
                return getCustomFont(
                    " ", 14.sp, grey, 1,
                    fontWeight: FontWeight.w400);
              }
            } else {
              return getCustomFont(
                  " ", 14.sp, grey, 1,
                  fontWeight: FontWeight.w400);
            }
          },
        )
      ],
    ),
  );
}
