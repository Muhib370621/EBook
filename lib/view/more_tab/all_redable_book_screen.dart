import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../datafile/firebase_data/firebasedata.dart';
import '../../models/book_list_model.dart';
import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../home_tab/populer_book_detail.dart';

class AllReadBookScreen extends StatefulWidget {
  const AllReadBookScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AllReadBookScreen();
  }
}

class _AllReadBookScreen extends State<AllReadBookScreen> {
  PopulerBookScreenController controller =
  Get.put(PopulerBookScreenController());

  void backClick() {
    Constant.backToFinish();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      controller.getBookMarkList();
      // controller.like.value = controller.favouriteList.contains(widget.storyModel.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            getCustumAppbar(
                rightPermission: false,
                leftIcon:
                Get.isDarkMode ? "left_arrow_white.svg" : "back_arrow.svg",
                title: "Book",
                leftFunction: () {

                  backClick();
                },
                givecolor: context.theme.focusColor,
                titlecolor: context.theme.primaryColor),
            getVerSpace(26.h),
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
                      progressWidget: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 312.h,
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 20.h),
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
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
                                          // image: getDecorationNetworkImage(context, storyBook.image ?? "",fit: BoxFit.fill)

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
                                        "", 16.sp, context.theme.primaryColor, 1,
                                        fontWeight: FontWeight.w700),
                                    getVerSpace(1.h),
                                    getCustomFont("", 14.sp, grey, 1,
                                        fontWeight: FontWeight.w400),
                                  ],
                                ).paddingSymmetric(vertical: 12.h),
                              ));
                        },
                      ),
                      child: checkEmptyData(
                          context: context,
                          querySnapshot: snapshot,
                          child: Builder(builder: (context) {
                            List<DocumentSnapshot> list = snapshot.data!.docs;

                            return GetBuilder<AllReadBookController>(
                              init: AllReadBookController(),
                              builder: (favController) {
                                favController.checkDataExist(
                                    list, controller.bookMarkList);

                                if (favController.filteredBookMarkList.isNotEmpty) {
                                  return Obx(() => GridView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.h, vertical: 20.h),
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 312.h,
                                        mainAxisSpacing: 20.h,
                                        crossAxisSpacing: 20.h),
                                    itemCount: favController.filteredBookMarkList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      StoryModel storyBook =
                                      StoryModel.fromFirestore(
                                          favController.filteredBookMarkList[index]);
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
                                            // TopAuthors.fromFirestore(
                                            //     snapshot1.data!);

                                            return GestureDetector(
                                              onTap: () {
                                                Constant.sendToNextWithResult(
                                                    context,
                                                    PopularBookDetailScreen(
                                                        storyModel: storyBook), () {

                                                  // setState(() {
                                                  //
                                                  // });
                                                  Future.delayed(Duration.zero,
                                                          () async {
                                                        favController
                                                            .filteredBookMarkList.value = [];
                                                        favController.checkDataExist(
                                                            list,
                                                            controller.favouriteList);
                                                        print(
                                                            "filteredFavListLen-----------${favController.filteredBookMarkList.length}");
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
                                      );
                                    },
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

  Center buildNoFavDataView() {
    return Center(
        child: getCustomFont('No Read Book!', 25.sp,
            Get.isDarkMode ? regularWhite : regularBlack, 1));
  }
}
