import 'dart:developer';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'constant/constant.dart';
AppOpenAd? _appOpenAd;
InterstitialAd? interstitialAd;
RxBool isOpenLoader = false.obs;
void googleAppOpenLoadAd() {
  log("ander ghus gaya");
  try {
    log("app open ${googleAppOpenVisible.value}");
    log("app open ------ ${googleAppOpenVisible.value}");
    if (googleAppOpenVisible.value) {
      AppOpenAd.load(
        adUnitId: googleAppOpen,
        orientation: AppOpenAd.orientationPortrait,
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            log("AppOpenAd loaded");
            _appOpenAd = ad;
            _appOpenAd!.show();
          },
          onAdFailedToLoad: (error) {
            log('AppOpenAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
      );
    }
  } catch (e) {
    log("error => $e");
  }
}

class MyGoogleAdsManager {
  static void createInterstitialAd() {
    log("InterGoogle");
    String currentAdId = "";
    if (googleInterCurrentId == 1) {
      currentAdId = googleInterIOSId1;
      log("Current google inter id 1");
      googleInterCurrentId++;
    } else if (googleInterCurrentId == 2) {
      currentAdId = googleInterIOSId2;
      log("Current google inter id 2");
      googleInterCurrentId++;
    } else if (googleInterCurrentId == 3) {
      currentAdId = googleInterIOSId3;
      log("Current google inter id 3");
      googleInterCurrentId++;
    } else if (googleInterCurrentId == 4) {
      currentAdId = googleInterIOSId4;
      log("Current google inter id 4");
      googleInterCurrentId++;
    } else if (googleInterCurrentId == 5) {
      currentAdId = googleInterIOSId5;
      log("Current google inter id 5");
      googleInterCurrentId = 1;
    }
    InterstitialAd.load(
      // adUnitId: Platform.isAndroid
      //     ? "ca-app-pub-3940256099942544/1033173712"
      //     : currentAdId,
      adUnitId: currentAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          log("google inter loaded");
          interstitialAd = ad;
          interstitialAd!.setImmersiveMode(true);
          isGoogleIntShowed.value = false;
        },
        onAdFailedToLoad: (LoadAdError error) async {
          log("google inter failed $error");
          isGoogleIntFailed.value = true;
          interstitialAd = null;
          // createInterstitialAd();
        },
      ),
    );
  }

  static Future<void> showInterstitialAd() async {
    interstitialAd!.show();
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          log('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        interstitialAd = null;
        createInterstitialAd();

        isGoogleShowed.value = true;
      },
      onAdFailedToShowFullScreenContent:
          (InterstitialAd ad, AdError error) async {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        interstitialAd = null;
        ad.dispose();
        createInterstitialAd();
      },
    );
  }

  static void initGoogleLoad() {
    if (interstitialAd == null) {
      createInterstitialAd();
    }
  }
}

