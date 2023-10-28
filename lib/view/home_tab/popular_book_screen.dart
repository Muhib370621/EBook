import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/datafile/firebase_data/firebasedata.dart';
import 'package:ebook_app/main.dart';
import 'package:ebook_app/view/home_tab/populer_book_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../ads/AdsFile.dart';
import '../../controller/controller.dart';
import '../../models/book_list_model.dart';
import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class PopulerBookScreen extends StatefulWidget {
  const PopulerBookScreen({Key? key}) : super(key: key);

  @override
  State<PopulerBookScreen> createState() => _PopulerBookScreenState();
}

class _PopulerBookScreenState extends State<PopulerBookScreen> {
  PopulerBookScreenController populerBookScreenController =
      Get.put(PopulerBookScreenController());

  AdsFile adsFile = AdsFile();

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        adsFile.createAnchoredBanner(context);
      },
    );
  } // List<PopulerBook> populerBook = DataFile.getPopulerBookData();

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
            getCustumAppbar(
                rightPermission: false,
                leftIcon:
                    Get.isDarkMode ? "left_arrow_white.svg" : "back_arrow.svg",
                title: "Popular Books",
                leftFunction: () {
                  backClick();
                },
                givecolor: context.theme.focusColor,
                titlecolor: context.theme.primaryColor),
            getVerSpace(20.h),
            buildPopularBookList(context),
            ObxValue(
                (p0) => adsFile.isLoading.value
                    ? getBanner(context, adsFile)
                    : Container(),
                adsFile.isLoading),
          ],
        ))),
      ),
    );
  }

  Expanded buildPopularBookList(BuildContext context) {
    return Expanded(
        child: Container(
      color: context.theme.focusColor,
      child: Obx(() {
        if (networkManager.isNetwork.value) {
          return StreamBuilder<QuerySnapshot>(
            stream: FireBaseData.getPopularList(),
            builder: (context, snapshot) {
              return getWidgetFromStatus(
                  context: context,
                  data: snapshot,
                  progressWidget: getPopularBookProgressWidget(),
                  child: checkEmptyData(
                      context: context,
                      querySnapshot: snapshot,
                      child: Builder(builder: (context) {
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
                            StoryModel storyBook =
                                StoryModel.fromFirestore(list[index]);

                            // PopulerBook populer = populerBook[index];

                            return StreamBuilder<QuerySnapshot>(
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
                                  //     TopAuthors.fromFirestore(snapshot1.data!);

                                  return getBook(context, storyBook, auth, (){
                                    populerBookScreenController
                                        .onSetIndex(index);
                                    Constant.sendToNextWithResult(
                                        context,
                                        PopularBookDetailScreen(
                                            storyModel: storyBook),
                                            () {});
                                  });

                                } else {
                                  return Container();
                                }
                              },
                            );
                          },
                        );
                      })));
            },
          );
        } else {
          return getPopularBookProgressWidget();
        }
      }),
    ).paddingOnly(bottom: 20.h));
  }
}

Widget getPopularBookProgressWidget() {
  return GridView.builder(
    physics: BouncingScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 312.h,
        mainAxisSpacing: 20.h,
        crossAxisSpacing: 20.h),
    itemCount: 6,
    itemBuilder: (BuildContext context, int index) {
      // return getCommonBookShimmerWidget(context);

      return getShimmerWidget(
          context,
          Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16.h),
                border: Border.all(color: grey20)),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    // height: 230.h,
                    width: 160.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.h),
                      // image: getDecorationNetworkImage(
                      //     context,
                      //     storyBook.image ?? "",
                      //     fit: BoxFit.fill)

                      // DecorationImage(
                      //     image: AssetImage(
                      //         Constant.assetImagePath +
                      //             populer.image!),
                      //     fit: BoxFit.fill)
                    ),
                  ),
                ),
                getVerSpace(12.h),
                getCustomFont("", 16.sp, context.theme.primaryColor, 1,
                    fontWeight: FontWeight.w700),
                getVerSpace(1.h),
                getCustomFont("", 14.sp, grey, 1, fontWeight: FontWeight.w400),
              ],
            ).paddingSymmetric(vertical: 12.h),
          ));
    },
  );
}
