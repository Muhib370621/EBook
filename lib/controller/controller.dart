import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/datafile/firebase_data/firebasedata.dart';
import 'package:ebook_app/models/app_detail_model.dart';
import 'package:ebook_app/models/book_list_model.dart';
import 'package:ebook_app/utils/pref_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../datafile/firebase_data/key_table.dart';
import '../models/drawer_categoy_class_data_model.dart';
import '../models/notification_model.dart';


class IntroScreenController extends GetxController{
  int currentPage = 0;

  onPageChange(int initialPage) {
    currentPage = initialPage;
    update();
  }

}


class HomeMainScreenController extends GetxController{
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxInt index = 2.obs;
  // int selectedOption = 1;

  onChange(RxInt value) {
    index.value = value.value;
    update();
  }

  // void onSetSelectSliderOption(int? id) {
  //   selectedOption = id!;
  //   update();
  // }

}


class HomeTabController extends GetxController{
  int typeIndex = 0;
  void setBookTypeIndex(int index) {
    typeIndex = index;
    update();
  }
}


class CategoryTabController extends GetxController{
  int typeIndex = 0;

  RxBool isDataLoading = false.obs;
  RxBool isStoryLoading = false.obs;

  List<CategoryModel> categoryList = [];
  RxList<StoryModel> storyList = <StoryModel>[].obs;


  @override
  void onInit() {
    super.onInit();

    // getData();

  }


  getData() async {

    isStoryLoading.value = true;
  String id = "";
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(KeyTable.category).get();

    if(querySnapshot.size > 0){
      List<DocumentSnapshot> list = querySnapshot.docs;

      if(list.isNotEmpty){

        CategoryModel categoryModel = CategoryModel.fromFirestore(list[0]);

        id = categoryModel.id ?? "";


        // print("id-------${id}");





        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(KeyTable.storyList).where(KeyTable.refId,isEqualTo: id).orderBy(KeyTable.index,descending: true).get();
        if(querySnapshot.size > 0){
          List<DocumentSnapshot> list = querySnapshot.docs;

          for(int i = 0;i<list.length;i++){
            if(list.isNotEmpty){
              storyList.add(StoryModel.fromFirestore(list[i]));
            }
          }


          // print("listlen------_${storyList.length}");
        }


      }

    }
    isDataLoading.value = false;

  }



  getAllCategoryList() async {
    isDataLoading.value = true;

    var result = await FireBaseData.getAllCategoryList();

    categoryList = result;

    isDataLoading.value = false;
    // update();

  }

  getAllStoryList(String id) async {
    isStoryLoading.value = true;

    // print("called----true");
    var result = await FireBaseData.getBookListById(id);
    
    // print("result----------_${result.toString()}");
    storyList.value = result;
    isStoryLoading.value = false;

    update();
  }




  void setBookTypeIndex(int index) {
    typeIndex=index ;
    // update();
  }
}

// class TrenDingBookScreenController extends GetxController{
//   int setindex = 0;
//   bool like = false;
//   bool save = false;
//   void onSetIndex(int index) {
//     setindex = index;
//     update();
//   }
//
//   void onSetLike() {
//     like = !like;
//     update();
//   }
//
//   void setSavePosition() {
//     save=!save;
//     update();
//   }
// }

class FavTabController extends GetxController{
  RxList<DocumentSnapshot> filteredFavList = <DocumentSnapshot>[].obs;



  checkDataExist(List<DocumentSnapshot> list,RxList<String> favouriteList){
    for(int i = 0;i<list.length;i++){
      if(favouriteList.contains(list[i].id)){
        filteredFavList.add(list[i]);
      }
    }
  }


}


class AllReadBookController extends GetxController{
  RxList<DocumentSnapshot> filteredBookMarkList = <DocumentSnapshot>[].obs;



  checkDataExist(List<DocumentSnapshot> list,RxList<String> bookMarkList){
    for(int i = 0;i<list.length;i++){
      if(bookMarkList.contains(list[i].id)){
        filteredBookMarkList.add(list[i]);
      }
    }
    update();
  }
}



class QuickReadController extends GetxController{


  RxList<DocumentSnapshot> filteredRecentList = <DocumentSnapshot>[].obs;



  checkDataExist(List<DocumentSnapshot> list,RxList<String> recentList){
    for(int i = 0;i<list.length;i++){
      if(recentList.contains(list[i].id)){
        filteredRecentList.add(list[i]);
      }
    }
    update();
  }


}



class RecentController extends GetxController{
  RxBool like = false.obs;
  RxBool save = false.obs;


  RxList<String> recentList = <String>[].obs;




  void getRecentDataList() async {
    recentList.value = await PrefData.getRecentList();
  }

  setRecentList(String id){
    recentList.add(id);
    PrefData.setRecentList(recentList);
  }





  // checkInRecent(String id){
  //
  //   like.value = recentList.contains(id);
  //
  //   update();
  // }


  // checkInRecentList(StoryModel story) async {
  //   if (recentList.contains(story.id.toString())) {
  //     recentList.remove(story.id.toString());
  //     PrefData.setRecentList(recentList);
  //   } else {
  //
  //   }
  //
  //   getRecentDataList();
  //
  // }

}





class PopulerBookScreenController extends GetxController{
  int setindex = 0;
  RxBool like = false.obs;
  RxBool save = false.obs;


  RxList<String> favouriteList = <String>[].obs;
  RxList<String> bookMarkList = <String>[].obs;




  void getFavDataList() async {
    favouriteList.value = await PrefData.getFavouriteList();
  }


  void getBookMarkList() async {
    bookMarkList.value = await PrefData.getBookMarkList();
    // print("getvalsbook========${bookMarkList.length}");

  }

  checkInFav(String id){

    like.value = favouriteList.contains(id);

    update();
  }

  checkInBookMark(String id){


    // print("l-----------${save.value}");

    save.value = bookMarkList.contains(id);


    // print("lbook--------11---${save.value}");
    update();
  }


  checkInFavouriteList(StoryModel story) async {
    if (favouriteList.contains(story.id.toString())) {
      favouriteList.remove(story.id.toString());
      PrefData.setFavouriteList(favouriteList);
    } else {
      favouriteList.add(story.id!.toString());
      PrefData.setFavouriteList(favouriteList);
    }

    getFavDataList();

  }

  checkInBookMarkList(StoryModel story) async {
    if (bookMarkList.contains(story.id.toString())) {
      bookMarkList.remove(story.id.toString());
      PrefData.setBookMarkList(bookMarkList);
    } else {
      bookMarkList.add(story.id!.toString());
      PrefData.setBookMarkList(bookMarkList);
    }

    getFavDataList();

  }

  void onSetIndex(int index) {
    setindex = index;
    update();
  }

  // void onSetLike() {
  //   like = !like;
  //   update();
  // }

  // void setSavePosition() {
  //   save = !save;
  //   update();
  // }

}

class SubscritionScreenController extends GetxController{
  int planeId = 1;
  bool removeAds = true;
  bool unlimitedPlane = true;
  void onSetplaneId(int id) {
    planeId = id;
    update();
  }

  void onRemoveAds() {
    removeAds = !removeAds;
    update();
  }

  void onUnlimitedPlane() {
    unlimitedPlane = !unlimitedPlane;
      update();
  }
}

class ReadBookScreenController extends GetxController{}
class PopularBookDetailScreenController extends GetxController{

}
class AuthorDetailScreenController extends GetxController{

  onsetAuthorIndex(){}

}

class SavedTabController extends GetxController{}


class NotificationTabController extends GetxController{

  List<NotificationModel> notificationList = [];



  // setNotificationToList(){
  //
  //   List<String> list = ["a","b"];
  //
  //   String json = jsonEncode(list);
  //
  //
  //
  //   print("stringList---------$json");
  //
  //
  //   PrefData.setNotificationList(json);
  // }

}


class MoreTabController extends GetxController{
  bool currentTheme = false;
  bool notification = true;
  void onSetTheme() {
    currentTheme = !currentTheme;
    update();
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      update();
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      update();
    }
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();

    // print("called--------setting");

    model = await FireBaseData.getAppDetail();

  }

  AppDetailModel? model;

  void onSetNotification() {
    notification = !notification;
    update();
  }
}


class AboutUsScreenController extends GetxController{

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();

    model = await FireBaseData.getAppDetail();
  }

  AppDetailModel? model;

}
class ReviewsScreenController extends GetxController{
  bool reviewLike = false;
  void setReviewLike() {
    reviewLike =!reviewLike;
    update();
  }
}

//////////////////////////////////////////////////////////////////drawerClass/////////////////////////
class DashboardScreenController extends GetxController{}
class CategoriesScreenController extends GetxController{}
class StoriesScreenController extends GetxController{}
class BooksScreenController extends GetxController{}
class HomeSliderScreenController extends GetxController{}
class AuthorScreenController extends GetxController{}
class SendNotificationScreenController extends GetxController{}
class SettingScreenController extends GetxController{}
class EditCategoriesScreenController extends GetxController{}
class AddNewCategoryScreenController extends GetxController{}
class AddAuthorScreenController extends GetxController{}