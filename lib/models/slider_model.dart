import 'package:cloud_firestore/cloud_firestore.dart';

import '../datafile/firebase_data/key_table.dart';


class SliderModel{



  String? id="";
  String? storyId="";
  String? image="";
  String? customImg="";
  String? link="";
  int? index=1;
  String? color="";



  SliderModel({this.color,this.customImg,this.id,this.storyId,this.index,this.image,this.link});

  factory SliderModel.fromFirestore(DocumentSnapshot doc) {


    Map data = doc.data() as Map;


    return SliderModel(
      id: doc.id,
      storyId: data[KeyTable.storyId] ??'',
      image: data['image'] ?? '',
      customImg: data['custom_img'] ?? '',
      link: data['link'] ?? '',
      index: data['index']??0,
      color: data['color']??'',


    );
  }

  factory SliderModel.fromJson(Map<String, dynamic> data) {



    return SliderModel(
      storyId: data[KeyTable.storyId],
      index: data['index'],
      image: data['image'],
      link: data['link'],
      customImg: data['custom_img'],
      color: data['color'],
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[KeyTable.storyId] = storyId;
    data['index'] = index;
    data['image'] = image;
    data['custom_img'] = customImg;
    data['link'] = link;
    data['color'] = color;
    return data;
  }


}