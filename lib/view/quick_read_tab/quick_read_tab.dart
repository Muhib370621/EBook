import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../datafile/firebase_data/firebasedata.dart';
import '../../models/book_list_model.dart';
import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../home_tab/populer_book_detail.dart';

class QuickReadTabScreen extends StatefulWidget {
  const QuickReadTabScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuickReadTabScreen();
  }
}

class _QuickReadTabScreen extends State<QuickReadTabScreen> {
  RecentController controller =
  Get.put(RecentController());

  void backClick() {
    Constant.closeApp();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      controller.getRecentDataList();
      // controller.like.value = controller.favouriteList.contains(widget.storyModel.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () async {
        HomeMainScreenController mainScreenController = Get.find();

          mainScreenController.onChange(2.obs);
        return false;
        },
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: Column(
          children: [
            getCustumAppbar(
                rightPermission: false,
                leftPermission: false,
                // leftIcon:
                // Get.isDarkMode ? "left_arrow_white.svg" : "back_arrow.svg",
                title: "Recent",
                // leftFunction: () {
                //
                //   HomeMainScreenController mainScreenController = Get.find();
                //
                //   mainScreenController.onChange(2.obs);
                //
                //   // backClick();
                // },
                givecolor: context.theme.focusColor,
                titlecolor: context.theme.primaryColor),
            getVerSpace(10.h),
            buildfavouriteList(context)
          ],
        ),
      ),
    );
  }

  Expanded buildfavouriteList(BuildContext context) {
    return Expanded(
        child: Container(
          color: context.theme.focusColor,
          child: Obx(() {
            if(networkManager.isNetwork.value){
              return StreamBuilder<QuerySnapshot>(
                stream: FireBaseData.getBookList(),
                builder: (context, snapshot) {
                  return getWidgetFromStatus(
                      context: context,
                      data: snapshot,
                      progressWidget: getRecentProgressWidget(),
                      child: checkEmptyData(
                          context: context,
                          querySnapshot: snapshot,
                          child: Builder(builder: (context) {
                            List<DocumentSnapshot> list = snapshot.data!.docs;

                            return GetBuilder<QuickReadController>(
                              init: QuickReadController(),
                              builder: (favController) {
                                favController.checkDataExist(
                                    list, controller.recentList);

                                if (favController.filteredRecentList.isNotEmpty) {
                                  return Obx(() => AnimationLimiter(
                                    child: GridView.builder(
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.h, vertical: 20.h),
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 312.h,
                                          mainAxisSpacing: 20.h,
                                          crossAxisSpacing: 20.h),
                                      itemCount: favController.filteredRecentList.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        StoryModel storyBook =
                                        StoryModel.fromFirestore(
                                            favController.filteredRecentList[index]);
                                        // PopulerBook populer = populerBook[index];

                                        return AnimationConfiguration.staggeredGrid(
                                          columnCount: 2,
                                          position: index,
                                          duration: Duration(milliseconds: 800),
                                          child: ScaleAnimation(
                                            // horizontalOffset: MediaQuery.of(context).size.width / 2,
                                            scale: 0.9,
                                            child: FadeInAnimation(
                                              child: StreamBuilder<QuerySnapshot>(
                                                stream: FireBaseData.getAuthorById(
                                                    id: storyBook.authId ?? []),

                                                // FirebaseFirestore.instance
                                                //     .collection(KeyTable.authorList).doc(storyBook.authId)
                                                //     .snapshots(),

                                                builder: (context, snapshot1) {
                                                  if (snapshot1.data != null) {


                                                    List<DocumentSnapshot> list = snapshot1.data!.docs;


                                                    String auth = FireBaseData.getAuthorName(author: storyBook.authId!, list: list);
                                                    // TopAuthors auth =
                                                    // TopAuthors.fromFirestore(
                                                    //     snapshot1.data!);

                                                    return GestureDetector(
                                                      onTap: () {
                                                        Constant.sendToNextWithResult(
                                                            context,
                                                            PopularBookDetailScreen(
                                                                storyModel: storyBook), () {
                                                          Future.delayed(Duration.zero,
                                                                  () async {
                                                            // setState(() {
                                                            //
                                                            // });
                                                                favController
                                                                    .filteredRecentList.value = [];
                                                                favController.checkDataExist(
                                                                    list,
                                                                    controller.recentList);
                                                                print(
                                                                    "filteredFavListLen-----------${favController.filteredRecentList.length}");
                                                                // controller.like.value = controller.favouriteList.contains(widget.storyModel.id.toString());
                                                              });
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(16.h),
                                                            border:
                                                            Border.all(color: grey20)),
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                // height: 230.h,
                                                                width: 160.h,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(16.h),
                                                                    image:
                                                                    getDecorationNetworkImage(
                                                                        context,
                                                                        storyBook
                                                                            .image ??
                                                                            "",
                                                                        fit:
                                                                        BoxFit.fill)

                                                                  // DecorationImage(
                                                                  //     image: AssetImage(
                                                                  //         Constant.assetImagePath +
                                                                  //             populer.image!),
                                                                  //     fit: BoxFit.fill)

                                                                ),
                                                              ),
                                                            ),
                                                            getVerSpace(12.h),
                                                            getCustomFont(
                                                                storyBook.name ?? "",
                                                                16.sp,
                                                                context.theme.primaryColor,
                                                                1,
                                                                fontWeight:
                                                                FontWeight.w700).marginSymmetric(horizontal: 10.h),
                                                            getVerSpace(1.h),
                                                            getCustomFont(
                                                                auth,
                                                                14.sp,
                                                                grey,
                                                                1,
                                                                fontWeight:
                                                                FontWeight.w400).marginSymmetric(horizontal: 10.h),
                                                          ],
                                                        ).paddingSymmetric(vertical: 12.h),
                                                      ),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ));
                                } else {
                                  return buildNoFavDataView();
                                }
                              },
                            );
                          })));
                },
              );
            }else{
              return Container();
            }
          }),
        ).paddingOnly(bottom: 20.h));
  }

  GridView getRecentProgressWidget() {
    return GridView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 312.h,
                      mainAxisSpacing: 20.h,
                      crossAxisSpacing: 20.h),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return getCommonBookShimmerWidget(context);
                  },
                );
  }

  Center buildNoFavDataView() {
    return Center(
        child: getCustomFont('No Recent Book!', 25.sp,
            Get.isDarkMode ? regularWhite : regularBlack, 1));
  }
}
