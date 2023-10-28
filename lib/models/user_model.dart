import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? username;
  String? uid;
  String? password;
  String? email;
  String? active;
  // int? subscribed;

  UserModel({this.id,this.uid, this.username, this.password, this.email, this.active});


  factory UserModel.fromFireStore(DocumentSnapshot doc){

    Map data = doc.data() as Map;

    return UserModel(
      username: data['username'],
      password: data['password'],
      email: data['email'],
      active: data['active'],
      // subscribed: data['subscribed'],
      uid: data['uid'],

    );

  }

  factory UserModel.fromJson(Map<String, dynamic> data) {



    return UserModel(
      username: data['username'],
      password: data['password'],
      email: data['email'],
      active: data['active'],
      // subscribed: data['subscribed'],
      uid: data['uid'],

    );
  }

  Map<String, dynamic>  toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['active'] = active;
    // data['subscribed'] = subscribed;
    data['uid'] = uid;


    return data;
  }



}