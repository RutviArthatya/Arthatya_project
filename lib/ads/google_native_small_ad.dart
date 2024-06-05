import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'constant/constant.dart';

class GoogleNativeSmallAd extends StatefulWidget {
  const GoogleNativeSmallAd({super.key});

  @override
  State<GoogleNativeSmallAd> createState() => _GoogleNativeSmallAdState();
}

class _GoogleNativeSmallAdState extends State<GoogleNativeSmallAd> {
  String iosCurrentNativeId = "";
  RxBool adLoaded = false.obs;
  NativeAd? ad;

  @override
  void initState() {
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
        templateType: TemplateType.small,
        // Optional: Customize the ad's style.
        // mainBackgroundColor: Colors.purple,
        cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(size: 16.0),
        primaryTextStyle: NativeTemplateTextStyle(size: 16.0),
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (showAd.value)
          ? googleNativeVisible.value
              ? adLoaded.value == true
                  ? SafeArea(
                      child: SizedBox(
                        height: 100,
                        child: AdWidget(ad: ad!),
                      ),
                    )
                  : const SizedBox(
                      height: 120,
                      width: 120,
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    )
              : const SizedBox()
          : const SizedBox(),
    );
  }
}
