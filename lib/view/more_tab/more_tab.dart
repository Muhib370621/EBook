// ignore: unnecessary_import
import 'package:ebook_app/view/more_tab/practiceSheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../controller/login_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../../utils/theme_service.dart';

class MoreTab extends StatefulWidget {
  const MoreTab({Key? key}) : super(key: key);

  @override
  State<MoreTab> createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  MoreTabController moreTabController = Get.put(MoreTabController());

  void backClick() {
    Constant.closeApp();
  }

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () async {
        HomeMainScreenController mainScreenController = Get.find();

        mainScreenController.onChange(2.obs);
        return false;
        // backClick();
        // return false;
      },
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        //backgroundColor: bgColor,
        body: GetBuilder<MoreTabController>(
          init: MoreTabController(),
          builder: (moreTabController) => SafeArea(
              child: Column(
            children: [
              getCustumAppbar(
                  rightPermission: false,
                  leftIcon: Get.isDarkMode
                      ? "left_arrow_white.svg"
                      : "back_arrow.svg",
                  title: "More",
                  leftFunction: () {
                    // backClick()
                    HomeMainScreenController mainScreenController = Get.find();
                    mainScreenController.onChange(2.obs);
                  },
                  givecolor: context.theme.focusColor,
                  titlecolor: context.theme.primaryColor),
              getVerSpace(20.h),
              Expanded(
                  child: Container(
                color: context.theme.focusColor,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: AnimationLimiter(
                    child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 300),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: MediaQuery.of(context).size.width / 2,
                        child: FadeInAnimation(child: widget),
                      ),
                      children: [
                        getVerSpace(20.h),
                        getMoreTabOption(
                            "Profile.svg",
                            "My Profile",
                            Get.isDarkMode
                                ? "white_right_icon.svg"
                                : "arrow_right.svg", () {

                          Constant.sendToNext(
                              context, Routes.myProfileScreenRoute);

                        }, context.theme.focusColor,
                            context.theme.primaryColor),
                        getVerSpace(20.h),
                        // getMoreTabOption(
                        //     "more_notification_icon.svg",
                        //     "Notifications",
                        //     moreTabController.notification
                        //         ? "select_switch_button.svg"
                        //         : "unselect_switch_button.svg", () {
                        //   moreTabController.onSetNotification();
                        // }, context.theme.focusColor,
                        //     context.theme.primaryColor),
                        // getVerSpace(20.h),
                        getMoreTabOption(
                            "more_dark_mode_icon.svg",
                            "Dark Mode",
                            moreTabController.currentTheme
                                ? "select_switch_button.svg"
                                : "unselect_switch_button.svg", () {
                          moreTabController.onSetTheme();
                          ThemeService().switchTheme;
                        }, context.theme.focusColor,
                            context.theme.primaryColor),
                        getVerSpace(20.h),
                        getMoreTabOption(
                            "more_about_us_icon.svg",
                            "About Us",
                            Get.isDarkMode
                                ? "white_right_icon.svg"
                                : "arrow_right.svg", () {

                          Constant.sendToNext(
                              context, Routes.aboutUsScreenRoute);

                        }, context.theme.focusColor,
                            context.theme.primaryColor),

                        getVerSpace(20.h),
                        getMoreTabOption(
                            "more_rate_us_icon.svg",
                            "Rate Us",
                            Get.isDarkMode
                                ? "white_right_icon.svg"
                                : "arrow_right.svg", () {
                          getRateUsDialogue();
                        }, context.theme.focusColor,
                            context.theme.primaryColor),
                        getVerSpace(20.h),
                        getMoreTabOption(
                            "more_feedback_icon.svg",
                            "Feedback",
                            Get.isDarkMode
                                ? "white_right_icon.svg"
                                : "arrow_right.svg", () {


                          Constant.sendToNext(context, Routes.feedBackScreenRoute);


                        }, context.theme.focusColor,
                            context.theme.primaryColor),
                        getVerSpace(20.h),



                        // StreamBuilder<QuerySnapshot>(
                        //   stream: FirebaseFirestore.instance
                        //       .collection(KeyTable.appDetail)
                        //       .snapshots(),
                        //   builder: (context, snapshot) {
                        //
                        //
                        //     print("snap------${snapshot.data}");
                        //     if (snapshot.data != null &&
                        //         snapshot.connectionState ==
                        //             ConnectionState.active) {
                        //       List<DocumentSnapshot> list = snapshot.data!.docs;
                        //
                        //       AppDetailModel appDetail =
                        //       AppDetailModel.fromFirestore(list[0]);
                        //       return Column(
                        //         children: [
                        //           getMoreTabOption(
                        //               "more_terms_condition_icon.svg",
                        //               "Terms & Conditions",
                        //               Get.isDarkMode
                        //                   ? "white_right_icon.svg"
                        //                   : "arrow_right.svg", () {
                        //
                        //
                        //                 launchURL(appDetail.terms ?? "");
                        //
                        //
                        //             // Constant.sendToNext(
                        //             //     context, Routes.termsAndConditionScreenRoute);
                        //           }, context.theme.focusColor,
                        //               context.theme.primaryColor),
                        //         ],
                        //       );
                        //     } else {
                        //       return Container();
                        //     }
                        //   },
                        // ),


                        getMoreTabOption(
                            "more_terms_condition_icon.svg",
                            "Terms & Conditions",
                            Get.isDarkMode
                                ? "white_right_icon.svg"
                                : "arrow_right.svg", () {

                          if(moreTabController.model != null){
                            launchURL(moreTabController.model!.terms ?? "");
                          }else{
                            Constant.sendToNext(
                                context, Routes.termsAndConditionScreenRoute);
                          }
                        }, context.theme.focusColor,
                            context.theme.primaryColor),

                        getVerSpace(20.h),
                        getMoreTabOption(
                            "more_terms_condition_icon.svg",
                            "Practice Sheet",
                            Get.isDarkMode
                                ? "white_right_icon.svg"
                                : "arrow_right.svg", () {

                         Get.to(()=> PracticeSheet(practiceString: '',));
                        }, context.theme.focusColor,
                            context.theme.primaryColor),

                        getVerSpace(20.h),
                        // (!kIsWeb)
                        //     ? getMoreTabOption(
                        //         "download_icon.svg",
                        //         "Save Book",
                        //         Get.isDarkMode
                        //             ? "white_right_icon.svg"
                        //             : "arrow_right.svg", () {
                        //         Constant.sendToNext(
                        //             context, Routes.saveTabRoute);
                        //       }, context.theme.focusColor,
                        //         context.theme.primaryColor)
                        //     : Container(),
                        // getVerSpace(20.h),
                        getMoreTabOption(
                            "saveIcon.svg",
                            "My Favourite Book",
                            Get.isDarkMode
                                ? "white_right_icon.svg"
                                : "arrow_right.svg", () {
                          Constant.sendToNext(context, Routes.bookMarkRoute);
                        }, context.theme.focusColor, context.theme.primaryColor),

                        getVerSpace(20.h),
                        getCustomButton( "Log out",
                             () async {

                              // SharedPreferences prefs = await SharedPreferences.getInstance();
                              // prefs.setBool(LoginController.keyLogin, false);
                              // prefs.setString(LoginController.keyCurrentUser, '');
                              // Preferences.preferences.saveBool(key: PrefernceKey.isProUser,value: false);


                               HomeMainScreenController controller = Get.find();

                               controller.index.value = 2;

                              loginController.logout();

                              Constant.sendToNext(context, Routes.loginScreen);

                              // Constant.backToFinish(context);
                            },
                            ).marginSymmetric(horizontal: 20.h,vertical: 10.h),


                      ],
                    )),
                  ),
                ),
              ).paddingOnly(bottom: 33.h)),

            ],
          )),
        ),
      ),
    );
  }
}
