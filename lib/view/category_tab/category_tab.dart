import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/datafile/firebase_data/key_table.dart';
import 'package:ebook_app/main.dart';
import 'package:ebook_app/models/book_list_model.dart';
import 'package:ebook_app/models/drawer_categoy_class_data_model.dart';
import 'package:ebook_app/view/category_tab/category_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../datafile/firebase_data/firebasedata.dart';
import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../home_tab/populer_book_detail.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({Key? key}) : super(key: key);

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  void backClick() {
    Constant.closeApp();
  }

  @override
  void initState() {
    super.initState();
    controller.getAllCategoryList();
  }

  CategoryTabController controller = Get.put(CategoryTabController());

  HomeMainScreenController mainScreenController = Get.find();

  List<CategoryModel> catList = [];

  RxString selectedId = "0".obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // backClick();
        HomeMainScreenController mainScreenController = Get.find();

        mainScreenController.onChange(2.obs);
        return false;
        // return false;
      },
      child: Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          body: SafeArea(
              child: Column(
            children: [
              getCustumAppbar(
                leftPermission: false,
                  rightPermission: false,
                  // leftIcon: Get.isDarkMode
                  //     ? "left_arrow_white.svg"
                  //     : "back_arrow.svg",
                  title: "Categories",
                  // leftFunction: () {
                  //   mainScreenController.onChange(2.obs);
                  //   // backClick();
                  // },
                  givecolor: context.theme.focusColor,
                  titlecolor: context.theme.primaryColor),
              getVerSpace(10.h),
              buildCategoryList(context),
              // buildCategoryTabView(context),
              // buildStoryList(context)
            ],
          )

              //     Column(
              //   children: [
              //     getCustumAppbar(
              //         rightPermission: false,
              //         leftIcon:
              //             Get.isDarkMode ? "left_arrow_white.svg" : "back_arrow.svg",
              //         title: "Categories",
              //         leftFunction: () {
              //           backClick();
              //         },
              //         givecolor: context.theme.focusColor,
              //         titlecolor: context.theme.primaryColor),
              //     getVerSpace(26.h),
              //     Container(
              //       height: 60.h,
              //       color: context.theme.focusColor,
              //       child: ObxValue<RxBool>((p0) {
              //         if (!controller.isDataLoading.value && controller.categoryList.isNotEmpty) {
              //
              //           catList = controller.categoryList;
              //           if (selectedId.value == "0") {
              //             selectedId(catList[0].id);
              //
              //             print("categoryId---${catList[0].id.toString()}");
              //
              //             controller.getAllStoryList(catList[0].id ?? "");
              //           }
              //
              //           return ListView.builder(
              //             shrinkWrap: true,
              //             physics: BouncingScrollPhysics(),
              //             padding: EdgeInsets.symmetric(horizontal: 20.h),
              //             scrollDirection: Axis.horizontal,
              //             itemCount: catList.length,
              //             itemBuilder: (context, index) {
              //               CategoryModel category = (catList[index]);
              //
              //               return GestureDetector(
              //                   onTap: () {
              //
              //                     selectedId(category.id ?? "");
              //
              //                     controller.getAllStoryList(category.id ?? "");
              //
              //                     controller.setBookTypeIndex(
              //                         index);
              //                   },
              //                   child: Obx(() => Container(
              //                       margin: EdgeInsets.symmetric(vertical: 10.h),
              //                       decoration: selectedId.value == category.id
              //                           ? BoxDecoration(
              //                           borderRadius: BorderRadius.circular(16.h),
              //                           color: maximumOrange)
              //                           : BoxDecoration(
              //                           color: context.theme.focusColor),
              //                       child: selectedId.value == category.id
              //                           ? getCustomFont(category.name.toString(),
              //                           16.sp, regularWhite, 1,
              //                           fontWeight: FontWeight.w700)
              //                           .paddingSymmetric(
              //                           horizontal: 16.h, vertical: 8.h)
              //                           : getCustomFont(category.name.toString(),
              //                           16.sp, grey, 1,
              //                           fontWeight: FontWeight.w400)
              //                           .paddingSymmetric(
              //                           horizontal: 16.h, vertical: 8.h))));
              //             },
              //           );
              //         } else {
              //           return getProgressWidget(context);
              //         }
              //       }, controller.isDataLoading),
              //     ),
              //     Expanded(
              //         child: Container(
              //       color: context.theme.focusColor,
              //       child: ObxValue<RxBool>((p0) {
              //         print("cat----$selectedId");
              //
              //         if (!p0.value && controller.storyList.isNotEmpty) {
              //           return GridView.builder(
              //             physics: BouncingScrollPhysics(),
              //             padding: EdgeInsets.symmetric(
              //                 horizontal: 20.h, vertical: 20.h),
              //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //                 crossAxisCount: 2,
              //                 mainAxisExtent: 312.h,
              //                 mainAxisSpacing: 20.h,
              //                 crossAxisSpacing: 20.h),
              //             itemCount: controller.storyList.length,
              //             itemBuilder: (BuildContext context, int index) {
              //
              //               StoryModel storyBook =
              //               controller.storyList[index];
              //
              //               return StreamBuilder<DocumentSnapshot>(
              //                 stream: FireBaseData.getAuthorById(id: storyBook.authId ?? ""),
              //                 builder: (context, snapshot1) {
              //
              //                   if(snapshot1.data != null){
              //
              //                     TopAuthors auth = TopAuthors.fromFirestore(snapshot1.data!);
              //
              //
              //                     return GestureDetector(
              //                       onTap: () {
              //                         Constant.sendToNextWithResult(
              //                             context, PopularBookDetailScreen(storyModel: storyBook),(value){});
              //                       },
              //                       child: Container(
              //
              //                         decoration: BoxDecoration(
              //                             borderRadius: BorderRadius.circular(16.h),
              //                             border: Border.all(color: grey20)),
              //                         child: Column(
              //                           children: [
              //                             Container(
              //                               height: 230.h,
              //                               width: 160.h,
              //                               decoration: BoxDecoration(
              //                                   borderRadius:
              //                                   BorderRadius.circular(16.h),
              //                                   image: getDecorationNetworkImage(context, storyBook.image ?? "",fit: BoxFit.fill)
              //                               ),
              //                             ),
              //                             getVerSpace(12.h),
              //                             getCustomFont(storyBook.name ?? "", 16.sp,
              //                                 context.theme.primaryColor, 1,
              //                                 fontWeight: FontWeight.w700),
              //                             getVerSpace(1.h),
              //                             getCustomFont(
              //                                 auth.authorName ?? "", 14.sp, grey, 1,
              //                                 fontWeight: FontWeight.w400),
              //                           ],
              //                         ).paddingSymmetric(vertical: 12.h),
              //                       ),
              //                     );
              //                   }else{
              //                     return Container();
              //                   }
              //                 },);
              //             },
              //           );
              //         }else{
              //           return noDataFound(context);
              //         }
              //       }, controller.isDataLoading),
              //     ))
              //   ],
              // )

              //         GetBuilder<CategoryTabController>(
              //   init: CategoryTabController(),
              //   builder: (controller) {
              //     return Column(
              //       children: [
              //         getCustumAppbar(
              //             rightPermission: false,
              //             leftIcon: Get.isDarkMode
              //                 ? "left_arrow_white.svg"
              //                 : "back_arrow.svg",
              //             title: "Categories",
              //             leftFunction: () {
              //               backClick();
              //             },
              //             givecolor: context.theme.focusColor,
              //             titlecolor: context.theme.primaryColor),
              //         getVerSpace(26.h),
              //         buildTabView(controller),
              //         getVerSpace(20.h),
              //         Expanded(
              //             child: Container(
              //           color: context.theme.focusColor,
              //           child: StreamBuilder<QuerySnapshot>(
              //             stream: FirebaseFirestore.instance
              //                 .collection(KeyTable.storyList)
              //                 .where(KeyTable.refId, isEqualTo: selectedId.value)
              //                 .snapshots(),
              //             builder: (context, snapshot) {
              //               return getWidgetFromStatus(
              //                   context: context,
              //                   data: snapshot,
              //                   child: checkEmptyData(
              //                       context: context,
              //                       querySnapshot: snapshot,
              //                       child: Builder(builder: (context) {
              //                         List<DocumentSnapshot> list =
              //                             snapshot.data!.docs;
              //                         return GridView.builder(
              //                           physics: BouncingScrollPhysics(),
              //                           padding: EdgeInsets.symmetric(
              //                               horizontal: 20.h, vertical: 20.h),
              //                           gridDelegate:
              //                               SliverGridDelegateWithFixedCrossAxisCount(
              //                                   crossAxisCount: 2,
              //                                   mainAxisExtent: 312.h,
              //                                   mainAxisSpacing: 20.h,
              //                                   crossAxisSpacing: 20.h),
              //                           itemCount: list.length,
              //                           itemBuilder:
              //                               (BuildContext context, int index) {
              //                             StoryModel storyBook =
              //                                 StoryModel.fromFirestore(list[index]);
              //
              //                             return StreamBuilder<DocumentSnapshot>(
              //                               stream: FireBaseData.getAuthorById(
              //                                   id: storyBook.authId ?? ""),
              //                               builder: (context, snapshot1) {
              //                                 if (snapshot1.data != null) {
              //                                   TopAuthors auth =
              //                                       TopAuthors.fromFirestore(
              //                                           snapshot1.data!);
              //
              //                                   return GestureDetector(
              //                                     onTap: () {
              //                                       Constant.sendToNextWithResult(
              //                                           context,
              //                                           PopularBookDetailScreen(
              //                                               storyModel: storyBook),
              //                                           (value) {});
              //                                     },
              //                                     child: Container(
              //                                       decoration: BoxDecoration(
              //                                           borderRadius:
              //                                               BorderRadius.circular(
              //                                                   16.h),
              //                                           border: Border.all(
              //                                               color: grey20)),
              //                                       child: Column(
              //                                         children: [
              //                                           Container(
              //                                             height: 230.h,
              //                                             width: 160.h,
              //                                             decoration: BoxDecoration(
              //                                                 borderRadius:
              //                                                     BorderRadius
              //                                                         .circular(16.h),
              //                                                 image: getDecorationNetworkImage(
              //                                                     context,
              //                                                     storyBook.image ??
              //                                                         "",
              //                                                     fit: BoxFit.fill)),
              //                                           ),
              //                                           getVerSpace(12.h),
              //                                           getCustomFont(
              //                                               storyBook.name ?? "",
              //                                               16.sp,
              //                                               context
              //                                                   .theme.primaryColor,
              //                                               1,
              //                                               fontWeight:
              //                                                   FontWeight.w700),
              //                                           getVerSpace(1.h),
              //                                           getCustomFont(
              //                                               auth.authorName ?? "",
              //                                               14.sp,
              //                                               grey,
              //                                               1,
              //                                               fontWeight:
              //                                                   FontWeight.w400),
              //                                         ],
              //                                       ).paddingSymmetric(
              //                                           vertical: 12.h),
              //                                     ),
              //                                   );
              //                                 } else {
              //                                   return Container();
              //                                 }
              //                               },
              //                             );
              //                           },
              //                         );
              //                       })));
              //             },
              //           ),
              //         ).paddingOnly(bottom: 20.h))
              //       ],
              //     );
              //   },
              )),
    );
  }

  Expanded buildCategoryList(BuildContext context) {
    return Expanded(child: Container(
              color: context.theme.focusColor,
              child: Obx(() {
                if (!controller.isDataLoading.value &&
                    controller.categoryList.isNotEmpty) {
                  if(networkManager.isNetwork.value){
                    return AnimationLimiter(
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.h, vertical: 20.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 158.h,
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 20.h),
                        itemCount: controller.categoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          CategoryModel category =
                          controller.categoryList[index];

                          return AnimationConfiguration.staggeredGrid(
                            columnCount: 3,
                            position: index,
                            duration: const Duration(milliseconds: 700),
                            child: ScaleAnimation(
                              scale: 0.9,
                              child: FadeInAnimation(
                                  child: GestureDetector(
                                    onTap: () {
                                      Constant.sendToNextWithResult(
                                          context,
                                          CategoryViewScreen(
                                              model: category),
                                              () {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10.h),
                                      decoration: BoxDecoration(
                                          color: Get.isDarkMode?Colors.transparent:grey20,
                                          borderRadius: BorderRadius.circular(16.h),
                                          border: Border.all(color: grey20)),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              // height: 230.h,
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(16.r),
                                                  image: getDecorationNetworkImage(
                                                      context,
                                                      category.image ?? "",
                                                      fit: BoxFit.fill)),
                                            ),
                                          ),
                                          getVerSpace(12.h),
                                          getCustomFont(category.name ?? "", 16.sp,
                                              context.theme.primaryColor, 1,
                                              fontWeight: FontWeight.w700,textAlign: TextAlign.center),
                                          getVerSpace(2.h),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          );
                        },
                      ),
                    );
                  }else{
                    return AnimationLimiter(
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.h, vertical: 20.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 158.h,
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 20.h),
                        itemCount: controller.categoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: 3,
                            position: index,
                            duration: const Duration(milliseconds: 700),
                            child: ScaleAnimation(
                              scale: 0.9,
                              child: FadeInAnimation(
                                  child: GestureDetector(
                                    onTap: () {
                                      // Constant.sendToNextWithResult(
                                      //     context,
                                      //     CategoryViewScreen(
                                      //         model: category),
                                      //         () {});
                                    },
                                    child: getShimmerWidget(context, Container(
                                      padding: EdgeInsets.all(10.h),
                                      decoration: BoxDecoration(
                                          color: Get.isDarkMode?Colors.transparent:grey20,
                                          borderRadius: BorderRadius.circular(16.h),
                                          border: Border.all(color: grey20)),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              // height: 230.h,
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(16.r),
                                                // image: getDecorationNetworkImage(
                                                //     context,
                                                //     category.image ?? "",
                                                //     fit: BoxFit.fill)
                                              ),
                                            ),
                                          ),
                                          getVerSpace(12.h),
                                          getCustomFont("", 16.sp,
                                              context.theme.primaryColor, 1,
                                              fontWeight: FontWeight.w700,textAlign: TextAlign.center),
                                          getVerSpace(2.h),
                                        ],
                                      ),
                                    )),
                                  )),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return getProgressWidget(context);
                }
              }),
            ));
  }

  Expanded buildStoryList(BuildContext context) {
    return Expanded(
        child: Container(
      color: context.theme.focusColor,
      child: Obx(
        () {
          if (networkManager.isNetwork.value) {
            if (!controller.isStoryLoading.value) {
              return Obx(() {
                if (controller.storyList.isNotEmpty) {
                  return AnimationLimiter(
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.h, vertical: 20.h),
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
                                stream: FireBaseData.getAuthorById(
                                    id: storyBook.authId ?? []),
                                builder: (context, snapshot1) {
                                  if (snapshot1.data != null) {
                                    List<DocumentSnapshot> snap =
                                        snapshot1.data!.docs;

                                    String auth = FireBaseData.getAuthorName(
                                        author: storyBook.authId!, list: snap);

                                    // TopAuthors auth =
                                    // TopAuthors.fromFirestore(snapshot1.data!);

                                    return GestureDetector(
                                      onTap: () {
                                        Constant.sendToNextWithResult(
                                            context,
                                            PopularBookDetailScreen(
                                                storyModel: storyBook),
                                            () {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.h),
                                            border: Border.all(color: grey20)),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                // height: 230.h,
                                                width: 160.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.h),
                                                    image:
                                                        getDecorationNetworkImage(
                                                            context,
                                                            storyBook.image ??
                                                                "",
                                                            fit: BoxFit.fill)),
                                              ),
                                            ),
                                            getVerSpace(12.h),
                                            getCustomFont(
                                                    storyBook.name ?? "",
                                                    16.sp,
                                                    context.theme.primaryColor,
                                                    1,
                                                    fontWeight: FontWeight.w700)
                                                .marginSymmetric(
                                                    horizontal: 10.h),
                                            getVerSpace(1.h),
                                            getCustomFont(auth, 14.sp, grey, 1,
                                                    fontWeight: FontWeight.w400)
                                                .marginSymmetric(
                                                    horizontal: 10.h),
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
            } else {
              return getProgressWidget(context);
            }
          } else {
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
    ));
  }

  Container buildCategoryTabView(BuildContext context) {
    return Container(
      height: 60.h,
      color: context.theme.focusColor,
      child: Obx(
        () {
          if (!controller.isDataLoading.value &&
              controller.categoryList.isNotEmpty) {
            catList = controller.categoryList;
            if (selectedId.value == "0") {
              selectedId(catList[0].id);
              controller.getAllStoryList(catList[0].id ?? "");
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              scrollDirection: Axis.horizontal,
              itemCount: catList.length,
              itemBuilder: (context, index) {
                CategoryModel category = (catList[index]);

                return GestureDetector(
                    onTap: () {
                      selectedId.value = category.id ?? "";

                      controller.getAllStoryList(category.id ?? "");

                      controller.setBookTypeIndex(index);
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: selectedId.value == category.id
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(16.h),
                                color: maximumOrange)
                            : BoxDecoration(color: context.theme.focusColor),
                        child: selectedId.value == category.id
                            ? getCustomFont(category.name.toString(), 16.sp,
                                    regularWhite, 1,
                                    fontWeight: FontWeight.w700)
                                .paddingSymmetric(
                                    horizontal: 16.h, vertical: 8.h)
                            : getCustomFont(
                                    category.name.toString(), 16.sp, grey, 1,
                                    fontWeight: FontWeight.w400)
                                .paddingSymmetric(
                                    horizontal: 16.h, vertical: 8.h)));
              },
            );
          } else {
            return getProgressWidget(context);
          }
        },
      ),
    );
  }

  Widget buildTabView(CategoryTabController controller) {
    return Container(
      color: context.theme.focusColor,
      height: 60.h,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(KeyTable.category)
            .snapshots(),
        builder: (context, snapshot) {
          return getWidgetFromStatus(
              context: context,
              data: snapshot,
              child: checkEmptyData(
                  context: context,
                  querySnapshot: snapshot,
                  child: Builder(
                    builder: (context) {
                      List<DocumentSnapshot> list = snapshot.data!.docs;
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          CategoryModel category =
                              CategoryModel.fromFirestore(list[index]);

                          if (selectedId.value == "0") {
                            selectedId.value = category.id ?? "";
                          }

                          return GestureDetector(
                              onTap: () {
                                controller.setBookTypeIndex(index);
                                selectedId.value = category.id ?? "";
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.h),
                                  decoration: controller.typeIndex == index
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.h),
                                          color: maximumOrange)
                                      : BoxDecoration(
                                          color: context.theme.focusColor),
                                  child: controller.typeIndex == index
                                      ? getCustomFont(category.name.toString(),
                                              16.sp, regularWhite, 1,
                                              fontWeight: FontWeight.w700)
                                          .paddingSymmetric(
                                              horizontal: 16.h, vertical: 8.h)
                                      : getCustomFont(
                                              category.name.toString(), 16.sp, grey, 1,
                                              fontWeight: FontWeight.w400)
                                          .paddingSymmetric(
                                              horizontal: 16.h,
                                              vertical: 8.h)));
                        },
                      );
                    },
                  )));
        },
      ),
    );
  }
}
