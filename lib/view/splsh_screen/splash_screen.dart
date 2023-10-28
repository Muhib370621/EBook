import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../datafile/firebase_data/firebasedata.dart';
import '../../models/book_list_model.dart';
import '../../routes/app_routes.dart';
import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../../utils/pref_data.dart';
import '../home_tab/populer_book_detail.dart';
import '../intro_screen/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: false, min: 0.5, max: 1.0, period: Duration(seconds: 5));
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  RxBool isData = false.obs;

  @override
  void initState() {
    _getIsFirst();
    super.initState();
  }

  _getIsFirst() async {

    bool isIntro = await PrefData.getIsIntro();

    // ignore: unused_local_variable
    bool isdetailed = await PrefData.getIsDetailed();

    bool isLogin = await PrefData.getLogin();

    Future.delayed(Duration.zero, () async {

      String id = await PrefData.getStoryId();
      String link = await PrefData.getLink();
      print("splashP_id===$id");

      if (id.isNotEmpty) {
        StoryModel? story = await FireBaseData.fetchStory(id);

        Get.to(PopularBookDetailScreen(
          storyModel: story!,
        ));
      } else {

        isData.value = true;
        if (link.isNotEmpty) {
          Constant.launchURL(link);
          PrefData.setLink("");

          PrefData.setIsBack(true);
        } else {
          Timer(const Duration(seconds: 3), () async {
            // Constant.sendToNext(context, Routes.introRoute);
            Get.to(IntroScreen());
            if (isIntro) {
              Constant.sendToNext(context, Routes.introRoute);
              // Constant.sendToNext(context, Routes.introRoute);
            } else {
              if (isLogin) {
                Constant.sendToNext(context, Routes.homeMainScreenRoute);
              } else {
                Constant.sendToNext(context, Routes.loginScreen);
              }

              // // if(myapp.message != null){
              //
              //
              //   // String storyId = myapp.message!.data["storyId"];
              //   //
              //   // StoryModel? story = await FireBaseData.fetchStory(storyId);
              //   //
              //   // print("story--------------${story!.id}");
              //   // Get.to(PopularBookDetailScreen(
              //   //   storyModel: story,
              //   // ));
              //
              // // }else{
              //   Constant.sendToNext(context, Routes.homeMainScreenRoute);
              // // }
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Obx(() => isData.value?GetBuilder<MoreTabController>(
      init: MoreTabController(),
      builder: (moreTabController) => Scaffold(
        backgroundColor: Get.isDarkMode ? maximumOrange : purple,
        body: SafeArea(
          child: getDefaultWidget(Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ScaleTransition(
                scale: _animation,
                child: getAssetImage(
                    Get.isDarkMode
                        ? "ebookNewLogo.jpeg"
                        : "ebookNewLogo.jpeg",
                    width: 170.56.h,
                    height: 191.h),
              ),
            ],
          )),
        ),
      ),
    ):Container(
      color: Get.isDarkMode ? maximumOrange : regularWhite,
    ));
  }
}
