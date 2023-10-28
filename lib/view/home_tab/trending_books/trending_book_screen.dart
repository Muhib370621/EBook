import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/main.dart';
import 'package:ebook_app/models/book_list_model.dart';
import 'package:ebook_app/view/home_tab/popular_book_screen.dart';
import 'package:ebook_app/view/home_tab/populer_book_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../ads/AdsFile.dart';
import '../../../datafile/firebase_data/firebasedata.dart';
import '../../../utils/constant.dart';
import '../../../utils/constantWidget.dart';

class TrenDingBookScreen extends StatefulWidget {
  const TrenDingBookScreen({Key? key}) : super(key: key);

  @override
  State<TrenDingBookScreen> createState() => _TrenDingBookScreenState();
}

class _TrenDingBookScreenState extends State<TrenDingBookScreen> {
  // TrenDingBookScreenController trenDingBookScreenController =
  //     Get.put(TrenDingBookScreenController());

  // List<TrenDingBook> trendingBook = DataFile.getTrenDingBookData();

  void backClick() {
    Constant.backToFinish();
  }


  AdsFile adsFile = AdsFile();


  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero,() {
      adsFile.createAnchoredBanner(context);
    },);
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
            child: getDefaultWidget(
                Column(
              children: [
                getCustumAppbar(
                    rightPermission: false,
                    leftIcon:
                    Get.isDarkMode ? "left_arrow_white.svg" : "back_arrow.svg",
                    title: "Featured Books",
                    leftFunction: () {
                      backClick();
                    },
                    givecolor: context.theme.focusColor,
                    titlecolor: context.theme.primaryColor),
                getVerSpace(20.h),
                buildFeaturedBookList(context),
                ObxValue((p0) => adsFile.isLoading.value?getBanner(context, adsFile):Container(), adsFile.isLoading),
              ],
            ))),
      ),
    );
  }

  Expanded buildFeaturedBookList(BuildContext context) {
    return Expanded(
                  child: Container(
                    color: context.theme.focusColor,
                    child: Obx((){
                      if(networkManager.isNetwork.value){
                        return StreamBuilder<QuerySnapshot>(
                          stream: FireBaseData.getFeaturedList(),
                          builder: (context, snapshot) {
                            return getWidgetFromStatus(
                                context: context,
                                data: snapshot,
                                progressWidget: getPopularBookProgressWidget(),
                                child: checkEmptyData(
                                    context: context,
                                    querySnapshot: snapshot,
                                    child: Builder(
                                      builder: (context) {
                                        List<DocumentSnapshot> list = snapshot.data!.docs;
                                        return GridView.builder(
                                          physics: BouncingScrollPhysics(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.h, vertical: 20.h),
                                          gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisExtent: 312.h,
                                              mainAxisSpacing: 20.h,
                                              crossAxisSpacing: 20.h),
                                          itemCount: list.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            // TrenDingBook trending = trendingBook[index];
                                            StoryModel storyBook =
                                            StoryModel.fromFirestore(list[index]);
                                            return StreamBuilder<QuerySnapshot>(
                                              stream: FireBaseData.getAuthorById(id: storyBook.authId ?? []),

                                              // FirebaseFirestore.instance
                                              //     .collection(KeyTable.authorList)
                                              //     .doc(storyBook.authId)
                                              //     .snapshots(),
                                              builder: (context, snapshot1) {
                                                print("snapshort1-----${snapshot1.data}");
                                                if (snapshot1.data != null) {
                                                  List<DocumentSnapshot> list = snapshot1.data!.docs;

                                                  String auth = FireBaseData.getAuthorName(author: storyBook.authId!, list: list);
                                                  // TopAuthors auth =
                                                  // TopAuthors.fromFirestore(
                                                  //     snapshot1.data!);

                                                  return getBook(context,storyBook,auth,(){
                                                    Constant.sendToNextWithResult(
                                                        context, PopularBookDetailScreen(storyModel: storyBook),(){});
                                                  });

                                                  //   getCommonBookWidget(
                                                  //     context,
                                                  //     storyBook.image ?? "",
                                                  //     storyBook.name ?? "",
                                                  //     auth.authorName ?? "", () {
                                                  //   // trendingBookScreenController
                                                  //   //     .onSetIndex(index);
                                                  //   Constant.sendToNextWithResult(
                                                  //       context,
                                                  //       PopularBookDetailScreen(
                                                  //           storyModel: storyBook),
                                                  //       () {});
                                                  // }).paddingSymmetric(horizontal: 10.h);

                                                  //   GestureDetector(
                                                  //   onTap: () {
                                                  //     trenDingBookScreenController
                                                  //         .onSetIndex(index);
                                                  //     Constant.sendToNext(
                                                  //         context, Routes
                                                  //         .trendingBookDetailScreenRoute);
                                                  //   },
                                                  //   child: Container(
                                                  //     decoration: BoxDecoration(
                                                  //         borderRadius: BorderRadius
                                                  //             .circular(16.h),
                                                  //         border: Border.all(
                                                  //             color: grey20)),
                                                  //     child: Column(
                                                  //       children: [
                                                  //         Container(
                                                  //           height: 230.h,
                                                  //           width: 160.h,
                                                  //           decoration: BoxDecoration(
                                                  //               borderRadius: BorderRadius
                                                  //                   .circular(16.h),
                                                  //               image: getDecorationNetworkImage(context, storyBook.image ?? "",fit: BoxFit.fill)
                                                  //
                                                  //             // DecorationImage(
                                                  //             //     image: AssetImage(
                                                  //             //         Constant
                                                  //             //             .assetImagePath +
                                                  //             //             storyBook
                                                  //             //                 .image!),
                                                  //             //     fit: BoxFit.fill)
                                                  //           ),
                                                  //         ),
                                                  //         getVerSpace(12.h),
                                                  //         getCustomFont(
                                                  //             storyBook.name ?? "", 16.sp,
                                                  //             regularBlack, 1,
                                                  //             fontWeight: FontWeight.w700),
                                                  //         getVerSpace(1.h),
                                                  //         getCustomFont(
                                                  //             trending.authorName!, 14.sp,
                                                  //             grey, 1,
                                                  //             fontWeight: FontWeight.w400),
                                                  //       ],
                                                  //     ).paddingSymmetric(vertical: 12.h),
                                                  //   ),
                                                  // );
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            );
                                          },
                                        );
                                      },
                                    )));
                          },
                        );
                      }else{
                        return getPopularBookProgressWidget();
                      }
                    }),
                  ).paddingOnly(bottom: 20.h));
  }
}
