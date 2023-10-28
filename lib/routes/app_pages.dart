import 'package:ebook_app/view/login/password_changed_screen.dart';
import 'package:ebook_app/view/more_tab/all_redable_book_screen.dart';
import 'package:ebook_app/view/profile/edit_profile_screen.dart';
import 'package:ebook_app/view/profile/my_profile_screen.dart';
import 'package:ebook_app/view/slider_option_class/authors_screen.dart';
import 'package:ebook_app/view/slider_option_class/categories_screen.dart';
import 'package:ebook_app/view/slider_option_class/home_slider_screen.dart';
import 'package:ebook_app/view/slider_option_class/send_notification.dart';
import 'package:ebook_app/view/slider_option_class/setting_screen.dart';
import 'package:flutter/material.dart';
import '../view/category_tab/category_tab.dart';
import '../view/home_main_screen/home_main_screen.dart';
import '../view/home_tab/home_tab.dart';
import '../view/home_tab/popular_book_screen.dart';
import '../view/home_tab/search_screen.dart';
import '../view/home_tab/top_authors/othor_review_screen.dart';
import '../view/home_tab/top_authors/top_authors_screen.dart';
import '../view/home_tab/trending_books/trending_book_screen.dart';
import '../view/intro_screen/intro_screen.dart';
import '../view/login/forgot_password_page.dart';
import '../view/login/login_screen.dart';
import '../view/more_tab/aboute_us_screen.dart';
import '../view/more_tab/feedback_screen.dart';
import '../view/more_tab/more_tab.dart';
import '../view/more_tab/terms_and_condition_screen.dart';
import '../view/notification_tab/notification_tab.dart';
import '../view/save_tab/saved_tab.dart';
import '../view/slider_option_class/add_new_category_screen.dart';
import '../view/slider_option_class/category_edit_screen.dart';
import '../view/slider_option_class/dashboard_screen.dart';
import '../view/slider_option_class/stories_screen.dart';
import '../view/splsh_screen/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.splashRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.splashRoute: (context) => SplashScreen(),
    Routes.introRoute: (context) => IntroScreen(),
    Routes.homeMainScreenRoute: (context) => HomeMainScreen(),
    Routes.homeTabRoute: (context) => HomeTab(),
    Routes.categoryTabRoute: (context) => CategoryTab(),
    Routes.saveTabRoute: (context) => SaveTab(),
    Routes.bookMarkRoute: (context) => AllReadBookScreen(),
    Routes.notificationTabRoute: (context) => NotificationTab(),
    Routes.moreTabRoute: (context) => MoreTab(),
   Routes.trendindBookScreenRoute:(context)=>TrenDingBookScreen(),
    Routes.topAuthorsScreenRoute:(context)=>TopAuthorsScreen(),
    Routes.populerBookScreenRoute:(context)=>PopulerBookScreen(),
    // Routes.trendingBookDetailScreenRoute:(context)=>TrendingBookDetailScreen(),
    // Routes.subscriptionScreenRoute:(context)=>SubscriptionScreen(),
    // Routes.readBookScreenRoute:(context)=>ReadBookScreen(),
    // Routes.topOuthorDetailScreenRoute:(context)=>TopAuthorDetailScreen(),
    Routes.searchScreenRoute:(context)=>SearchScreen(),
    Routes.feedBackScreenRoute:(context)=>FeedBackScreen(),
    // Routes.populerBookDetailScreenRoute:(context)=>PopularBookDetailScreen(),
    Routes.termsAndConditionScreenRoute:(context)=>TermsAndConditionScreen(),
    Routes.aboutUsScreenRoute:(context)=>AboutUsScreen(),
    Routes.myProfileScreenRoute:(context)=>MyProfileScreen(),
    Routes.editProfileScreenRoute:(context)=>EditProfileScreen(),
    Routes.othorReviewsScreenRoute:(context)=>OthorReviewsScreen(),
    Routes.dashboardScreenRoute:(context)=>DashboardScreen(),
    // ignore: equal_keys_in_map
    Routes.othorReviewsScreenRoute:(context)=>OthorReviewsScreen(),
    Routes.categoriesScreenRoute:(context)=>CategoriesScreen(),
    Routes.storiesScreenRoute:(context)=>StoriesScreen(),
    Routes.homeSliderScreenRoute:(context)=>HomeSliderScreen(),
    Routes.authorScreenRoute:(context)=>AuthorScreen(),
    Routes.sendNotificationScreenRoute:(context)=>SendNotificationScreen(),
    Routes.settingScreenRoute:(context)=>SettingScreen(),
    Routes.editCategoriesScreenRoute:(context)=>EditCategoriesScreen(),
    Routes.addNewCategoryScreenRoute:(context)=>AddNewCategoryScreen(),
    Routes.loginScreen: (context) => LoginScreen(),
    Routes.changedPassScreen: (context) => PasswordChangedScreen(),
    Routes.forgotScreen: (context) => ForgotPasswordScreen()
  };
}
