import 'package:ebook_app/datafile/firebase_data/firebasedata.dart';
import 'package:ebook_app/view/slider_option_class/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../../utils/theme_data.dart';
import 'login_data.dart';


class ResetPasswordScreen extends StatefulWidget {
  final String? email;


  const ResetPasswordScreen({super.key, this.email});

  @override
  _ResetPasswordScreen createState() {
    return _ResetPasswordScreen();
  }
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  Future<bool> _requestPop() {
    Constant.backToFinish();

    return Future.value(false);
  }
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  int currentPosition=-1;
  int passPosition=2;
  int confirmPosition=3;
  // ignore: unused_field
  RxBool _isObscureText=true.obs;
  // ignore: unused_field
  RxBool _isObscureText1=true.obs;

  final passKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: getLoginBackgroundColor(context),
          // backgroundColor: context.theme.scaffoldBackgroundColor,
          // appBar: getNoneAppBar(context),
          appBar: getCommonLoginAppBar(context, title: "Change Password",withLeading: true,onTap: (){backClick();}),
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              children: [
                // getVerSpace(55.h),
                // Container(
                //   alignment: Alignment.center,
                //   child: Container(
                //       height: 120.h,
                //       width: 120.h,
                //       child: getSvgImage( "logo_ebook.svg",
                //         height: double.infinity,)),
                // ),

                getVerSpace(40.h),

                getCustomFont("Please enter your new password", 16.sp, context.theme.primaryColor, 1,
                    fontWeight: FontWeight.w400, textAlign: TextAlign.center),
                getVerSpace(32.h),

            Form(
              key: passKey,
                child: Column(
              children: [
                getPasswordTextFiledWidget(context, "Password", passwordController,
                    // focus: (currentPosition==passPosition),
                    onTapFunction: (){
                      // setState((){
                      //   currentPosition=passPosition;
                      // });
                    },
                    validator: (pass) {
                      if (isPasswordValid(pass)) return null;
                      else if(pass.length < 6) return "Password must be 6 character long";
                      else
                        return 'Enter a valid password';
                    },
                    ),



                getVerSpace(20.h),
                getPasswordTextFiledWidget(context, "Confirm Password",
                    confirmPasswordController,
                    // focus: (currentPosition==confirmPosition),
                    validator: (pass) {
                      if (passwordController.text == confirmPasswordController.text) return null;
                      else
                        return 'Password not match';
                    },
                    onTapFunction: (){
                      // setState((){
                      //   currentPosition=confirmPosition;
                      // });
                    },),
              ],
            )),
                getVerSpace(56.h),


                getCustomButton(
                    "Reset Password", () async {




                      if(passKey.currentState!.validate()){

                        String id = await LoginData.getUserId(email: widget.email);

                        // await LoginData.changePassword(password: passwordController.text,id :id);

                        FireBaseData.changePassword(password: passwordController.text,id: id, function: (){

                          Constant.sendToNext(context, Routes.changedPassScreen);

                        }, context: context);

                        // Constant.sendToNext(context, Routes.loginScreen);
                      }



                      // if(isNotEmpty(passwordController.text)){
                      //   if(isNotEmpty(confirmPasswordController.text)){
                      //
                      //
                      //     if(passwordController.text == confirmPasswordController.text){
                      //
                      //
                      //       String id =await LoginData.getUserId(email: widget.email);
                      //
                      //       await LoginData.changePassword(password: passwordController.text,id :id);
                      //
                      //       Constant.sendToNext(context, Routes.loginScreen);
                      //
                      //
                      //     }else{
                      //       showCustomToast(message: 'Password not match');
                      //     }
                      //
                      //   }else{
                      //     showCustomToast(message: "Enter confirm password");
                      //   }
                      // }else{
                      //   showCustomToast(message: "Enter password");
                      //
                      // }


                    },),

                getVerSpace(15.h),
              ],
            ),
          ),
        ));
  }
}


bool isPasswordValid(String password) => password.length >= 6;

