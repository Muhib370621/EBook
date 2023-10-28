import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/datafile/firebase_data/firebasedata.dart';
import 'package:ebook_app/models/user_model.dart';
import 'package:ebook_app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../slider_option_class/dashboard_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Scaffold(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            body: getDefaultWidget(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Container(
                color: regularWhite,
                child: getCustumAppbar(
                    leftIcon: Get.isDarkMode
                        ? "left_arrow_white.svg"
                        : "back_arrow.svg",
                    rightPermission: true,
                    rightIcon: Get.isDarkMode?"edit_white.svg":"edit.svg",
                    title: "My Profile",
                    leftFunction: () {
                      backClick();
                    },
                    rightFunction: (){
                      Constant.sendToNext(context, Routes.editProfileScreenRoute);
                    },
                    givecolor: context.theme.focusColor,
                    titlecolor: context.theme.primaryColor),
              ),
              getVerSpace(20.h),
              Expanded(child: StreamBuilder<DocumentSnapshot>(
                stream: FireBaseData.getLoginData(),
                builder: (context, snapshot) {

                  if(snapshot.data != null){

                    UserModel user = UserModel.fromFireStore(snapshot.data!);

                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20.h),
                          color: Get.isDarkMode?Colors.grey.shade900:context.theme.focusColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getVerSpace(20.h),
                              getCustomFont("Username", 16.sp, grey, 1,fontWeight: FontWeight.w400),
                              getVerSpace(5.h),
                              getCustomFont(user.username ?? "", 18.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w500),
                              getVerSpace(12.h),
                              Divider(
                                color: grey20,
                                height: 2.h,
                                thickness: 2.h,

                              ),


                              getVerSpace(24.h),

                              // getCustomFont("Password", 16.sp, grey, 1,fontWeight: FontWeight.w400),
                              // getVerSpace(5.h),
                              // getCustomFont(user.password ?? "", 18.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w500),
                              // getVerSpace(12.h),
                              // Divider(
                              //   color: grey20,
                              //   height: 2.h,
                              //   thickness: 2.h,
                              //
                              // ),
                              // getVerSpace(24.h),
                              getCustomFont("Email", 16.sp, grey, 1,fontWeight: FontWeight.w400),
                              getVerSpace(5.h),
                              getCustomFont(user.email ?? "", 18.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w500),
                              getVerSpace(12.h),
                              Divider(
                                color: grey20,
                                height: 2.h,
                                thickness: 2.h,

                              ),

                              getVerSpace(20.h),

                            ],
                          ),
                        ),
                        getVerSpace(20.h),
                        GestureDetector(
                          onTap: (){
                            Get.dialog(AlertDialog(
                              backgroundColor: context.theme.dialogTheme.backgroundColor,
                              content: getCustomFont("Are you sure want to reset your password?", 18.sp, context.theme.primaryColor, 2,fontWeight: FontWeight.w500,),

                              actionsPadding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 20.h),
                              actions: [
                                GestureDetector(onTap: (){Constant.backToFinish();},child: getCustomFont("No", 20.sp, maximumOrange, 1,fontWeight: FontWeight.w400)),
                                getHorSpace(20.h),
                                GestureDetector(onTap: (){


                                  if(FirebaseAuth.instance.currentUser != null){

                                    // bool isAlreadyRegister = await     LoginData.userAlreadyRegister(context,phoneNumber:
                                    // emailController.text,password: "");
                                    // if(isAlreadyRegister){

                                    FirebaseAuth.instance.sendPasswordResetEmail(email: FirebaseAuth.instance.currentUser!.email ?? "").then((value) {
                                      Constant.backToFinish();

                                      showCustomToast(
                                          message: "We have sent you instructions to reset your password!");
                                    })
                                        .catchError(
                                            (e) {

                                        });

                                  }else{
                                    // showCustomToast(message: 'Email not Fou');
                                  }

                                },child: getCustomFont("Yes", 20.sp, maximumOrange, 1,fontWeight: FontWeight.w400))
                              ],
                            ));
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 15.h),
                            color: Get.isDarkMode?Colors.grey.shade900:context.theme.focusColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getCustomFont("Reset password", 18.sp, context.theme.primaryColor, 1,fontWeight: FontWeight.w500),
                                getSvgImage(Get.isDarkMode
                                    ? "white_right_icon.svg"
                                    : "arrow_right.svg")
                              ],
                            ),
                          ),
                        )
                      ],
                    );

                  }else{
                    return getProgressWidget(context);
                  }



              },))
              // Expanded(
              //   child: ListView(
              //     physics: const BouncingScrollPhysics(),
              //     children: [
              //       GetBuilder<MoreTabController>(
              //         init: MoreTabController(),
              //         builder: (controller) {
              //           return Container(
              //             color: context.theme.focusColor,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 // question('1.Types of data we collect'),
              //                 getVerSpace(16.h),
              //
              //
              //                 getHtmlWidget(context, controller.model!.aboutUs ?? "", 18.sp)
              //
              //
              //                 // answer(removeAllHtmlTags(controller.model!.aboutUs ?? "")),
              //
              //               ],
              //             ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
              //           ).paddingSymmetric(vertical: 10.h);
              //         },),
              //       // Container(
              //       //   color: context.theme.focusColor,
              //       //   child: Column(
              //       //     crossAxisAlignment: CrossAxisAlignment.start,
              //       //     children: [
              //       //       question('2. Use of your personal Data'),
              //       //       getVerSpace(16.h),
              //       //       answer(
              //       //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
              //       //     ],
              //       //   ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
              //       // ).paddingSymmetric(vertical: 10.h),
              //       // Container(
              //       //   color: context.theme.focusColor,
              //       //   child: Column(
              //       //     crossAxisAlignment: CrossAxisAlignment.start,
              //       //     children: [
              //       //       question('3. Disclosure of your personal Data'),
              //       //       getVerSpace(16.h),
              //       //       answer(
              //       //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
              //       //     ],
              //       //   ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
              //       // ).paddingSymmetric(vertical: 10.h),
              //     ],
              //   ),
              // )
            ]))),
      ),
    );
  }
}
