// To parse this JSON data, do
//
//     final adsData = adsDataFromJson(jsonString);

import 'dart:convert';

AdsData adsDataFromJson(String str) => AdsData.fromJson(json.decode(str));

String adsDataToJson(AdsData data) => json.encode(data.toJson());

class AdsData {
  bool? showAd;
  bool? googleNativeVisible;
  String? googleNativeIOSId1;
  String? googleNativeIOSId2;
  String? googleNativeIOSId3;
  String? googleNativeIOSId4;
  String? googleNativeIOSId5;
  bool? googleInterVisible;
  String? googleInterIOSId1;
  String? googleInterIOSId2;
  String? googleInterIOSId3;
  String? googleInterIOSId4;
  String? googleInterIOSId5;
  bool? googleAppOpenVisible;
  String? googleAppOpen;
  bool? showIntro;

  AdsData({
    this.showAd,
    this.googleNativeVisible,
    this.googleNativeIOSId1,
    this.googleNativeIOSId2,
    this.googleNativeIOSId3,
    this.googleNativeIOSId4,
    this.googleNativeIOSId5,
    this.googleInterVisible,
    this.googleInterIOSId1,
    this.googleInterIOSId2,
    this.googleInterIOSId3,
    this.googleInterIOSId4,
    this.googleInterIOSId5,
    this.googleAppOpenVisible,
    this.googleAppOpen,
    this.showIntro,

  });

  factory AdsData.fromJson(Map<String, dynamic> json) => AdsData(
    showAd: json["showAd"],
    googleNativeVisible: json["googleNativeVisible"],
    googleNativeIOSId1: json["googleNativeIOSId1"],
    googleNativeIOSId2: json["googleNativeIOSId2"],
    googleNativeIOSId3: json["googleNativeIOSId3"],
    googleNativeIOSId4: json["googleNativeIOSId4"],
    googleNativeIOSId5: json["googleNativeIOSId5"],
    googleInterVisible: json["googleInterVisible"],
    googleInterIOSId1: json["googleInterIOSId1"],
    googleInterIOSId2: json["googleInterIOSId2"],
    googleInterIOSId3: json["googleInterIOSId3"],
    googleInterIOSId4: json["googleInterIOSId4"],
    googleInterIOSId5: json["googleInterIOSId5"],
    googleAppOpenVisible: json["googleAppOpenVisible"],
    googleAppOpen: json["googleAppOpen"],
    showIntro: json["showIntro"],

  );

  Map<String, dynamic> toJson() => {
    "showAd": showAd,
    "googleNativeVisible": googleNativeVisible,
    "googleNativeIOSId1": googleNativeIOSId1,
    "googleNativeIOSId2": googleNativeIOSId2,
    "googleNativeIOSId3": googleNativeIOSId3,
    "googleNativeIOSId4": googleNativeIOSId4,
    "googleNativeIOSId5": googleNativeIOSId5,
    "googleInterVisible": googleInterVisible,
    "googleInterIOSId1": googleInterIOSId1,
    "googleInterIOSId2": googleInterIOSId2,
    "googleInterIOSId3": googleInterIOSId3,
    "googleInterIOSId4": googleInterIOSId4,
    "googleInterIOSId5": googleInterIOSId5,
    "googleAppOpenVisible": googleAppOpenVisible,
    "googleAppOpen": googleAppOpen,
    "showIntro": showIntro,

  };
}
