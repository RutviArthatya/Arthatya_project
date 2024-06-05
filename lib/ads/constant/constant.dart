import 'dart:developer';

import 'package:get/get.dart';

import '../google_interstitial_ad.dart';





//............in-app-purchase......
String productId = "";
String inAppPrice = "";
double? inAppRowPrice;
String inAppCurrencyCode = "";



RxBool showIntro = false.obs;
RxBool showAd = false.obs;
RxBool googleNativeVisible = false.obs;
RxBool googleInterVisible = false.obs;
RxBool googleAppOpenVisible = false.obs;



//-------------------
RxBool isGoogleIntShowed = false.obs;
RxBool isGoogleIntFailed = false.obs;
RxBool isGoogleShowed = false.obs;
bool isClicked = true;
bool isBackAdd = true;





//ios

//native
String googleNativeIOSId1 = "";
String googleNativeIOSId2 = "";
String googleNativeIOSId3 = "";
String googleNativeIOSId4 = "";
String googleNativeIOSId5 = "";

//inter
String googleInterIOSId1 = "";
String googleInterIOSId2 = "";
String googleInterIOSId3 = "";
String googleInterIOSId4 = "";
String googleInterIOSId5 = "";

//appOpen
String googleAppOpen = "";

int googleNativeCurrentId = 1;
int googleInterCurrentId = 1;


void getPreLoadAds() {
  if (showAd.value) {
    log('aya re edhar aya yeh');
    if(googleInterVisible.value){
      log("show google inter >>>>>>>> ${googleInterVisible.value}");
      if (isClicked) {
        log("Inter Ads Launched");

        MyGoogleAdsManager.showInterstitialAd();


      }
    }

  }


  if (isClicked) {
    MyGoogleAdsManager.initGoogleLoad();
  }

}

void backAds() {
  if (showAd.value) {
  if (isBackAdd) {
    log('aya re edhar aya yh');
    if (googleInterVisible.value) {
      log("google backad ???? ${googleInterVisible.value}");
      if (isClicked) {
        MyGoogleAdsManager.showInterstitialAd();
      }
    }
  }

  }

  if (isClicked) {

    MyGoogleAdsManager.initGoogleLoad();
  }
}