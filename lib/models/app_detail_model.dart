import 'package:cloud_firestore/cloud_firestore.dart';

class AppDetailModel{

  String? id="";
  String? name="";
  String? adId="";
  String? iosAdId="";
  String? bannerAdId="";
  String? iosBannerAdId="";
  String? interstitialAdId="";
  String? iosInterstitialAdId="";
  String? image="";
  String? terms="";
  String? privacyPolicy="";
  String? aboutUs="";



  AppDetailModel({this.terms,this.privacyPolicy,this.aboutUs,this.iosAdId,this.name,this.adId,this.bannerAdId,this.iosBannerAdId,this.interstitialAdId,this.iosInterstitialAdId,this.image,this.id});

  factory AppDetailModel.fromFirestore(DocumentSnapshot doc) {


    Map data = doc.data() as Map;


    return AppDetailModel(
      id: doc.id,
      name: data['name'] ??'',
      adId: data['adId'] ??'',
      iosAdId: data['iosAdId'] ??'',
      image: data['image']??'',
      bannerAdId: data['bannerAdId']??'',
      iosBannerAdId: data['iosBannerAdId']??'',
      interstitialAdId: data['interstitialAdId']??'',
      iosInterstitialAdId: data['iosInterstitialAdId']??'',
      terms: data['terms']??'',
      privacyPolicy: data['privacyPolicy']??'',
      aboutUs: data['aboutUs']??'',

    );
  }

  factory AppDetailModel.fromJson(Map<String, dynamic> data) {
    return AppDetailModel(
      image: data['image'],
      name: data['name'],
      adId: data['adId'],
      iosAdId: data['iosAdId'],
      bannerAdId: data['bannerAdId'],
      iosBannerAdId: data['iosBannerAdId'],
      interstitialAdId: data['interstitialAdId'],
      iosInterstitialAdId: data['iosInterstitialAdId'],
      terms: data['terms'],
      privacyPolicy: data['privacyPolicy'],
      aboutUs: data['aboutUs'],
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['adId'] = adId;
    data['iosAdId'] = iosAdId;
    data['bannerAdId'] = bannerAdId;
    data['iosBannerAdId'] = iosBannerAdId;
    data['interstitialAdId'] = interstitialAdId;
    data['iosInterstitialAdId'] = iosInterstitialAdId;
    data['image'] = image;
    data['terms'] = terms;
    data['privacyPolicy'] = privacyPolicy;
    data['aboutUs'] = aboutUs;

    return data;
  }


}