import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'AdsInfo.dart';

class AdsFile {

  AdsFile();
  // BuildContext? context;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  static double bannerSize=120.h;

  AdWidget? adWidget;


  RxBool isLoading =false.obs;


  BannerAd? _anchoredBanner;

  Future<void> createAnchoredBanner(BuildContext context,
      {Function? function}) async {

    if(!kIsWeb){
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: await getBannerAdUnitId(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          // setState(() {
            _anchoredBanner = ad as BannerAd?;
            isLoading.value=true;
          // });
          if (function != null) {
            function();
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
    }
  }

  void disposeInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.dispose();
    }
  }

  void disposeRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.dispose();
    }
  }

  void disposeBannerAd() {
    if (_anchoredBanner != null) {
      _anchoredBanner!.dispose();
    }
  }

  void showInterstitialAd(Function function,{bool? isShow}) {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');

      function();

      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        function();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) async {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        await createInterstitialAd();
      },
    );
    if(isShow == null){
      _interstitialAd!.show();
      _interstitialAd = null;
    }else{
      _interstitialAd!.show();
      _interstitialAd = null;
    }

  }

  void showRewardedAd(Function function, Function function1) async {
    bool _isRewarded = false;
    if (_rewardedAd == null) {
      function1();
      // showToast(S.of(context!).videoError);
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();

        if (_isRewarded) {
          function();
        } else {
          function1();
        }
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
    );

    // _rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
    //   _isRewarded = true;
    //   print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    // });

    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      _isRewarded = true;
      _rewardedAd = null;
      // print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
  }

  void createRewardedAd() {


    print("called----creatre");
    // if(!isAppPurchased ) {
    RewardedAd.load(
        adUnitId: getRewardBasedVideoAdUnitId(),
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('reward====$ad loaded.');
            _rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            createRewardedAd();
          },
        ));



  }

  NativeAd?  myNative;
  loadNativeBannerAd() async {

      myNative = NativeAd(
      adUnitId: getNativeBannerId(),
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print("ad==nativeLoaded---$myNative");
          adWidget = AdWidget(ad: myNative!);
          isLoading.value=true;
        },

        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          print("ad==dispose");
          ad.dispose();
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression.'),
        // Called when a click is recorded for a NativeAd.
        // onNativeAdClicked: (NativeAd ad) => print('Ad clicked.'),
      ),
    );

      if(myNative!=null) {
        await  myNative!.load();

      }


    // ad.loadNativeBannerAd(
    //     adUnitId: getNativeBannerId(),
    //     onAdLoaded: (ad) {
    //       isNativeAdReady = true;
    //       print('Ad load true');
    //       setState(() => "");
    //     },
    //     onAdFailedToLoad: (ad1, error) {
    //       ad.loadNativeBannerAd(adUnitId: getNativeBannerId());
    //       isNativeAdReady = false;
    //       ad1.dispose();
    //       print('Ad load failed (code=${error.code} message=${error.message})');
    //     });
  }

  loadMediumNativeBannerAd(var setState) async {

    // await ad.loadmediumNativeAd(adUnitId: getNativeBannerId(),onAdLoaded: (ad) {
    //
    //
    //       isNativeAdReady = true;
    //       print('Ad load true');
    //       setState(() => "");
    //     },
    //     onAdFailedToLoad: (ad1, error) {
    //       ad.loadmediumNativeAd(adUnitId: getNativeBannerId());
    //       isNativeAdReady = false;
    //       ad1.dispose();
    //       print('Ad load failed (code=${error.code} message=${error.message})');
    //     });
  }

  Future<void> createInterstitialAd() async {
    if (!kIsWeb) {
      // if(!isAppPurchased  && isAdsPermission) {
      InterstitialAd.load(
          adUnitId: await getInterstitialAdUnitId(),
          request: request,
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              print('$ad loaded');

              _interstitialAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error) async {
              print('InterstitialAd failed to load: $error.');
              // _numInterstitialLoadAttempts += 1;
              _interstitialAd = null;


              // if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              await createInterstitialAd();
              // }
            },
          ));
    }
  }

}

getBanner(BuildContext context, AdsFile? adsFile) {
  if (adsFile == null) {
    return Container();
  } else {
    return showBanner(context, adsFile);
  }
}

showRewardedAd(AdsFile? adsFile, Function function, {Function? function1}) {
  if (adsFile != null) {
    adsFile.showRewardedAd(() {
      function();
    }, () {
      if (function1 != null) {
        function1();
      }
    });
  }
}

showInterstitialAd(AdsFile? adsFile, Function function,{bool? isShow}) {
  if (adsFile != null) {
    adsFile.showInterstitialAd(() {
      function();
    },isShow: isShow);
  } else {
    function();
  }
}

disposeRewardedAd(AdsFile? adsFile) {
  if (adsFile != null) {
    adsFile.disposeRewardedAd();
  }
}

disposeInterstitialAd(AdsFile? adsFile) {
  if (adsFile != null) {
    adsFile.disposeInterstitialAd();
  }
}

disposeBannerAd(AdsFile? adsFile) {
  if (adsFile != null) {
    adsFile.disposeBannerAd();
  }
}

showBanner(BuildContext context, AdsFile adsFile) {
  return Container(
    height: (getBannerAd(adsFile) != null)
        ? getBannerAd(adsFile)!.size.height.toDouble()
        : 0,
    // color: Colors.black,
    color: Theme.of(context).scaffoldBackgroundColor,
    child: (getBannerAd(adsFile) != null)
        ? AdWidget(ad: getBannerAd(adsFile)!)
        : Container(),
  );
}

BannerAd? getBannerAd(AdsFile? adsFile) {
  BannerAd? _anchoredBanner;
  if (adsFile != null) {
    return (adsFile._anchoredBanner == null)
        ? _anchoredBanner
        : adsFile._anchoredBanner!;
  } else {
    return _anchoredBanner!;
  }
}

Widget getNativeBannerWidget(AdsFile? adsFile) {

  return adsFile==null?Container():SizedBox(
      width: double.infinity,
      height:adsFile.adWidget==null?0: AdsFile.bannerSize,
      child: adsFile.adWidget==null?Container():adsFile.adWidget!
          );
}


Widget getMediumNativeBannerWidget(BuildContext context,AdsFile? adsFile) {

  return Container();
  // return adsFile==null?Container()
  //     :Container(
  //     width: getWidthPercentSize(context, 60)
  //     ,height: adsFile.isNativeAdReady?getScreenPercentSize(context, 45):0,
  //
  //     child: adsFile.isNativeAdReady
  //         ? adsFile.getMediumNativeAD()
  //         : SizedBox.shrink());
}

