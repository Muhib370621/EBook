import 'package:ebook_app/models/intro_screen_model.dart';
import 'package:ebook_app/utils/color_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../datafile/datafile.dart';
import '../../routes/app_routes.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../../utils/pref_data.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  IntroScreenController introScreenController = Get.put(IntroScreenController());
  PageController controller = PageController();
  List<IntroData> pages = DataFile.getIntroData();
  backClick() {
    Constant.closeApp();
  }

  @override
  Widget build(BuildContext context) {

    initializeScreenSize(context);
    return WillPopScope (
      onWillPop: () async {
        backClick();
        return false;
      },
      child: getDefaultWidget(Scaffold(
        backgroundColor: pages[introScreenController.currentPage].color,
        body: SafeArea(
            child: GetBuilder<IntroScreenController>(
              init: IntroScreenController(),
              builder: (introScreenController) => Stack(
                children: [
                  generatepage(),
                  getVerSpace(40.h),
                  Column(
                    children: [
                      indicator(),
                      getCustomButton(introScreenController.currentPage ==pages.length-1?"Get Started":"Next", () {
                        if (introScreenController.currentPage ==
                            pages.length - 1) {
                          //Constant.sendToNext(context, Routes.homemainscreenRoute);
                          PrefData.setIsIntro(false);
                          Constant.sendToNext(context, Routes.loginScreen);
                        } else {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.bounceIn);
                        }
                      }).paddingSymmetric(horizontal: 20.h),
                      getVerSpace(20.h),
                      GestureDetector(onTap: (){
                        PrefData.setIsIntro(false);
                        Constant.sendToNext(context, Routes.loginScreen);
                      },child: getCustomFont("Skip", 16.sp, regularBlack, 1,fontWeight: FontWeight.w400))
                    ],
                  ).paddingOnly(top: 609.h)
                ],
              ).paddingOnly(top: 40.h),
            )),
      )),
    );
  }

  Widget generatepage() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: PageView.builder(
          itemCount: pages.length,
          scrollDirection: Axis.horizontal,
          controller: controller,
          onPageChanged: (value) {
            introScreenController.onPageChange(value);
          },
          itemBuilder: (context, index) {

            print(controller.initialPage);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  height: 475.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "${Constant.assetImagePath}${pages[index].image}"),
                          fit: BoxFit.fill)),
                ),
                getCustomFont(pages[index].title!, 28.h, regularBlack,1,
                    fontWeight: FontWeight.w700, textAlign: TextAlign.center,txtHeight: 1.5.h),
                getVerSpace(14.h),
                getMultilineCustomFont(
                    pages[index].discription!, 16.sp, regularBlack,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,txtHeight: 1.5.h).paddingSymmetric(horizontal: 43.h),
                getVerSpace(30.h),


              ],
            );
          }),
    );
  }

  Widget indicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pages.length, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 8.h,
            width: index == introScreenController.currentPage ? 17.w : 8.w,
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 30.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.h),
                color: (index == introScreenController.currentPage)
                    ? maximumOrange
                    : maximumOrange.withOpacity(0.2)),
          );
        }));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
