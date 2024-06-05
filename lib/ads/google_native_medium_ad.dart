
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'constant/constant.dart';

class GoogleNativeMediumAd extends StatefulWidget {
  const GoogleNativeMediumAd({super.key});

  @override
  State<GoogleNativeMediumAd> createState() => _GoogleNativeMediumAdState();
}

class _GoogleNativeMediumAdState extends State<GoogleNativeMediumAd> {
  String iosCurrentNativeId = "";
  RxBool adLoaded = false.obs;
  NativeAd? ad;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (googleNativeCurrentId == 1) {
      iosCurrentNativeId = googleNativeIOSId1;
      log("Current google native id 1");
      googleNativeCurrentId++;
    } else if (googleNativeCurrentId == 2) {
      iosCurrentNativeId = googleNativeIOSId2;
      log("Current google native id 2");
      googleNativeCurrentId++;
    } else if (googleNativeCurrentId == 3) {
      iosCurrentNativeId = googleNativeIOSId3;
      log("Current google native id 3");
      googleNativeCurrentId++;
    } else if (googleNativeCurrentId == 4) {
      iosCurrentNativeId = googleNativeIOSId4;
      log("Current google native id 4");
      googleNativeCurrentId++;
    } else if (googleNativeCurrentId == 5) {
      iosCurrentNativeId = googleNativeIOSId5;
      log("Current google native id 5");
      googleNativeCurrentId = 1;
    }
    ad = NativeAd(
        adUnitId: iosCurrentNativeId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log("adController.adLoaded.value ????? ${adLoaded.value}");
            log('$NativeAd loaded.????????');
            adLoaded.value = true;
            log("adController.adLoaded.value after????? ${adLoaded.value}");
          },
          onAdFailedToLoad: (ad, error) {
            log('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
          // Required: Choose a template.
          templateType: TemplateType.medium,
          cornerRadius: 10.0,
          primaryTextStyle: NativeTemplateTextStyle(size: 14.0,),
          secondaryTextStyle: NativeTemplateTextStyle(size: 14.0),
        ))
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    // _adController.ad = loadNativeAd(adController: _adController);
    return Obx(
      () => (showAd.value)
          ? googleNativeVisible.value
              ? adLoaded.value == true
                  ?
                  // _adController.ad != null && _adController.adLoaded.isTrue ?
                  SafeArea(
                      child: SizedBox(
                      height: Get.height * 0.4,
                      child: AdWidget(ad: ad!),
                    ))
                  : const SizedBox(
                      height: 100,
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    )
              : const SizedBox()
          : const SizedBox(),
    );
  }
}
