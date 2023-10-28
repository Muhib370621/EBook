
import 'package:ebook_app/ads/AdsFile.dart';
import 'package:ebook_app/utils/theme_data.dart';
import 'package:ebook_app/view/login/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/login_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';
import 'login_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreen createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> with TickerProviderStateMixin {
  // final formKey = GlobalKey<FormState>();
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  String countryCode = "IN";
  bool isLogin = false;

  Future<bool> _requestPop() {
    // Constant.backToFinish();
    Constant.closeApp();

    return Future.value(false);
  }

  // ignore: unused_field
  RxBool _isObscureText = true.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginController loginController = Get.put(LoginController());
  int currentPosition = -1;
  int emailPosition = 1;
  int passPosition = 2;
  var animationStatus = 0;

  // ButtonState stateTextWithIconMinWidthState = ButtonState.idle;

  AnimationController? _loginButtonController;



  AdsFile adsFile = AdsFile();
  @override
  void initState() {
    super.initState();

    loginController.isLoading(false);
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
  }

  finish() {
    Constant.backToFinish();
  }

  RxString? emailErrorText;
  String passErrorText = "";

  @override
  void dispose() {
    _loginButtonController!.dispose();
    super.dispose();
  }
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {



    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: getLoginBackgroundColor(context),
          // backgroundColor: context.theme.scaffoldBackgroundColor,
          // appBar: getNoneAppBar(context),
          appBar: getCommonLoginAppBar(context,title: "Login"),
          body: SafeArea(
            child: Container(
              color: Get.isDarkMode?Colors.black:Colors.white,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                horizontal: 20.h),
                children: [

              // getVerSpace(64.h),

                  getVerSpace(30.h),

              getCustomFont("Welcome back to the E-book Reader", 16.sp, context.theme.primaryColor, 1,
                  fontWeight: FontWeight.w400, textAlign: TextAlign.center),

                  getVerSpace(32.h),



              // getVerSpace(FetchPixels.getPixelHeight(40)),

                  Form(
                    key: formGlobalKey,
                      child: Column(
                    children: [
                      getDefaultTextFiledWidget(
                        context, "Email Address", emailController,
                        validator: (email) {
                          if (isValidEmail(email)) return null;
                          else
                            return 'Enter a valid email address';
                        },
                      ),
                      getVerSpace(20.h),
                      getPasswordTextFiledWidget(
                          context,
                          "Password",
                          passwordController,
                          validator: (pass) {
                            if (pass.length >= 6) return null;
                            else
                              return 'Enter a valid Password';
                          },

                          ),
                      getVerSpace(15.h),
                      InkWell(
                        onTap: () {

                          // Get.to(ForgotPasswordScreen());

                          Constant.sendToNext(context, Routes.forgotScreen);
                          // pushPage(ForgotPasswordPage());
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: getCustomFont(
                              'Forgot Password?', 16.sp, context.theme.primaryColor, 1,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.end),
                        ),
                      ),

                      getVerSpace(56.h),

                      Obx(() => getCustomButton(
                          isProgress: loginController.isLoading.value,
                          "Log In", () {

                            if(!loginController.isLoading.value){

                              if (formGlobalKey.currentState!.validate()) {
                                loginController.isLoading(true);
                                checkValidation();
                              }

                            }

                      },context: context)),

                    ],
                  )),



              getVerSpace(32.h),

              getCommonOtherWidget(
                  context: context,
                  s1: 'Don\'t have an account?',
                  s2: 'Sign Up',
                  function: () {
                    Constant.sendToNextWithResult(
                      context,
                        SignUpScreen(
                          loginController: loginController,
                        ),
                          (){});
                    passwordController.text = '';
                    emailController.text = '';
                  }),
                  getVerSpace(20.h),
                ],
              ),
            ),
          ),
        ));
  }

  checkValidation() {
    _login();
  }


  void _login() async {


    bool isLogin = await LoginData.login(
        context,
        phoneNumber: emailController.text,
        password: passwordController.text,loginController: loginController);

    if (isLogin) {

      Future.delayed(const Duration(seconds: 1), () {
        Future.delayed(const Duration(seconds: 1), () {
          loginController.changeData(true);
          loginController.isLoading(false);
          Constant.sendToNext(context, Routes.homeMainScreenRoute);
          // Constant.backToFinish(context);
          showCustomToast(message: 'Login successfully');
        });
      });
    }


  }
}
