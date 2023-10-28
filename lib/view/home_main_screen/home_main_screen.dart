import 'package:ebook_app/view/category_tab/category_tab.dart';
import 'package:ebook_app/view/home_tab/home_tab.dart';
import 'package:ebook_app/view/more_tab/more_tab.dart';
import 'package:ebook_app/view/quick_read_tab/quick_read_tab.dart';
import 'package:ebook_app/view/save_tab/saved_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../datafile/datafile.dart';
import '../../models/bottom_appbar_model.dart';
import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {


  HomeMainScreenController homeMainScreenController =
      Get.put(HomeMainScreenController());
  List<ModelBottom> bottomLists = DataFile.getBottomAppBar();

  // static final List<Widget> sliderClass = <Widget>[
  //   const DashboardScreen(),
  //   const CategoriesScreen(),
  //   const StoriesScreen(),
  //   const BooksScreen(),
  //   const HomeSliderScreen(),
  //   const AuthorScreen(),
  //   const SendNotificationScreen(),
  //   const SettingScreen(),
  // ];

  static final List<Widget> _widgetOptions = <Widget>[
    const QuickReadTabScreen(),
    // const SaveTab(),
    const CategoryTab(),
    const HomeTab(),
    const SaveTab(),
    // const FavouriteTab(),
    // const NotificationTab(),
    const MoreTab(),
  ];


  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return GetBuilder<HomeMainScreenController>(
      init: HomeMainScreenController(),
      builder: (homeMainScreenController) => getDefaultWidget(Scaffold(
        // key: homeMainScreenController.scaffoldKey,
        // drawer: Drawer(
        //   backgroundColor: context.theme.focusColor,
        //   child: SafeArea(
        //     child: Column(
        //       children: [
        //         getCustomFont("Stories", 26.sp, maximumOrange, 1,
        //             fontWeight: FontWeight.w700),
        //         getVerSpace(30.h),
        //         Expanded(
        //           child: Container(
        //             child: ListView.builder(
        //               physics: BouncingScrollPhysics(),
        //               itemCount: sliderData.length,
        //               itemBuilder: (context, index) {
        //                 SliderData slider = sliderData[index];
        //                 return GestureDetector(
        //                   onTap: () {
        //                     homeMainScreenController
        //                         .onSetSelectSliderOption(slider.id);
        //                     Get.to(sliderClass[index]);
        //                   },
        //                   child: Container(
        //                       width: double.infinity,
        //                       decoration:  homeMainScreenController
        //                           .selectedOption ==
        //                           sliderData[index].id?BoxDecoration(
        //                           borderRadius: BorderRadius.only(
        //                               topLeft: Radius.circular(16.h),
        //                               bottomLeft: Radius.circular(16.h)),
        //                           color: Color(0XFFFFF1EE)):BoxDecoration(color: context.theme.focusColor),
        //                       child: Row(
        //                         children: [
        //                           getSvgImage(homeMainScreenController.selectedOption==slider.id?slider.selectIcon!:slider.unSelectIcon!,
        //                               height: 24.h, width: 24.h),
        //                           getHorSpace(12.h),
        //                           getCustomFont(slider.name!, 15.sp, grey, 1,
        //                               fontWeight: FontWeight.w500,
        //                               txtHeight: 1.5.h),
        //                         ],
        //                       ).paddingOnly(
        //                           left: 15.h,
        //                           top: homeMainScreenController
        //                                       .selectedOption ==
        //                                   sliderData[index].id
        //                               ? 15.h
        //                               : 0.h,
        //                           bottom: homeMainScreenController
        //                                       .selectedOption ==
        //                                   sliderData[index].id
        //                               ? 15.h
        //                               : 0.h)),
        //                 ).paddingOnly(top: homeMainScreenController.selectedOption==sliderData[index].id?11.h:15.h,bottom:homeMainScreenController.selectedOption==sliderData[index].id?11.h:15.h,);
        //               },
        //             ),
        //           ).paddingOnly(left: 15.h),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        backgroundColor: context.theme.scaffoldBackgroundColor,
        //backgroundColor: bgColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.h),
                    topLeft: Radius.circular(16.h)),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, -4),
                      blurRadius: 12,
                      color: regularBlack.withOpacity(0.04))
                ],
                color: regularWhite),
            child: buildBottomNavigation(homeMainScreenController)),
        body: SafeArea(
          child: PageStorage(
            bucket: bucket,
            child: GetX<HomeMainScreenController>(
              init: HomeMainScreenController(),
              builder: (homeMainScreenController) =>
              _widgetOptions[homeMainScreenController.index.value],
            ),
          ),
        ),
      )),
    );
  }


  final PageStorageBucket bucket = PageStorageBucket();

  BottomNavigationBar buildBottomNavigation(
      HomeMainScreenController controller) {
    return BottomNavigationBar(

      onTap: (value) {
        controller.onChange(value.obs);
      },

      currentIndex: controller.index.value,
      elevation: 0,
      showUnselectedLabels: false,
      backgroundColor: Colors.red.withAlpha(80),
      selectedItemColor: maximumOrange,
      selectedFontSize: 16.sp,
      selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600, color: maximumOrange, fontSize: 16.sp),
      items: [

        BottomNavigationBarItem(
            label: "Recent",
            icon: getSvgImage("book.svg", height: 24.h, width: 24.w),
            activeIcon: getSvgImage("book_active.svg", height: 24.h, width: 24.w)),

        // BottomNavigationBarItem(
        //     label: "Save",
        //     icon: getSvgImage("saveIcon.svg", height: 24.h, width: 24.w),
        //     activeIcon:
        //         getSvgImage("saveBoldIcon.svg", height: 24.h, width: 24.w)),

        BottomNavigationBarItem(
            label: "Category",
            icon: getSvgImage("categoryIcon.svg", height: 24.h, width: 24.w),
            activeIcon: getSvgImage("categoryFillIcon.svg", height: 24.h, width: 24.w)),


        BottomNavigationBarItem(
          label: "Home",
          icon: getSvgImage("homeIcon.svg", height: 24.h, width: 24.w),
          activeIcon: getSvgImage("home_bold.svg", height: 24.h, width: 24.w),
        ),



        BottomNavigationBarItem(
            label: "Save",
            icon: getSvgImage("saveIcon.svg", height: 24.h, width: 24.w),
            activeIcon:
                getSvgImage("saveBoldIcon.svg", height: 24.h, width: 24.w)),


        // BottomNavigationBarItem(
        //     label: "Favourite",
        //     icon: getSvgImage("heartIcon.svg", height: 24.h, width: 24.w),
        //     activeIcon: getSvgImage("active_heart.svg",
        //         height: 24.h, width: 24.w)),

        BottomNavigationBarItem(
            label: "More",
            icon: getSvgImage("Profile.svg", height: 24.h, width: 24.w),
            activeIcon: getSvgImage("Profile_active.svg", height: 24.h, width: 24.w)),
      ],
    );
  }
}
