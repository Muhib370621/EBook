import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/datafile/firebase_data/firebasedata.dart';
import 'package:ebook_app/main.dart';
import 'package:ebook_app/utils/pref_data.dart';
import 'package:ebook_app/view/home_tab/home_tab.dart';
import 'package:ebook_app/view/home_tab/populer_book_detail.dart';
import 'package:ebook_app/view/home_tab/top_authors/othors_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../datafile/firebase_data/key_table.dart';
import '../../models/book_list_model.dart';
import '../../models/top_authors_model.dart';
import '../../routes/app_routes.dart';
import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // List<TopAuthors1> topAuthors = DataFile.getTopAuthorsData();

  // List<TrenDingBook> trendingBook = DataFile.getTrenDingBookData();

  RxList<StoryModel> filterList = <StoryModel>[].obs;

  RxString filterText = "".obs;

  List<TopAuthors> authList = [];

  void backClick() {
    Constant.backToFinish();
  }

  TextEditingController controller = TextEditingController();
  RxList<String> recentList = <String>[].obs;
  // RxList<String> recent = <String>[].obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getRecentList();

Future.delayed(Duration.zero,() {
  w=AnimationLimiter(
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
            Container(
                color: context.theme.focusColor,
                child: Container(
                    color: context.theme.focusColor,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            getCustomFont(
                                "Featured Books",
                                20.sp,
                                context.theme.primaryColor,
                                1,
                                fontWeight: FontWeight.w700),
                            GestureDetector(
                                onTap: () {
                                  Constant.sendToNext(
                                      context,
                                      Routes
                                          .trendindBookScreenRoute);
                                },
                                child: getCustomFont(
                                    "View all",
                                    14.sp,
                                    Get.isDarkMode
                                        ? regularWhite
                                        : grey,
                                    1,
                                    fontWeight:
                                    FontWeight.w400))
                          ],
                        ).paddingSymmetric(horizontal: 20.h),
                        getVerSpace(16.h),
                        SizedBox(
                          height: 252.h,
                          child: Obx(() {
                            if (networkManager
                                .isNetwork.value) {
                              return StreamBuilder<
                                  QuerySnapshot>(
                                stream: FireBaseData
                                    .getFeaturedList(
                                    limit: 3),
                                builder: (context, snapshot) {
                                  return getWidgetFromStatus(
                                      context: context,
                                      data: snapshot,
                                      progressWidget:
                                      getFeatureBookProWidget(),
                                      child: checkEmptyData(
                                          context: context,
                                          querySnapshot:
                                          snapshot,
                                          child: Builder(
                                            builder:
                                                (context) {
                                              List<DocumentSnapshot>
                                              list =
                                                  snapshot
                                                      .data!
                                                      .docs;
                                              return ListView
                                                  .builder(
                                                physics:
                                                const BouncingScrollPhysics(),
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    10.h),
                                                itemCount: list
                                                    .length,
                                                scrollDirection:
                                                Axis.horizontal,
                                                itemBuilder:
                                                    (context,
                                                    index) {
                                                  StoryModel
                                                  book =
                                                  StoryModel.fromFirestore(
                                                      list[index]);
                                                  // TrenDingBook trending =
                                                  // trendingBook[index];
                                                  return StreamBuilder<
                                                      QuerySnapshot>(
                                                    stream: FireBaseData.getAuthorById(
                                                        id: book.authId ?? []),
                                                    builder:
                                                        (context,
                                                        snapshot1) {
                                                      if (snapshot1.data !=
                                                          null) {

                                                        List<DocumentSnapshot> list = snapshot1.data!.docs;

                                                        String auth = FireBaseData.getAuthorName(author: book.authId!, list: list);

                                                        // TopAuthors
                                                        //     auth =
                                                        //     TopAuthors.fromFirestore(snapshot1.data!);
                                                        return getCommonBookWidget(
                                                            context,
                                                            book.image ?? "",
                                                            book.name ?? "",
                                                            auth, () {
                                                          // trenDingBookScreenController.onSetIndex(index);
                                                          Constant.sendToNextWithResult(context, PopularBookDetailScreen(storyModel: book), (value) {});
                                                        }) .paddingSymmetric(horizontal: 10.h);
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
                            } else {
                              return getFeatureBookProWidget();
                            }
                          }),
                        )
                      ],
                    ).paddingSymmetric(vertical: 20.h))
                    .paddingSymmetric(vertical: 0.h)),
            // getVerSpace(20.h),
            Container(
                color: context.theme.focusColor,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        getCustomFont("Top Authors", 20.sp,
                            context.theme.primaryColor, 1,
                            fontWeight: FontWeight.w700),
                        GestureDetector(
                            onTap: () {
                              Constant.sendToNext(context,
                                  Routes.topAuthorsScreenRoute);
                            },
                            child: getCustomFont(
                                "View all",
                                14.sp,
                                Get.isDarkMode
                                    ? regularWhite
                                    : grey,
                                1,
                                fontWeight: FontWeight.w400))
                      ],
                    ).paddingSymmetric(horizontal: 20.h),
                    getVerSpace(16.h),
                    SizedBox(
                      height: 136.h,
                      child: Obx(() {
                        if (networkManager.isNetwork.value) {
                          return StreamBuilder<QuerySnapshot>(
                            stream: FireBaseData.getAuthorList(
                                limit: 5),
                            builder: (context, snapshot) {
                              return getWidgetFromStatus(
                                  context: context,
                                  data: snapshot,
                                  progressWidget:
                                  getAuthorProgressWidget(),
                                  child: checkEmptyData(
                                      context: context,
                                      querySnapshot: snapshot,
                                      child: Builder(
                                        builder: (context) {
                                          List<DocumentSnapshot>
                                          list =
                                              snapshot.data!.docs;
                                          return ListView.builder(
                                            physics:
                                            const BouncingScrollPhysics(),
                                            padding: EdgeInsets
                                                .symmetric(
                                                horizontal:
                                                10.h,vertical: 0.h),
                                            itemCount:
                                            list.length,
                                            scrollDirection:
                                            Axis.horizontal,
                                            itemBuilder:
                                                (context, index) {

                                              TopAuthors auth =
                                              TopAuthors
                                                  .fromFirestore(
                                                  list[index]);

                                              return Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      // topAuthorsScreenController.onSetOthorIndex(index);
                                                      Constant.sendToNextWithResult(
                                                          context, TopAuthorDetailScreen(authModel: auth),(value){});
                                                    },
                                                    child:
                                                    buildCommonAuthorsWidget(context, auth),
                                                  ),
                                                  getHorSpace(
                                                      16.5.h),
                                                  index ==
                                                      list.length -
                                                          1
                                                      ? const SizedBox()
                                                      : Container(
                                                    height:
                                                    133.h,
                                                    width:
                                                    1.h,
                                                    color:
                                                    grey20,
                                                  )
                                                ],
                                              ).paddingSymmetric(
                                                  horizontal:
                                                  8.h);
                                            },
                                          );
                                        },
                                      )));
                            },
                          );
                        } else {
                          return getAuthorProgressWidget();
                        }
                      }),
                    )
                  ],
                ).paddingSymmetric(vertical: 0.h)),
          ],
        )),
  );
  filterText.value = '';
},);


  }


  Widget? w;


  getRecentList() async {
    recentList.value = await PrefData.getRecentSearchList();
  }


  // searchFilter(String value) {
  //   for (String fruit in recentList.value) {
  //     if (fruit.toLowerCase().contains(value.toLowerCase())) {
  //       recent.add(fruit);
  //     }
  //   }
  //   if (value.isEmpty) {
  //     recent.clear();
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SafeArea(
            child: Column(
          children: [
            Container(
                color: context.theme.focusColor,
                child: Column(
                  children: [
                    getCustumAppbar(
                        rightPermission: false,
                        leftIcon: Get.isDarkMode
                            ? "left_arrow_white.svg"
                            : "back_arrow.svg",
                        title: "Search",
                        leftFunction: () {
                          backClick();
                        },
                        givecolor: context.theme.focusColor,
                        titlecolor: context.theme.primaryColor),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                                  cursorColor: maximumOrange,
                                  autofocus: true,
                                  onChanged: (value) {
                                    // print(
                                    // "value-----${searchController.searchText.value}------${value}");
                                    // setState(() {
                                    // searchController.searchText.value = value;
                                    // filterText.value = value;

                                    // });

                                    // searchFilter(value);
                                  },
                              onFieldSubmitted: (value) async {

                                filterText.value = value;

                                recentList.value =  await PrefData.getRecentSearchList();

                                if(recentList.contains(value)){
                                  recentList.remove(value);
                                }else{

                                  if(!(recentList.length < 3)){
                                    recentList.removeAt(0);
                                  }

                                }

                                recentList.add(value);
                                
                                PrefData.setRecentSearchList(recentList);
                              },
                                  controller: controller,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      prefixIcon: getSvgImage("searchIcon.svg",
                                              color: Get.isDarkMode
                                                  ? regularWhite
                                                  : null)
                                          .paddingOnly(
                                              top: 16.h,
                                              left: 16.w,
                                              bottom: 16.h,
                                              right: 13.h),
                                      hintText: 'Search...',
                                      hintStyle: TextStyle(
                                          color: grey,
                                          fontFamily: Constant.fontsFamily,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                      filled: true,
                                      fillColor: Get.isDarkMode
                                          ? Colors.grey.shade900
                                          : grey10,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.h),
                                          borderSide: BorderSide(color: grey10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.h),
                                          borderSide:
                                              BorderSide(color: maximumOrange))))
                        ),
                        (filterText.isNotEmpty)?getHorSpace(8.h):getHorSpace(0.h),
                        (filterText.isNotEmpty)?GestureDetector(onTap: (){
                          filterText.value = "";
                          controller.clear();
                        },child: getCustomFont("Cancel", 16.sp, grey, 1,fontWeight: FontWeight.w400,)):Container()
                      ],
                    ).paddingSymmetric(horizontal: 20.h)
                  ],
                ).paddingOnly(bottom: 18.h)),
            getVerSpace(20.h),
            Expanded(
              child: Container(
                color: context.theme.focusColor,
                child: ListView(
                  children: [

                    Obx(() => Container(
                      color: context.theme.focusColor,
                      child: Column(
                        children: [
                          (recentList.isNotEmpty && filterText.value.isEmpty)?getVerSpace(20.h):getVerSpace(0.h),
                          (recentList.isNotEmpty && filterText.value.isEmpty)?Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getCustomFont("Recent", 18.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w600,),
                              GestureDetector(onTap: (){
                                recentList.value = [];

                                PrefData.setRecentSearchList(recentList);


                              },child: getCustomFont("Clear all", 15.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w600,)),
                            ],
                          ).marginSymmetric(horizontal: 20.h):Container(),
                          (recentList.isNotEmpty && filterText.value.isEmpty)?getVerSpace(18.h):getVerSpace(0.h),
                          Obx(() => (recentList.isNotEmpty && filterText.value.isEmpty)?ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            shrinkWrap: true,
                            reverse: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: (recentList.length > 3)?3:recentList.length,
                            itemBuilder: (context, index) {

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  getCustomFont(recentList[index], 16.sp, grey, 1,fontWeight: FontWeight.w400),
                                  GestureDetector(onTap: (){
                                    recentList.removeAt(index);

                                    PrefData.setRecentSearchList(recentList);

                                    getRecentList();

                                  },child: getSvgImage("close.svg",width: 16.h,height: 16.h))
                                ],
                              ).marginSymmetric(vertical: 5.h);
                            },):Container())
                        ],
                      ),
                    ),),
                    Obx(
                      () => (filterText.value.isNotEmpty && controller.text.isNotEmpty)
                          ? (networkManager.isNetwork.value)
                              ? StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore
                                    .instance
                                    .collection(
                                    KeyTable.storyList)
                                    .where(KeyTable.isActive,
                                    isEqualTo: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  return getWidgetFromStatus(
                                      context: context,
                                      data: snapshot,
                                      progressWidget:
                                      Container(),
                                      child: checkEmptyData(
                                          context: context,
                                          querySnapshot:
                                          snapshot,
                                          child: Builder(
                                            builder: (context) {
                                              List<DocumentSnapshot>
                                              dataList =
                                                  snapshot.data!
                                                      .docs;

                                              RxList<StoryModel>
                                              storyList =
                                                  <StoryModel>[]
                                                      .obs;

                                              RxList<TopAuthors>
                                              authorList =
                                                  <TopAuthors>[]
                                                      .obs;

                                              for (int i = 0; i < dataList.length; i++) {
                                                StoryModel
                                                story =
                                                StoryModel.fromFirestore(
                                                    dataList[
                                                    i]);
                                                storyList
                                                    .add(story);
                                              }

                                              Future.delayed(Duration.zero,() async {
                                                authList = await FireBaseData.getAuthorNameList();
                                              },);



                                              print("authList------_4${authList.length}");

                                              if (storyList
                                                  .isNotEmpty) {
                                                filterList.value = storyList
                                                    .where((e) => e
                                                    .name!
                                                    .toLowerCase()
                                                    .contains(filterText
                                                    .value
                                                    .toLowerCase()))
                                                    .toList();


                                               authorList.value = authList
                                                    .where((e) => e
                                                    .authorName!
                                                    .toLowerCase()
                                                    .contains(filterText
                                                    .value
                                                    .toLowerCase()))
                                                    .toList();

                                               print("auth----------${authorList}");

                                                for(int i = 0;i<authorList.length;i++){

                                                  print("object-----------${storyList.where((p0) => p0.authId!.toList().contains(authorList[i].id))}");

                                                  filterList.addAll(storyList.where((p0) => p0.authId!.toList().contains(authorList[i].id)));

                                                }


                                               // for()


                                                // for(int j = 0;j<storyList.length;j++){
                                                //
                                                //
                                                //
                                                // }




                                               filterList.addAll(storyList.where((p0) => p0.authId!.contains(authorList.map((element) => element))).toList());
                                                // filterList.addAll(storyList.where((e1) => e1));

                                                // filterList.addAll();

                                              }

                                              if (filterList
                                                  .isNotEmpty) {
                                                return ListView
                                                    .builder(
                                                  physics:
                                                  const BouncingScrollPhysics(),
                                                  padding: EdgeInsets
                                                      .zero,
                                                  itemCount:
                                                  filterList
                                                      .length,
                                                  scrollDirection:
                                                  Axis.vertical,
                                                  shrinkWrap:
                                                  true,
                                                  itemBuilder:
                                                      (context,
                                                      index) {
                                                    StoryModel
                                                    story =
                                                    filterList[
                                                    index];

                                                    // TrenDingBook trending =
                                                    // trendingBook[index];

                                                    return StreamBuilder<
                                                        QuerySnapshot>(
                                                      stream: FireBaseData.getAuthorById(
                                                          id: story.authId ??
                                                              []),
                                                      builder:
                                                          (context,
                                                          snapshot1) {
                                                        if (snapshot1.data != null) {

                                                          List<DocumentSnapshot> list = snapshot1.data!.docs;

                                                          String auth = FireBaseData.getAuthorName(author: story.authId!, list: list);

                                                          // TopAuthors
                                                          //     auth =
                                                          //     TopAuthors.fromFirestore(snapshot1.data!);

                                                          return GestureDetector(
                                                            onTap: (){
                                                              Constant.sendToNextWithResult(context, PopularBookDetailScreen(storyModel: story),(){});
                                                            },
                                                            child: Container(
                                                              height: 114.h,
                                                              decoration: BoxDecoration(
                                                                color: Colors.transparent,
                                                                borderRadius: BorderRadius.circular(16.r),
                                                                border: Border.all(color: grey20),
                                                              ),
                                                              margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.h),
                                                              padding: EdgeInsets.all(12.h),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    width: 60.h,
                                                                    height: double.infinity,

                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                                        image: getDecorationNetworkImage(context, story.image ?? "",fit: BoxFit.cover)
                                                                    ),
                                                                  ),
                                                                  getHorSpace(24.h),
                                                                  Expanded(child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      getCustomFont(story.name ?? "", 16.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w700),
                                                                      getVerSpace(5.h),
                                                                      getCustomFont(auth, 14.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w400)
                                                                    ],
                                                                  ))
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                          // return getCommonBookWidget(
                                                          //     context,
                                                          //     story.image ?? "",
                                                          //     story.name ?? "",
                                                          //     auth, () {
                                                          //   Constant.sendToNextWithResult(context, PopularBookDetailScreen(storyModel: story), (value) {});
                                                          // }).paddingSymmetric(horizontal: 10.h);
                                                        } else {
                                                          return Container();
                                                        }
                                                      },
                                                    );
                                                  },
                                                );
                                              } else {
                                                return Container(
                                                  // height: double.infinity,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        getVerSpace(200.h),
                                                        getCustomFont(
                                                            "Couldn't find “books”",
                                                            22.sp,
                                                            context.theme.primaryColor,
                                                            1,fontWeight: FontWeight.w700),
                                                        getVerSpace(10.h),
                                                        getCustomFont("Try searching again using a different spelling \nor keyword.", 16.sp, context.theme.primaryColor, 2,fontWeight: FontWeight.w400,textAlign: TextAlign.center)
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          )));
                                },
                              ).paddingSymmetric(vertical: 10.h)
                                  .paddingSymmetric(vertical: 20.h)

                              : Container(
                        alignment: Alignment.center,
                        child: getCustomFont("Please Connect to Internet",
                            20.h, Get.isDarkMode?regularWhite:regularBlack, 1),
                      )
                          : w??Container(),
                    ),


                  ],
                ),
              ),
            )
          ],
        )),
      ),
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

  ListView getFeatureBookProWidget() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return getCommonBookShimmerWidget(
          context,
        ).paddingSymmetric(horizontal: 10.h);
      },
    );
  }
}
