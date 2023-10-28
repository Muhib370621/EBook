import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/datafile/firebase_data/firebasedata.dart';
import 'package:ebook_app/datafile/firebase_data/key_table.dart';
import 'package:ebook_app/main.dart';
import 'package:ebook_app/view/home_tab/top_authors/othors_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../ads/AdsFile.dart';
import '../../../models/top_authors_model.dart';
import '../../../utils/color_category.dart';
import '../../../utils/constant.dart';
import '../../../utils/constantWidget.dart';

class TopAuthorsScreen extends StatefulWidget {
  const TopAuthorsScreen({Key? key}) : super(key: key);

  @override
  State<TopAuthorsScreen> createState() => _TopAuthorsScreenState();
}

class _TopAuthorsScreenState extends State<TopAuthorsScreen> {
  // TopAuthorsScreenController topAuthorsScreenController = Get.put(
  //     TopAuthorsScreenController());

  // List<TopAuthors1> topAuthors = DataFile.getTopAuthorsData();
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
    return WillPopScope(onWillPop: () async {
      backClick();
      return false;
    },
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SafeArea(child: getDefaultWidget(Column(children: [
          getCustumAppbar(rightPermission: false,
              leftIcon: Get.isDarkMode
                  ? "left_arrow_white.svg"
                  : "back_arrow.svg",
              title: "Top Authors",
              leftFunction: () {
                backClick();
              },
              givecolor: context.theme.focusColor,
              titlecolor: context.theme.primaryColor),
          getVerSpace(20.h),
          buildAuthorList(context),
          ObxValue((p0) => adsFile.isLoading.value?getBanner(context, adsFile):Container(), adsFile.isLoading),
        ],))),
      ),);
  }

  Expanded buildAuthorList(BuildContext context) {
    return Expanded(child: Container(
          color: context.theme.focusColor,
          child: Obx(() {
            if(networkManager.isNetwork.value){
              return StreamBuilder<QuerySnapshot>(
                stream: FireBaseData.getAuthorList(),
                builder: (context, snapshot) {
                  return getWidgetFromStatus(
                      context: context, data: snapshot,
                      progressWidget: getAuthorProgressWidget(),
                      child: checkEmptyData(
                          context: context,
                          querySnapshot: snapshot,
                          child: Builder(builder: (context) {
                            List<DocumentSnapshot> list = snapshot.data!.docs;
                            return GridView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.h, vertical: 20.h),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 190.h,
                                  mainAxisSpacing: 20.h,
                                  crossAxisSpacing: 20.h),
                              itemCount: list.length,
                              itemBuilder: (BuildContext context, int index) {
                                TopAuthors authors = TopAuthors.fromFirestore(list[index]);
                                return GestureDetector(
                                  onTap: () {
                                    // topAuthorsScreenController.onSetOthorIndex(index);
                                    Constant.sendToNextWithResult(
                                        context, TopAuthorDetailScreen(authModel: authors),(){});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.h),
                                        border: Border.all(color: grey20)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 100.h,
                                            width: 100.h,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: getDecorationNetworkImage(context, authors.image ?? "",fit: BoxFit.fill)),
                                          ),
                                        ),
                                        getVerSpace(20.h),
                                        getCustomFont(authors.authorName!, 16.sp,
                                            context.theme.primaryColor, 1,
                                            fontWeight: FontWeight.w700),
                                        getVerSpace(2.h),
                                        StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance.collection(KeyTable.storyList).where(KeyTable.authId,arrayContains: authors.id).snapshots(),
                                          builder: (context, snapshot) {

                                          if(snapshot.data != null && snapshot.data!.size > 0){
                                            if(snapshot.connectionState == ConnectionState.active){
                                              return getCustomFont(
                                                  "${snapshot.data!.size} Books", 14.sp,
                                                  grey, 1, fontWeight: FontWeight.w400);
                                            }else{
                                              return getCustomFont(
                                                  " ", 14.sp,
                                                  grey, 1, fontWeight: FontWeight.w400);
                                            }
                                          }else{
                                            return getCustomFont(
                                                " ", 14.sp,
                                                grey, 1, fontWeight: FontWeight.w400);
                                          }

                                        },),
                                      ],
                                    ).paddingSymmetric(vertical: 16.h),
                                  ),
                                );
                              },
                            );
                          },)));
                },);
            }else{
              return getAuthorProgressWidget();
            }
          }),
        ).paddingOnly(bottom: 20.h));
  }


  Widget getAuthorProgressWidget(){
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
          horizontal: 20.h, vertical: 20.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 180.h,
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 20.h),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {

        return getShimmerWidget(context, Container(
          decoration: BoxDecoration(
            color: Colors.grey,
              borderRadius: BorderRadius.circular(16.h),
              border: Border.all(color: grey20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100.h,
                width: 100.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // image: getDecorationNetworkImage(context, authors.image ?? "",fit: BoxFit.fill)
                ),
              ),
              getVerSpace(20.h),
              getCustomFont("", 16.sp,
                  context.theme.primaryColor, 1,
                  fontWeight: FontWeight.w700),
              // getVerSpace(2.h),
              // getCustomFont(
              //     "${0} Books", 14.sp,
              //     grey, 1, fontWeight: FontWeight.w400),
            ],
          ).paddingSymmetric(vertical: 16.h),
        ));
      },
    );
  }
}
