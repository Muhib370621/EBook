import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../controller/login_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class CreateAccountDialog extends StatefulWidget {
  final Function clickListener;

  CreateAccountDialog({required this.clickListener});

  @override
  _CreateAccountDialog createState() => _CreateAccountDialog();
}

class _CreateAccountDialog extends State<CreateAccountDialog> {
  TextEditingController textEditingController = TextEditingController();

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double radius = 10.r;


    return WillPopScope(
      onWillPop: () async {


        HomeMainScreenController controller = Get.find();

        controller.index.value = 2;

        loginController.logout();

        Constant.sendToNext(context, Routes.loginScreen);


        return false;

      },
      child: StatefulBuilder(
        builder: (context, setState) {
          return Dialog(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            elevation: 0.0,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: Container(
              // height: height,
              // width: width,
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              padding: EdgeInsets.all(20.h),
              decoration: BoxDecoration(
                color: context.theme.focusColor,
                borderRadius: BorderRadius.circular(radius)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  getVerSpace(20.h),

                  getCustomFont('Account Created',
                      25, context.theme.primaryColor, 1,
                      fontWeight: FontWeight.w700),
                  getVerSpace(20.h),

                  getSvgImage("done.svg",height: 110.h,width: 110.h),

                  getVerSpace(20.h),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 20.h),
                    child: getCustomFont(
                        'Your account has been successfully created!',
                        18,
                        context.theme.primaryColor,
                        2,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center),
                  ),

                  getVerSpace(40.h),

                  getCustomButton("Ok", () {
                        widget.clickListener(context);
                          Constant.backToFinish();

                          Constant.sendToNext(context, Routes.homeMainScreenRoute);
                      },),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
