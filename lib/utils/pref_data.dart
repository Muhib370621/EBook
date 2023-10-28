import 'package:shared_preferences/shared_preferences.dart';

import '../controller/login_controller.dart';

class PrefData {
  static String prefName = "com.example.ebook_app";

  static String isIntro = "${prefName}isIntro";
  static String isDetailed = "${prefName}isDetailed";
  static String homeScreen = "${prefName}homeScreen";
  static String pdfUrl = "${prefName}url";
  static String bannerId = "${prefName}banner";
  static String iosBannerId = "${prefName}iosBanner";

  static String interstitialId = "${prefName}interstitial";
  static String iosInterstitialId = "${prefName}iosInterstitial";
  static String recentRead = "${prefName}recentRead";
  static String recentReadName = "${prefName}recentReadName";
  static String appIcon = "${prefName}appIcon";
  // static String storyId = "${prefName}storyId";
  static String storyId = "${prefName}notificationStory";
  static String link = "${prefName}link";
  static String isBack = "${prefName}isBack";
  static String inForeground = "${prefName}inForeground";




  static setIsBack(bool sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isBack, sizes);
  }


  static getIsBack() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isBack) ?? false;
  }


    static Future<void>  setStoryId(String sizes) async {

      print("string---------${sizes}");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(storyId, sizes);
    }


    static getStoryId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(storyId) ?? "";
    }

    static setLink(String sizes) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(link, sizes);
    }


    static getLink() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(link) ?? "";
    }




  static Future<bool> getInForeground() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(inForeground) ?? false;
    return value;
  }

  static setInForeground(bool sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(inForeground, sizes);
  }



  static Future<String>  getUserId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String id = prefs.getString(LoginController.keyCurrentUser) ?? '';

    return id;

  }


  static Future<bool>  getLogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool id = prefs.getBool(LoginController.keyLogin) ?? false;

    return id;

  }

  static setIsIntro(bool sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isIntro, sizes);
  }

  static getIsIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(isIntro) ?? true;
    return intValue;
  }

  static setIsDetailed(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isDetailed, isFav);
  }

  static getIsDetailed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isDetailed) ?? true;
  }

  static setIsHome(bool home)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(homeScreen, home);
  }

  static getIsHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(homeScreen) ?? true;
  }

  static setBannerId(String id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(bannerId, id);
  }

  static setIosBannerId(String id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(iosBannerId, id);
  }

  static getBannerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(bannerId) ?? "";
  }
  static getIosBannerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(iosBannerId) ?? "";
  }

  static setInterstitialId(String id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(interstitialId, id);
  }
  static setIosInterstitialId(String id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(iosInterstitialId, id);
  }

  static getInterstitialId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(interstitialId) ?? "";
  } static getIosInterstitialId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(iosInterstitialId) ?? "";
  }


  static setRecentReadBook(String book)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(recentRead, book);
  }
  static setRecentReadBookName(String name)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(recentReadName, name);
  }

  static getRecentReadBook() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(recentRead) ?? "";
  }

  static getRecentReadBookName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(recentReadName) ?? "";
  }

  static String favouriteList = "favouriteBook";

  static Future<List<String>> getFavouriteList() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    List<String>? value = prefs.getStringList(favouriteList) ;
    return value ?? [];
  }

  static setFavouriteList(List<String> sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(favouriteList, sizes);
  }

  static String recentList = "recentBook";

  static Future<List<String>> getRecentList() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    List<String>? value = prefs.getStringList(recentList) ;
    return value ?? [];
  }

  static setRecentList(List<String> sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(recentList, sizes);
  }

  static String bookMarkList = "booMarkBook";

  static Future<List<String>> getBookMarkList() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    List<String>? value = prefs.getStringList(bookMarkList) ;
    return value ?? [];
  }

  static setBookMarkList(List<String> sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(bookMarkList, sizes);
  }


  static setAppIcon(String icon)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(appIcon, icon);
  }


  static String recentSearchList = "recentSearchList";


  static Future<List<String>> getRecentSearchList() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    List<String>? value = prefs.getStringList(recentSearchList) ;
    return value ?? [];
  }

  static setRecentSearchList(List<String> sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(recentSearchList, sizes);
  }



}
