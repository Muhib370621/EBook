import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class BookList{
  final String? title;
  final String? writerName;
  final Color? backGround;
  final String? bookImage;

  BookList({this.title, this.writerName,this.backGround,this.bookImage});
}

class StoryModel{

  String? name="";
  String? image="";
  String? pdf="";
  String? desc="";
  String? date="";
  String? id="";
  String? refId='';
  List? authId;
  int? index=1;
  int? views=1;
  bool? isBookmark=false;
  bool? isFav=false;
  bool? isActive=true;
  bool? isPopular=true;
  bool? isFeatured=true;

  StoryModel({this.isPopular,this.isFeatured,this.authId,this.pdf,this.id,this.name,this.image,this.refId,this.desc,this.index,this.isActive,this.views,this.date,this.isBookmark,this.isFav});

  factory StoryModel.fromFirestore(DocumentSnapshot doc) {


    Map data = doc.data() as Map;


    return StoryModel(
      id: doc.id,
      name: data['name'] ??'',
      image: data['image']??'',
      refId: data['refId']??'',
      desc: data['desc']??'',
      index: data['index']??0,
      isActive: data['is_active']??false,
      date: data['date']??'',
      authId:  data['auth_id']??'',
      views: data['views']??0,
      pdf: data['pdf']??'',
      isBookmark: data['is_bookmark']??false,
      isFav: data['is_favourite']??false,
      isPopular: data['is_popular']??false,
      isFeatured: data['is_featured']??false,
    );
  }

  factory StoryModel.fromJson(Map<String, dynamic> data) {
    return StoryModel(
      image: data['image'],
      name: data['name'],
      refId: data['refId'],
      index: data['index'],
      views: data['views'],
      desc: data['desc'],
      isActive: data['is_active'],
      date: data['date'],
      authId: data['auth_id'],
      isBookmark: data['is_bookmark'],
      pdf: data['pdf'],
      isFav: data['is_favourite'],
      isPopular: data['is_popular'],
      isFeatured: data['is_featured'],
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['refId'] = refId;
    data['desc'] = desc;
    data['index'] = index;
    data['is_active'] = isActive;
    data['date'] = date;
    data['auth_id'] = authId;
    data['views'] = views;
    data['is_bookmark'] = isBookmark;
    data['is_favourite'] = isFav;
    data['is_popular'] = isPopular;
    data['is_featured'] = isFeatured;
    data['pdf'] = pdf;

    return data;
  }


}
