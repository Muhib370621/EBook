
import 'package:auth_handler/auth_handler.dart';
import 'package:ebook_app/utils/color_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../../controller/login_controller.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import '../../utils/theme_data.dart';
import '../slider_option_class/dashboard_screen.dart';

class VerificationPage extends StatefulWidget {
final String? phone;
final bool? isSignUp;
final bool? isForgot;
final Function? onVerify;
    const VerificationPage({super.key, this.phone,this.isSignUp,this.onVerify,this.isForgot});
  @override
  State<VerificationPage> createState() {
    return _VerificationPage();
  }
}

class _VerificationPage extends State<VerificationPage> {


  Future<bool> _requestPop() {
    Navigator.of(context).pop();

    return Future.value(false);
  }

  void sendOTP() async {


    authHandler.config(
      otpLength: 6
    );

    authHandler.sendOtp(widget.phone!);


    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   verificationFailed: (FirebaseAuthException e) {
    //
    //
    //     print("eCode===${e.code}===${widget.phone}");
    //     if (e.code == 'invalid-phone-number') {
    //     }
    //
    //   },
    //   verificationCompleted: (PhoneAuthCredential credential) async {
    //
    //   },
    //   codeSent: (String? id, int? resendToken) async {
    //     verificationId= id!;
    //
    //     print("aend===true");
    //   },
    //   phoneNumber: widget.phone!,
    //
    //
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //
    //   },
    // );

  }

  AuthHandler authHandler = AuthHandler();

  String verificationId='';
  @override
  void initState() {
    super.initState();


    print("email------_${widget.phone}");

    loginController.isVerifyLoading.value = false;

    Future.delayed(Duration.zero,(){
      sendOTP();


    });


  }


  void _signInWithPhoneNumber(String smsCode) async {

    bool i = await authHandler.verifyOtp(_pinEditingController.text);

    if(i){

      // if(widget.onVerify != null){
        widget.onVerify!(context);
      // }


      Future.delayed(const Duration(seconds: 0),(){
        print("isVerify--------${loginController.isVerifyLoading}");
        // Navigator.of(context).pop();
      });

    }else{

      loginController.isVerifyLoading(false);
      showCustomToast( message: "Invalid OTP");
    }


  }

  LoginController loginController = Get.put(LoginController());

  final GlobalKey<FormFieldState<String>> _formKey =
  GlobalKey<FormFieldState<String>>(debugLabel: '_formkey');
  final TextEditingController _pinEditingController = TextEditingController(text: '');
  final bool _enable = true;

  @override
  Widget build(BuildContext context) {

    // FetchPixels(context);

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: getLoginBackgroundColor(context),
          // backgroundColor: context.theme.scaffoldBackgroundColor,
          // appBar: getInVisibleAppBar(),
          appBar: getCommonLoginAppBar(context,title: "Verify",withLeading: true,onTap: (){
            backClick();
          }),

          body: SafeArea(
            child: Column(
              children: [

                Expanded(
                    child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.h),
                  children: [
                    getVerSpace(30.h),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: GestureDetector(onTap: (){
                    //     _requestPop();
                    //   },child: Icon(Icons.arrow_back,color: context.theme.primaryColor,size: 20.h)),
                    // ),
                    //
                    // getVerSpace(10.h),
                    //
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


                    getCustomFont("Please enter the code sent to your email\n${widget.phone}", 16.sp, context.theme.primaryColor, 3,
                        fontWeight: FontWeight.w400, textAlign: TextAlign.center),

                    // getCustomFont("Verify", 30, context.theme.primaryColor, 1,
                    //     fontWeight: FontWeight.w700, textAlign: TextAlign.center),
                    // getCustomFont(
                    //     'Please enter the code sent to your\nemail',
                    //     15.sp,
                    //     context.theme.primaryColor,
                    //     2,
                    //     fontWeight: FontWeight.w400,
                    //     textAlign: TextAlign.center),
                    // getVerSpace(10.h),

                    getVerSpace(40.h),

                    Container(
                      height: 55.h,
                      margin: EdgeInsets.only(
                          top:
                          20.h),
                      child: PinInputTextFormField(
                        key: _formKey,
                        pinLength: 6,
                        decoration: BoxLooseDecoration(
                          textStyle: TextStyle(
                              color: context.theme.primaryColor,
                              fontFamily: Constant.fontsFamily,
                              fontSize:
                              20.sp,
                              fontWeight: FontWeight.w700),

                          radius: Radius.circular(
                              15.r),
                          strokeWidth: 0.4,
                          strokeColorBuilder:
                          PinListenColorBuilder(grey, grey,),
                          obscureStyle: ObscureStyle(
                            isTextObscure: false,
                            obscureText: '🤪',
                          ),
                        ),
                        controller: _pinEditingController,
                        textInputAction: TextInputAction.go,
                        enabled: _enable,
                        keyboardType: TextInputType.number,

                        textCapitalization: TextCapitalization.characters,
                        onSubmit: (pin) {

                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                        },
                        onChanged: (pin) {
                          setState(() {

                          });
                        },
                        onSaved: (pin) {

                        },
                        validator: (pin) {
                          if (pin!.isEmpty) {
                            setState(() {

                            });
                            return 'Pin cannot empty.';
                          }
                          setState(() {

                          });
                          return null;
                        },
                        cursor: Cursor(
                          width: 2,
                          color: context.theme.primaryColor,
                          radius: const Radius.circular(1),
                          enabled: true,
                        ),
                      ),
                    ),

                    getVerSpace(48.h),

                    Obx(() => getCustomButton(

                      'Verify',
                          () async {

                        if(!loginController.isVerifyLoading.value){

                          print("called-----verify");

                          loginController.isVerifyLoading(true);

                          if(_pinEditingController.text.isEmpty){
                            loginController.isVerifyLoading(false);
                            showCustomToast(message: "Please enter pin");
                          }else {

                            // if(widget.isForgot!){
                            //
                            //   Constant.sendToNextWithResult(context, ResetPasswordScreen(), (){});
                            //
                            // }else{

                            _signInWithPhoneNumber(_pinEditingController.text);

                            // }

                          }
                        }


                      },isProgress: loginController.isVerifyLoading.value,context: context,

                      weight: FontWeight.w600,
                    )),

                    getVerSpace(32.h),
                    getCommonOtherWidget(
                        context: context,
                        s1: 'Don\'t receive code?',
                        s2: 'Resend',
                        function: () {
                          _pinEditingController.text='';
                          setState((){});

                          Future.delayed(const Duration(seconds: 1),(){ sendOTP();});

                        })
                  ],
                ))

              ],
            ),
          ),
        ));
  }


}
