import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/models/drawer_categoy_class_data_model.dart';
import 'package:ebook_app/utils/constant.dart';
import 'package:ebook_app/utils/constantWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../ads/AdsFile.dart';
import '../../controller/controller.dart';
import '../../datafile/firebase_data/firebasedata.dart';
import '../../main.dart';
import '../../models/book_list_model.dart';
import '../../utils/color_category.dart';
import '../home_tab/populer_book_detail.dart';
import '../slider_option_class/dashboard_screen.dart';

// ignore: must_be_immutable
class CategoryViewScreen extends StatefulWidget {
  CategoryModel model;
  CategoryViewScreen({Key? key,required this.model}) : super(key: key);

  @override
  State<CategoryViewScreen> createState() => _CategoryViewScreenState();
}

class _CategoryViewScreenState extends State<CategoryViewScreen> {

  CategoryTabController controller = Get.put(CategoryTabController());


  AdsFile adsFile = AdsFile();


  @override
  void initState() {
    super.initState();

    controller.getAllStoryList(widget.model.id ?? "");

    Future.delayed(
      Duration.zero,
          () {
        adsFile.createAnchoredBanner(context);
      },
    );

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
          getCustumAppbar(rightPermission: false,
              leftIcon: Get.isDarkMode
                  ? "left_arrow_white.svg"
                  : "back_arrow.svg",
              title: widget.model.name,
              leftFunction: () {
                backClick();
              },
              givecolor: context.theme.focusColor,
              titlecolor: context.theme.primaryColor),
          getVerSpace(20.h),
          Expanded(child: Expanded(
              child: Container(
                color: context.theme.focusColor,
                child: Obx(
                      () {


                    if(networkManager.isNetwork.value){

                      if(!controller.isStoryLoading.value){
                        return Obx(() {

                          if (controller.storyList.isNotEmpty) {
                            return AnimationLimiter(
                              child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 312.h,
                                    mainAxisSpacing: 20.h,
                                    crossAxisSpacing: 20.h),
                                itemCount: controller.storyList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  StoryModel storyBook = controller.storyList[index];

                                  return AnimationConfiguration.staggeredGrid(
                                    columnCount: 2,
                                    position: index,
                                    duration: const Duration(milliseconds: 700),
                                    child: ScaleAnimation(
                                      scale: 0.9,
                                      child: FadeInAnimation(

                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: FireBaseData.getAuthorById(id: storyBook.authId ?? []),
                                          builder: (context, snapshot1) {
                                            if (snapshot1.data != null) {

                                              List<DocumentSnapshot> snap = snapshot1.data!.docs;

                                              String auth = FireBaseData.getAuthorName(author: storyBook.authId!, list: snap);

                                              // TopAuthors auth =
                                              // TopAuthors.fromFirestore(snapshot1.data!);

                                              return GestureDetector(
                                                onTap: () {
                                                  Constant.sendToNextWithResult(
                                                      context,
                                                      PopularBookDetailScreen(storyModel: storyBook),
                                                          () {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
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
                                                              image: getDecorationNetworkImage(
                                                                  context, storyBook.image ?? "",
                                                                  fit: BoxFit.fill)),
                                                        ),
                                                      ),
                                                      getVerSpace(12.h),
                                                      getCustomFont(storyBook.name ?? "", 16.sp,
                                                          context.theme.primaryColor, 1,
                                                          fontWeight: FontWeight.w700).marginSymmetric(horizontal: 10.h),
                                                      getVerSpace(1.h),
                                                      getCustomFont(
                                                          auth, 14.sp, grey, 1,
                                                          fontWeight: FontWeight.w400).marginSymmetric(horizontal: 10.h),
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
                            );
                          } else {
                            return noDataFound(context);
                          }
                        });
                      }else{
                        return getProgressWidget(context);
                      }

                    }else{
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

                          // StoryModel storyBook = controller.storyList[index];


                          return getCommonBookShimmerWidget(context);

                          // return Container(
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(16.h),
                          //       border: Border.all(color: grey20)),
                          //   child: Column(
                          //     children: [
                          //       Expanded(
                          //         flex: 1,
                          //         child: Container(
                          //           // height: 230.h,
                          //           width: 160.h,
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(16.h),
                          //               image: getDecorationNetworkImage(
                          //                   context, "",
                          //                   fit: BoxFit.fill)),
                          //         ),
                          //       ),
                          //       getVerSpace(12.h),
                          //       getCustomFont( "", 16.sp,
                          //           context.theme.primaryColor, 1,
                          //           fontWeight: FontWeight.w700),
                          //       getVerSpace(1.h),
                          //       getCustomFont(
                          //           "", 14.sp, grey, 1,
                          //           fontWeight: FontWeight.w400),
                          //     ],
                          //   ).paddingSymmetric(vertical: 12.h),
                          // );
                        },
                      );
                    }

                  },
                ),
              ))),
          ObxValue(
              (p0) => adsFile.isLoading.value
          ? getBanner(context, adsFile)
              : Container(),
        adsFile.isLoading),

        ],
      ))),
    ), );
  }


}
