import 'dart:io';
import 'package:ebook_app/utils/pref_data.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

AdRequest request = AdRequest(
  keywords: <String>['foo', 'bar'],
  contentUrl: 'http://foo.com/bar.html',
  nonPersonalizedAds: true,
);

Future<String> getInterstitialAdUnitId() async {

  if (Platform.isIOS) {
    return await getIosInterstitialId();
    // return 'ca-app-pub-3940256099942544/4411468910';
  } else if (Platform.isAndroid) {
    return await getInterstitialId();
    // return 'ca-app-pub-3940256099942544/1033173712';
  }
  return "";
}

Future<String> getBannerAdUnitId() async {
  if (Platform.isIOS) {
    return await getIosBannerId();
    // return 'ca-app-pub-3940256099942544/2934735716';
  } else if (Platform.isAndroid) {
    return await getBannerId();
    // return 'ca-app-pub-3940256099942544/6300978111';
  }
  return "";
}


String getRewardBasedVideoAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/1712485313';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/5224354917';
  }
  return "";
}


String getNativeBannerId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/3986624511';
  } else if (Platform.isAndroid) {
    return '/6499/example/native';
    // return 'ca-app-pub-3940256099942544/2247696110';
  }
  return "";
}


getInterstitialId() async {

  String interstitialId = await PrefData.getInterstitialId();
  return interstitialId;
}

getIosInterstitialId() async {

  String interstitialId = await PrefData.getIosInterstitialId();
  return interstitialId;
}

getBannerId() async {

  String bannerId = await PrefData.getBannerId();
  return bannerId;
}

getIosBannerId() async {

  String bannerId = await PrefData.getIosBannerId();
  return bannerId;
}


// getIcon() async {
//
//   print("called----------${await FlutterDynamicIcon.supportsAlternateIcons}");
//   try {
//
//     print("called----------${await FlutterDynamicIcon.supportsAlternateIcons}");
//     if (await FlutterDynamicIcon.supportsAlternateIcons) {
//       await FlutterDynamicIcon.setAlternateIconName("${Constant.assetImagePath}splash_logo.png");
//       print("App icon change successful");
//       return;
//     }
//   } on PlatformException {} catch (e) {
//
//     print("error----------$e");
//   }
//   print("Failed to change app icon");
//
//   setBatchNum();
//
//
//
//   }
//
//   setBatchNum() async {
//     try {
//       await FlutterDynamicIcon.setApplicationIconBadgeNumber(9399);
//     } on PlatformException {} catch (e) {}
//
// // gets currently set batch number
// //     int batchNumber = FlutterDynamicIcon.getApplicationIconBadgeNumber();
//
//
//   }




  Future changeAppName(String label) async {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: label,
      )
    );
  }


