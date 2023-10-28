import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesData{
  final String? image;
  final String? name;
  final int id;

  CategoriesData({this.image, this.name, required this.id});
}

class CategoryModel{

  String? name="";
  String? image="";
  String? id="";

  int? refId=1;

  CategoryModel({this.id,this.name,this.image,this.refId,});

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return CategoryModel(
      id: doc.id,
      name: data['name']??'',
      image: data['image']??'',
      refId: data['refId']??0,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> data) {



    return CategoryModel(

      image: data['image'],
      name: data['name'],
      refId: data['refId'],


    );


  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['refId'] = refId;
    return data;
  }


}