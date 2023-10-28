import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/models/book_list_model.dart';
import 'package:ebook_app/models/drawer_categoy_class_data_model.dart';
import 'package:ebook_app/models/slider_model.dart';
import 'package:ebook_app/utils/pref_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/app_detail_model.dart';
import '../../models/top_authors_model.dart';
import 'key_table.dart';

class FireBaseData {
  static int waiting = -1;
  static int dataNotAvailable = 0;
  static int dataLoaded = 1;

  static Future<StoryModel?> fetchStory(String id) async {
    print("storyList-----hgjdfhgjkdhgjldhg");

    DocumentSnapshot querySnapshot =
    await FirebaseFirestore.instance.collection(KeyTable.storyList).doc(id).get();

    print("storyList----3645673657837489376");
    if (querySnapshot.exists) {
      // List<DocumentSnapshot> list1 = querySnapshot.docs;
      // List<DocumentSnapshot> storyList = [];
      // for (int i = 0; i < list1.length; i++) {
      //   storyList.add((list1[i]));
      // }
      //
      // print("storyList-----${storyList.length}");
      //
      // StoryModel story = StoryModel();
      //
      // for (var element in storyList) {
      //   if(element.id == id){
      //
      //     story = StoryModel.fromFirestore(element);
      //     break;
      //   }
      //
      // }
      //
      // print("storyList-------${storyList.length}");
      // return story;
    }
    return StoryModel.fromFirestore(querySnapshot);

    // QuerySnapshot querySnapshot =
    // await FirebaseFirestore.instance.collection(KeyTable.storyList).get();
    //
    //
    // if (querySnapshot.size > 0 && querySnapshot.docs.isNotEmpty) {
    //   List<DocumentSnapshot> list1 = querySnapshot.docs;
    //   List<DocumentSnapshot> storyList = [];
    //   for (int i = 0; i < list1.length; i++) {
    //     storyList.add((list1[i]));
    //   }
    //
    //   print("storyList-----${storyList.length}");
    //
    //   StoryModel story = StoryModel();
    //
    //   for (var element in storyList) {
    //     if(element.id == id){
    //
    //       story = StoryModel.fromFirestore(element);
    //       break;
    //     }
    //
    //   }
    //
    //   print("storyList-------${storyList.length}");
    //   return story;
    // }
    // return null;

  }



  static updateData(
      {required var map,
        required String tableName,
        required String doc,
        required Function function,
        bool? isToast,
        required BuildContext context}) {

    print("tableName------${tableName}");


    FirebaseFirestore.instance
        .collection(tableName)
        .doc(doc)
        .update(map)
        .then((value) {
      if (isToast == null) {
        // showCustomToast(
        //   message: "Update Successfully...",
        //   title: 'Success',
        //   context: context,
        // );
      }
      function();
    });
  }



  static addStoryViews(StoryModel storyModel, BuildContext context) async {
    updateData(map: {KeyTable.views: (storyModel.views! + 1)},
        tableName: KeyTable.storyList,
        doc: storyModel.id!,
        context: context, function: (){});
  }


  static addAuthorViews(TopAuthors topAuthors, BuildContext context) async {
    updateData(map: {KeyTable.views: (topAuthors.view! + 1)},
        tableName: KeyTable.authorList,
        doc: topAuthors.id!,
        context: context, function: (){});
  }


  static addAuthorData({
    required TopAuthors1 topAuthors,
  }) async {
    FirebaseFirestore.instance
        .collection(KeyTable.authorList)
        .add(topAuthors.toJson(true))
        .then((value) async {
      print("dfgdfgdfg===$value");
    });
  }

  static Future<void> addToken(String token) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(
        KeyTable.tokens).where(KeyTable.token, isEqualTo: token).get();

    List<DocumentSnapshot> list = snapshot.docs;

    var map = {
      "token": token
    };

    if (list.isNotEmpty) {

    } else {
      FirebaseFirestore.instance.collection(KeyTable.tokens).add(map).then((
          value) {
        print("insert-----true");
      });
    }


    // List<TokenModel> tokenList = TokenModel.fromFirestore(list)


  }

  static Future<AppDetailModel?> getAppDetail() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(KeyTable.appDetail)
        .get();

    if(querySnapshot.size > 0){
      if(querySnapshot.docs.isNotEmpty){
        List<DocumentSnapshot> list = querySnapshot.docs;

        if(list.isNotEmpty){
          AppDetailModel appDetailModel = AppDetailModel.fromFirestore(list[0]);

          PrefData.setBannerId(appDetailModel.bannerAdId ?? "");
          PrefData.setIosBannerId(appDetailModel.iosBannerAdId ?? "");

          PrefData.setInterstitialId(appDetailModel.interstitialAdId ?? "");
          PrefData.setIosInterstitialId(appDetailModel.iosInterstitialAdId ?? "");

          return appDetailModel;

        }else{
          return null;
        }
      }
    }
    return null;

  }



  // static Future<AppDetailModel> getAppDetail() async {
  //
  //
  //   AppDetailModel appDetailModel = AppDetailModel();
  //
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection(KeyTable.appDetail)
  //       .get();
  //
  //   if(querySnapshot.docs.isNotEmpty){
  //     List<DocumentSnapshot> list = querySnapshot.docs;
  //
  //
  //     appDetailModel = AppDetailModel.fromFirestore(list[0]);
  //
  //   }
  //
  //
  //   return appDetailModel;
  // }

  static Future<List<DocumentSnapshot>?> fetchSliderData() async {
    print("caleed----true");
    RxList<SliderModel> sliderList = <SliderModel>[].obs;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(KeyTable.sliderList).orderBy(KeyTable.index,descending: true).get();
    if (querySnapshot.size > 0 && querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> list1 = querySnapshot.docs;
      List<DocumentSnapshot> sliderList1 = [];
      for (int i = 0; i < list1.length; i++) {
        sliderList1.add((list1[i]));
      }

      print("sliderList1-----${sliderList1.length}");
      // for (var element in sliderList1) {
      //   SliderModel sliderModel = SliderModel.fromFirestore(element);
      //
      //   DocumentSnapshot? isExist = await FirebaseData.checkStoryExist(
      //       sliderModel.storyId!, KeyTable.storyList);
      //
      //   if (isExist != null && isExist.exists) {
      //     bool isCatExist = await FirebaseData.checkCategoryExists(StoryModel
      //         .fromFirestore(isExist)
      //         .refId!);
      //
      //     if (isCatExist) {
      //       sliderList.add(sliderModel);
      //       sliderList.refresh();
      //     }
      //
      //     print("isCatExist----${isCatExist}");
      //   }
      // }

      print("slider0-------${sliderList.length}");
      sliderList.refresh();

      return sliderList1;
    }
    return null;
  }

  static getAuthorList({int limit = 0}) {
    if (limit != 0) {
      return FirebaseFirestore.instance
          .collection(KeyTable.authorList)
          .where(KeyTable.isActive, isEqualTo: true)
          .limit(limit)
          .orderBy(KeyTable.index, descending: true)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(KeyTable.authorList)
          .where(KeyTable.isActive, isEqualTo: true)
          .orderBy(KeyTable.index, descending: true)
          .snapshots();
    }
  }

  static getAllCategoryList() async {

    List<CategoryModel> categoryList = [];

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(KeyTable.category).get();

      if(querySnapshot.size > 0){
        List<DocumentSnapshot> list = querySnapshot.docs;

        for(int i = 0;i<list.length;i++){
          if(list.isNotEmpty){
            categoryList.add(CategoryModel.fromFirestore(list[i]));
          }
        }
      }

      return categoryList;
  }


  static getBookListById(String id) async {
    List<StoryModel> storyList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(KeyTable.storyList).where(KeyTable.refId,isEqualTo: id).orderBy(KeyTable.index,descending: true).get();
    if(querySnapshot.size > 0){
      List<DocumentSnapshot> list = querySnapshot.docs;

      for(int i = 0;i<list.length;i++){
        if(list.isNotEmpty){
          storyList.add(StoryModel.fromFirestore(list[i]));
        }
      }
    }

    print("storyList------11111---${storyList.length}");


    return storyList;
  }



  static getPopularList({int limit = 0}) {
    if (limit != 0) {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true).where(KeyTable.isPopular,isEqualTo: true)
          .limit(limit)
          .orderBy(KeyTable.index,descending: true)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true).where(KeyTable.isPopular,isEqualTo: true)
          .orderBy(KeyTable.index,descending: true)
          .snapshots();
    }
  }


  static getBookList() {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true)
          .orderBy(KeyTable.index)
          .snapshots();
  }

  static getFeaturedList({int limit = 0}) {
    if (limit != 0) {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true).where(KeyTable.isFeatured,isEqualTo: true)
          .limit(limit)
          .orderBy(KeyTable.index,descending: true)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true).where(KeyTable.isFeatured,isEqualTo: true)
          .orderBy(KeyTable.index,descending: true)
          .snapshots();
    }
  }


  static getCategoryList({int limit = 0}) {
    if (limit != 0) {
      return FirebaseFirestore.instance
          .collection(KeyTable.category)
          .limit(limit)
          .orderBy(KeyTable.refId)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(KeyTable.category)
          .orderBy(KeyTable.refId)
          .snapshots();
    }
  }


  static getAuthorById({required List id}){
    return FirebaseFirestore.instance
        .collection(KeyTable.authorList)
        .snapshots();
  }


  static String getAuthorName(
      {required List author, required List<DocumentSnapshot> list}) {
    List authorList = author;
    List<String> authorsName = [];

    String name = "";

    for (int i = 0; i < list.length; i++) {
      if (authorList.contains(list[i].id)) {
        authorsName.add(TopAuthors.fromFirestore(list[i]).authorName!);
      }
    }

    name = getString(authorsName);

    return name;
  }




  // static getAuth() async {
  //
  //   List<TopAuthors> auth = await getAuthorNameList();
  //
  //   print("auth------${auth}");
  //
  //   return auth;
  //
  // }

  static Future<List<TopAuthors>> getAuthorNameList() async {

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(KeyTable.authorList).get();

    List<TopAuthors> authors = [];

    if(snapshot.size>0 && snapshot.docs.isNotEmpty){
      List<DocumentSnapshot> list = snapshot.docs;

      print("list--------${list.length}");

      if(list.isNotEmpty){
        list.forEach((e) {
          authors.add(TopAuthors.fromFirestore(e));
        });
      }

    }

    print("Authors--------${authors.toString()}");

    return authors;


  }


  // static getSearchStory(){
  //
  //
  //   FirebaseFirestore.instance.collection(KeyTable.storyList).where(arrayContains: ).get()
  //
  //
  // }


  static getString(List snap) {
    return snap.toString().replaceAll("[", "").replaceAll("]", "");
  }

  static Stream<DocumentSnapshot> getLoginData() async* {

    String id = await PrefData.getUserId();

    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection(KeyTable.loginData).doc(id).get();

    yield snapshot;

  }


  static changePassword(
      {required String password,
        required String id,
        required Function function,
        required BuildContext context}) async {


    print("id-----------${id}");


    print("user--------${FirebaseAuth.instance.currentUser}");
    if (FirebaseAuth.instance.currentUser != null) {
      User? user = FirebaseAuth.instance.currentUser!;


      print("user--------${user.email}");
      await user.updatePassword(password).then((_) async {
        // String id = await PrefData.getUserId();

        print("id-----------${id}");

        FirebaseFirestore.instance
            .collection(KeyTable.loginData)
            .doc(id)
            .update({'password': password}).then((value) {
          // showCustomToast(
          //     context: context, message: "Password change successfully");
          function();
        });
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    }
  }

}
