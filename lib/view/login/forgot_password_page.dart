import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../../utils/theme_data.dart';
import '../slider_option_class/dashboard_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreen createState() {
    return _ForgotPasswordScreen();
  }
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  Future<bool> _requestPop() {
    Constant.backToFinish();

    return Future.value(false);
  }
  String countryCode = "IN";
  TextEditingController emailController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: getLoginBackgroundColor(context),
          // backgroundColor: context.theme.scaffoldBackgroundColor,
          // appBar: getNoneAppBar(context),

          appBar: getCommonLoginAppBar(context,title: "Forgot password",withLeading: true,onTap: (){
            backClick();
          }),

          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(
              horizontal: 20.h),
              children: [

                getVerSpace(40.h),

                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: GestureDetector(onTap: (){
                //     _requestPop();
                //   },child: Icon(Icons.arrow_back,color: context.theme.primaryColor,size: 20.h)),
                // ),
                //
                // getVerSpace(10.h),
                // Container(
                //   alignment: Alignment.center,
                //   child: Container(
                //       height: 120.h,
                //       width: 120.h,
                //       child: getSvgImage("logo_ebook.svg",
                //         height: double.infinity,)),
                // ),
                //
                // getVerSpace(10.h),

                getCustomFont("Please enter the email address you used to \ncreate your account, & we’ll send you a link to \nreset your password.", 16.sp, context.theme.primaryColor, 3,
                    fontWeight: FontWeight.w400, textAlign: TextAlign.center),

                getVerSpace(32.h),

                Form(
                  key: key,
                  child: getDefaultTextFiledWidget(
                    context, "email Address", emailController,
                    // focus: true,
                      validator: (email) {
                        if (isValidEmail(email)) return null;
                        // else if(email.isEmpty) return "Please Enter Email";
                        else
                          return 'Enter a valid email address';
                      },
                    onTapFunction: () {
                      // setState(() {
                      //   currentPosition = emailPosition;
                      // });
                    }),),

                getVerSpace(32.h),





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
            //         //   countryCode = code!.dialCode!;
            //         //   // });
            //         //   // }
            //         // },
            //         // onChanged: (value) {
            //         //   countryCode = value.dialCode!;
            //         //
            //         //
            //         // },
            //         // initialSelection: 'IN',
            //         // favorite: ['+91','IN'],
            //         // backgroundColor: Colors.transparent,
            //         // dialogBackgroundColor: getBackgroundColor(context),
            //         // dialogTextStyle: TextStyle(
            //         //     fontFamily: fontFamily,
            //         //     fontWeight: FontWeight.w600,
            //         //     fontSize: FetchPixels.getPixelHeight(35)
            //         // ),
            //         //
            //         // dialogSize: Size(FetchPixels.getWidthPercentSize(80),FetchPixels.getHeightPercentSize(60)),
            //         // searchDecoration: InputDecoration(
            //         //   contentPadding: EdgeInsets.zero,
            //         //   border: OutlineInputBorder(borderSide: BorderSide(
            //         //       width: 0.3,
            //         //       color: getFontColor(context)
            //         //   )),
            //         //
            //         // ),
            //         //
            //         //
            //         //
            //         // showCountryOnly: false,
            //         // showOnlyCountryWhenClosed: false,
            //         // alignLeft: false,
            //         // closeIcon: Icon(Icons.close,color: getFontColor(context),
            //         //   size: FetchPixels.getPixelHeight(50),),
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
            //       context, "Phone Number", emailController,inputType:TextInputType.phone,
            //       inputFormatters: <TextInputFormatter>[
            //         FilteringTextInputFormatter.digitsOnly
            //       ],
            //       focus: true
            //     ),)
            //   ],
            // ),

                getCustomButton("Submit", () async {


                  if(key.currentState!.validate()){


                    FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text) .then((value) {
                      Constant.backToFinish();

                      showCustomToast(
                          message: "We have sent you instructions to reset your password!");
                    })
                        .catchError(
                            (e) {

                        });
                    // Constant.sendToNextWithResult(context, VerificationPage(phone: emailController.text,isForgot: true,), (){});
                  }

                      // if(isNotEmpty(emailController.text)){
                      //
                      //
                      //
                      //
                      //   FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text) .then((value) {
                      //     Constant.backToFinish();
                      //
                      //     showCustomToast(
                      //         message: "We have sent you instructions to reset your password!");
                      //   })
                      //       .catchError(
                      //           (e) {
                      //
                      //       });
                      //
                      // }else{
                      //   showCustomToast(message: 'Enter your email');
                      // }

                    }),

                getVerSpace(20.h),
              ],
            ),
          ),
        ));
  }
}
