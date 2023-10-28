
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/datafile/firebase_data/firebasedata.dart';
import 'package:ebook_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../slider_option_class/dashboard_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {


  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  int currentPosition = -1;

  int userPosition = 1;
  int emailPosition = 2;

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
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                color: regularWhite,
                child: getCustumAppbar(
                    leftIcon: Get.isDarkMode
                        ? "left_arrow_white.svg"
                        : "back_arrow.svg",
                    rightPermission: false,
                    // rightIcon: "edit.svg",
                    title: "Edit Profile",
                    leftFunction: () {
                      backClick();
                    },
                    givecolor: context.theme.focusColor,
                    titlecolor: context.theme.primaryColor),
              ),
              getVerSpace(20.h),
              Expanded(
                child: Container(
                  color: context.theme.focusColor,
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<DocumentSnapshot>(
                          stream: FireBaseData.getLoginData(),
                          builder: (context, snapshot) {
                            if(snapshot.data != null){

                              UserModel u = UserModel.fromFireStore(snapshot.data!);


                              usernameController.text = u.username ?? "";
                              emailController.text = u.password ?? "";

                              return ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  getVerSpace(20.h),
                                  getDefaultTextFiledWidget(
                                      context, "Username", usernameController,
                                      // focus: (currentPosition == userPosition),
                                      onTapFunction: () {
                                        // setState(() {
                                        //   currentPosition = userPosition;
                                        // });
                                      }).marginSymmetric(horizontal: 20.h),
                                  // getVerSpace(10.h),

                                  // getDefaultTextFiledWidget(
                                  //     context, "Email Address", emailController,
                                  //     focus: (currentPosition == emailPosition),
                                  //     onTapFunction: () {
                                  //       setState(() {
                                  //         currentPosition = emailPosition;
                                  //       });
                                  //     }).marginSymmetric(horizontal: 20.h),


                                ],
                              );
                            }else{
                              return getProgressWidget(context);
                            }

                          },),
                      ),
                      getCustomButton("Save", () async {


                        bool isValid = checkEditValidation();


                        // // User firebaseUser = FirebaseAuth.instance.currentUser!;
                        //
                        //
                        // // firebaseUser.reauthenticateWithCredential(credential);
                        // //
                        // firebaseUser.verifyBeforeUpdateEmail("clientdemoapp12@gmail.com");


                        // print("firebaseUser-------------$firebaseUser");
                        //
                        //
                        // firebaseUser.updateEmail("111kevadiyahemanshi.dream@gmail.com");

                        // print("firebaseUser-------------111-[-------$firebaseUser");


                        // FirebaseAuth.instance.currentUser!.updateEmail(emailController.text);
                        //
                        // FirebaseAuth.instance.currentUser!.sendEmailVerification();


                        if(isValid){
                          // UserModel user = UserModel();
                          //
                          // user.username = usernameController.text;
                          // user.email = emailController.text;


                          // FireBaseData.changePassword(password: emailController.text, username: usernameController.text, function: (){Constant.backToFinish();}, context: context);


                          // String id = await PrefData.getUserId();
                          // UserModel user = UserModel();
                          //
                          // user.username = usernameController.text;
                          // user.email = emailController.text;
                          //
                          // // FirebaseAuth.instance.currentUser!.updateEmail(emailController.text);
                          // // bool v = FirebaseAuth.instance.currentUser!.emailVerified;
                          //
                          // print("v---------------$v");
                          // FireBaseData.updateData(map: user.toJson(),
                          //     tableName: KeyTable.loginData,
                          //     doc: id,
                          //     function: (){
                          //       Constant.backToFinish();
                          //     },
                          //     context: context);
                        }


                      }).marginSymmetric(horizontal: 20.h),
                      getVerSpace(20.h)
                    ],
                  ),
                ),
              )
            ]))),
      ),
    );
  }


  bool checkEditValidation(){
    if(isNotEmpty(usernameController.text)){
      if(isNotEmpty(emailController.text)){

        return true;

        // if(isValidEmail(emailController.text)){
        //   return true;
        // }else{
        //
        //   showCustomToast(message: "Email not valid");
        //   return false;
        // }

      }else{
        showCustomToast(message: "Please enter email");
        return false;
      }
    }else{
      showCustomToast(message: "Please enter username");
      return false;
    }
  }
}
