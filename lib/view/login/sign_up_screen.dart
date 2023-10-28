import 'package:ebook_app/view/login/reset_password_page.dart';
import 'package:ebook_app/view/login/verification_page.dart';
import 'package:ebook_app/view/slider_option_class/dashboard_screen.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../datafile/firebase_data/firebasedata.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../../utils/theme_data.dart';
import '../dialog/create_account_dialog.dart';
import 'login_data.dart';

class SignUpScreen extends StatefulWidget {
  final LoginController loginController;

  SignUpScreen({required this.loginController});

  @override
  _SignUpScreen createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> {
  Future<bool> _requestPop() {
    Constant.backToFinish();

    return Future.value(false);
  }

  String countryCode = "IN";

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  // TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  int firstPosition = 4;
  int lastPosition = 5;
  int phonePosition = 6;
  int currentPosition = -1;
  int passPosition = 2;
  int confirmPosition = 3;
  @override
  // ignore: override_on_non_overriding_member
  final userKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: getLoginBackgroundColor(context),
          // backgroundColor: context.theme.scaffoldBackgroundColor,
          // appBar: getNoneAppBar(context),

          appBar: getCommonLoginAppBar(context,
              title: "Sign Up", withLeading: true, onTap: () {
            backClick();
          }),

          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              children: [
                // getVerSpace(30.h),
                // // Container(
                // //   alignment: Alignment.center,
                // //   child: Container(
                // //       height: 120.h,
                // //       width: 120.h,
                // //       child: getSvgImage("logo_ebook.svg",
                // //         height: double.infinity,)),
                // // ),
                // //
                // // getVerSpace(10.h),
                //
                // getCustomFont("Sign Up", 30, context.theme.primaryColor, 1,
                //     fontWeight: FontWeight.w700, textAlign: TextAlign.center),
                getVerSpace(30.h),

                getCustomFont("Welcome to the E-book Reader", 16.sp,
                    context.theme.primaryColor, 1,
                    fontWeight: FontWeight.w400, textAlign: TextAlign.center),

                getVerSpace(32.h),

                Form(
                    key: userKey,
                    child: Column(
                      children: [
                        getDefaultTextFiledWidget(
                            context, "Username", usernameController,
                            // focus: (currentPosition == firstPosition),
                            validator: (username) {
                              if (username.isNotEmpty) return null;
                              // else if(email.isEmpty) return "Please Enter Email";
                              else
                                return 'Enter a username';
                            },
                            onTapFunction: () {
                          // setState(() {
                          //   currentPosition = firstPosition;
                          // });
                        }),

                        getVerSpace(20.h),

                        getDefaultTextFiledWidget(
                            context, "Email", emailController,
                            // focus: (currentPosition == lastPosition),
                            validator: (email) {
                              if (isValidEmail(email)) return null;
                              // else if(email.isEmpty) return "Please Enter Email";
                              else
                                return 'Enter a valid email address';
                            },
                            onTapFunction: () {
                          // setState(() {
                          //   currentPosition = lastPosition;
                          // });
                        }),

                        getVerSpace(20.h),

                        // Row(
                        //   children: [
                        //
                        //     Container(
                        //       decoration: getDefaultDecorationWithBorder(
                        //           radius: getDefaultRadius(),
                        //           borderColor: getSubFontColor(context),
                        //           borderWidth: 0.4),
                        //       child: CountryPickerDropdown(
                        //         // onInit: (code){
                        //         //
                        //         //       countryCode = code!.dialCode!;
                        //         //
                        //         // },
                        //         // onChanged: (value) {
                        //         //   countryCode = value.dialCode!;
                        //         //
                        //         // },
                        //         // initialSelection: 'IN',
                        //         // favorite: ['+91','IN'],
                        //         // backgroundColor: Colors.transparent,
                        //         // dialogBackgroundColor: getBackgroundColor(context),
                        //         // dialogTextStyle: TextStyle(
                        //         //   fontFamily: fontFamily,
                        //         //   fontWeight: FontWeight.w600,
                        //         //   fontSize: FetchPixels.getPixelHeight(35)
                        //         // ),
                        //         //
                        //         // dialogSize: Size(FetchPixels.getWidthPercentSize(80),FetchPixels.getHeightPercentSize(60)),
                        //         // searchDecoration: InputDecoration(
                        //         //   contentPadding: EdgeInsets.zero,
                        //         //   border: OutlineInputBorder(borderSide: BorderSide(
                        //         //     width: 0.3,
                        //         //     color: getFontColor(context)
                        //         //   )),
                        //         //
                        //         //   ),
                        //         //
                        //         //
                        //         //
                        //         // showCountryOnly: false,
                        //         // showOnlyCountryWhenClosed: false,
                        //         // alignLeft: false,
                        //         // closeIcon: Icon(Icons.close,color: getFontColor(context),
                        //         // size: FetchPixels.getPixelHeight(50),),
                        //
                        //         initialValue: 'IN',
                        //         itemBuilder: (country) {
                        //           return Container(
                        //               child: Row(
                        //                 children: <Widget>[
                        //                   SizedBox(
                        //                     width: 8.0,
                        //                   ),
                        //                   CountryPickerUtils.getDefaultFlagImage(country),
                        //                   SizedBox(
                        //                     width: 8.0,
                        //                   ),
                        //                   Text("+${country.phoneCode}(${country.isoCode})"),
                        //                 ],
                        //               ));
                        //         },
                        //
                        //
                        //         // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                        //         // priorityList:[
                        //         //   CountryPickerUtils.getCountryByIsoCode('GB'),
                        //         //   CountryPickerUtils.getCountryByIsoCode('CN'),
                        //         // ],
                        //         // sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
                        //         onValuePicked: (value) {
                        //           countryCode = value.phoneCode;
                        //         },
                        //       ),
                        //     ),
                        //     getHorizontalSpace(30),
                        //
                        //     Expanded(child:  getDefaultTextFiledWidget(
                        //         context, "Phone Number", emailController,inputType:TextInputType.phone,
                        //       inputFormatters:   <TextInputFormatter>[
                        //         FilteringTextInputFormatter.digitsOnly
                        //         ],focus: (currentPosition==phonePosition),onTapFunction: (){
                        //       setState((){
                        //         currentPosition=phonePosition;
                        //       });
                        //     }
                        //     ),)
                        //   ],
                        // ),
                        //
                        // getVerSpace(FetchPixels.getPixelHeight(40)),
                        getPasswordTextFiledWidget(
                            context,
                            "Password",
                            passwordController,
                            // focus: (currentPosition == passPosition),

                            validator: (pass1) {
                              if (isPasswordValid(pass1)) return null;
                              else if(pass1.length < 6) return "Password must be 6 character long";
                              else
                                return 'Enter a valid password';
                            },

                            onTapFunction: () {
                              // setState(() {
                              //   currentPosition = passPosition;
                              // });
                            },
                            ),
                        getVerSpace(20.h),
                        getPasswordTextFiledWidget(
                            context,
                            "Confirm Password",
                            confirmPasswordController,
                            // focus: (currentPosition == confirmPosition),
                            validator: (pass) {
                              if(pass.isEmpty) return "Enter a valid password";
                              else if (passwordController.text == confirmPasswordController.text) return null;

                              else
                                return 'Password not match';
                            },
                            onTapFunction: () {
                              // setState(() {
                              //   currentPosition = confirmPosition;
                              // });
                            },
                            ),
                      ],
                    )),
                getVerSpace(48.h),

                getCustomButton(
                  "Sign Up",
                  () {


                    // Get.to(VerificationPage(phone: "kevadiyahemanshi.dream@gmail.com",));

                    if (userKey.currentState!.validate()) {
                      _register();
                    }

                    // checkValidation();
                  },
                ),

                // getButtonWidget(
                //   context,
                //   '',
                //   () async{
                //
                //
                //
                //   },
                //   horizontalSpace: 0,
                //   verticalSpace: FetchPixels.getPixelHeight(80),
                // ),
                getVerSpace(32.h),
                getCommonOtherWidget(
                    context: context,
                    s1: 'Already have an account?',
                    s2: 'Log In',
                    function: () {
                      Constant.backToFinish();
                    })
              ],
            ),
          ),
        ));
  }

  // checkValidation() {
  //   if (isNotEmpty(usernameController.text) &&
  //       isNotEmpty(emailController.text)) {
  //     if (isValidEmail(emailController.text)) {
  //       if (isNotEmpty(passwordController.text) &&
  //           isNotEmpty(confirmPasswordController.text)) {
  //         if ((passwordController.text.length >= 6) &&
  //             confirmPasswordController.text.length >= 6) {
  //           if (passwordController.text == confirmPasswordController.text) {
  //             _register();
  //           } else {
  //             showCustomToast(message: 'Password does not match');
  //           }
  //         } else {
  //           showCustomToast(
  //               message: 'You must have 6 characters in your password');
  //         }
  //       } else {
  //         showCustomToast(message: 'Enter password');
  //       }
  //     } else {
  //       showCustomToast(message: 'Email not valid');
  //     }
  //   } else {
  //     showCustomToast(message: 'Fill details');
  //   }
  // }



  void _register() async {

    String gmail="patoliyapriyanshi.dream@gmail.com";


    print("log===${emailController.text.trim()==gmail}");
    bool isAlreadyRegister = await LoginData.userAlreadyRegister(context,
        phoneNumber: emailController.text.trim(),
        password: passwordController.text,
        loginController: widget.loginController);

    if (!mounted) {
      return;
    }



    if (isAlreadyRegister) {
      showCustomToast(message: 'User already register..');
    } else {

      Get.to(VerificationPage(
          phone: emailController.text,
          isSignUp: true,
          onVerify: (context1) async {
            LoginData.createUser(
                context: context,
                username: usernameController.text,
                email: emailController.text,
                password: passwordController.text,
                function: () async {
                  bool isLogin = await LoginData.login(context,
                      phoneNumber: emailController.text,
                      password: passwordController.text,
                      loginController: widget.loginController);

                  widget.loginController.changeData(isLogin);

                  print("isLogin--------${isLogin}");

                  if (isLogin) {
                    LoginController loginController = Get.find();
                    loginController.isVerifyLoading(false);


                    print("v---------${loginController.isVerifyLoading.value}");

                    showCommonDialog(
                        widget:
                            CreateAccountDialog(clickListener: (context) async {
                          final token =
                              await FirebaseMessaging.instance.getToken();

                          print("token-----${token.toString()}");

                          FireBaseData.addToken(token ?? "");

                          await FireBaseData.getAppDetail();
                          // Navigator.push(context, MaterialPageRoute(builder: (
                          //     context) => HomeScreen(),));
                        }),
                        context: context);

                  }
                });

          }));
    }
  }

// void _register() async{
//
//   bool isAlreadyRegister = await  LoginData.userAlreadyRegister(email: emailController.text);
//
//   print("isAlreadyRegister-----------$isAlreadyRegister");
//
//
//
//   if(isAlreadyRegister){
//     showCustomToast(message: 'User already register..');
//   }else{
//
//     showCommonDialog(
//         widget: CreateAccountDialog(clickListener: (context) async {
//
//           LoginData.createUser(username: usernameController.text,
//               email: emailController.text,
//               password: passwordController.text,
//               function: () {});
//
//           bool isLogin = await LoginData.login(
//               phoneNumber: emailController.text,
//               password: passwordController.text,loginController: widget.loginController);
//
//           widget.loginController.changeData(isLogin,);
//
//
//           Get.off(HomeScreen());
//           // Constant.sendToNext(context, Routes.homeRoute);
//
//         }),
//         context: context);
//
//
//
//     // pushPage(
//     //     VerificationPage(phone: countryCode+emailController.text,isSignUp: true,onVerify: () async {
//     //
//     //   LoginData.createUser(firstName: firstNameController.text,
//     //       lastName: lastNameController.text,
//     //       phoneNumber: countryCode + emailController.text,
//     //       password: passwordController.text,
//     //       function: () {});
//     //
//     //   bool isLogin = await LoginData.login(
//     //       phoneNumber: countryCode + emailController.text,
//     //       password: passwordController.text,loginController: widget.loginController);
//     //
//     //   widget.loginController.changeData(isLogin);
//     //
//     //
//     // }),function: (value){
//     //   backPage();
//     //   backPage();
//     // });
//
//   }
//
//
// }
//
}
