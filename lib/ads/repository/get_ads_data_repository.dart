import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constant/list_const.dart';
import '../constant/constant.dart';
import '../model/ads_data.dart';

class GetAdsDataRepository {
  static Future<void> fetchAdsData() async {
    await FirebaseFirestore.instance.collection("currencyConverter").doc("ids").get().then(
        (value) =>
            ListConst.adsData = adsDataFromJson(json.encode(value.data())));

    if (ListConst.adsData.showAd != null) {
      showAd.value = ListConst.adsData.showAd!;
      print("showAd >>>>>> ${showAd.value}");
    }
    if (ListConst.adsData.googleNativeVisible != null) {
      googleNativeVisible.value = ListConst.adsData.googleNativeVisible!;
      print("googleNativeVisible >>>>>> ${googleNativeVisible.value}");
    }
    if (ListConst.adsData.googleNativeIOSId1 != null) {
      googleNativeIOSId1 = ListConst.adsData.googleNativeIOSId1!;
      print("googleNativeIOSId1 >>>>>> ${googleNativeIOSId1}");
    }
    if (ListConst.adsData.googleNativeIOSId2 != null) {
      googleNativeIOSId2 = ListConst.adsData.googleNativeIOSId2!;
      print("googleNativeIOSId2 >>>>>> ${googleNativeIOSId2}");
    }
    if (ListConst.adsData.googleNativeIOSId3 != null) {
      googleNativeIOSId3 = ListConst.adsData.googleNativeIOSId3!;
      print("googleNativeIOSId3 >>>>>> ${googleNativeIOSId3}");
    }
    if (ListConst.adsData.googleNativeIOSId4 != null) {
      googleNativeIOSId4 = ListConst.adsData.googleNativeIOSId4!;
      print("googleNativeIOSId4 >>>>>> ${googleNativeIOSId4}");
    }
    if (ListConst.adsData.googleNativeIOSId5 != null) {
      googleNativeIOSId5 = ListConst.adsData.googleNativeIOSId5!;
      print("googleNativeIOSId5 >>>>>> ${googleNativeIOSId5}");
    }
    if (ListConst.adsData.googleInterVisible != null) {
      googleInterVisible.value = ListConst.adsData.googleInterVisible!;
      print("googleInterVisible >>>>>> ${googleInterVisible.value}");
    }
    if (ListConst.adsData.googleInterIOSId1 != null) {
      googleInterIOSId1 = ListConst.adsData.googleInterIOSId1!;
      print("googleInterIOSId1 >>>>>> ${googleInterIOSId1}");
    }
    if (ListConst.adsData.googleInterIOSId2 != null) {
      googleInterIOSId2 = ListConst.adsData.googleInterIOSId2!;
      print("googleInterIOSId2 >>>>>> ${googleInterIOSId2}");
    }
    if (ListConst.adsData.googleInterIOSId3 != null) {
      googleInterIOSId3 = ListConst.adsData.googleInterIOSId3!;
      print("googleInterIOSId3 >>>>>> ${googleInterIOSId3}");
    }
    if (ListConst.adsData.googleInterIOSId4 != null) {
      googleInterIOSId4 = ListConst.adsData.googleInterIOSId4!;
      print("googleInterIOSId4 >>>>>> ${googleInterIOSId4}");
    }
    if (ListConst.adsData.googleInterIOSId5 != null) {
      googleInterIOSId5 = ListConst.adsData.googleInterIOSId5!;
      print("googleInterIOSId5 >>>>>> ${googleInterIOSId5}");
    }
    if (ListConst.adsData.googleAppOpen != null) {
      googleAppOpen = ListConst.adsData.googleAppOpen!;
      print("googleAppOpen >>>>>> ${googleAppOpen}");
    }
    if (ListConst.adsData.googleAppOpenVisible != null) {
      googleAppOpenVisible.value = ListConst.adsData.googleAppOpenVisible!;
      print("googleAppOpenVisible >>>>>> ${googleAppOpenVisible}");
    }
    if (ListConst.adsData.showIntro != null) {
      showIntro.value = ListConst.adsData.showIntro!;
      print("showIntro >>>>>> ${showIntro}");
    }


  }
}
