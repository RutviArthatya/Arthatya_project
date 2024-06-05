import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../ads/constant/constant.dart';
import '../../ads/google_interstitial_ad.dart';
import '../../ads/repository/get_ads_data_repository.dart';
import '../../constant/color_const.dart';
import '../../constant/img_const.dart';
import '../../custom/custom_size.dart';
import '../../routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    internetChecker();
    super.initState();

  }

  RxBool isInternet = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Obx(() => isInternet.value
            ? Padding(
                padding: const EdgeInsets.all(100),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: ColorConst.white,
                  child: Image.asset(
                    ImgConst.splash,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text("Check Your Internet Connection",style: TextStyle(color: ColorConst.blackColor,fontFamily: 'Poppins'),),
                  buildSize(height: 25),
                  const CircularProgressIndicator(color: ColorConst.buttonColor,),
                  buildSize(height: 25),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConst.buttonColor),
                      onPressed: () {
                        internetChecker();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),

                        child: Text("Retry",style: TextStyle(color: ColorConst.white,fontSize: 18,fontFamily: 'Poppins',),),
                      ))
                ],
              )),
      ),
    );
  }

  void getAppData() async {
    log("bnchjfdijsnvd ???");
    await GetAdsDataRepository.fetchAdsData();
    googleAppOpenLoadAd();
    Timer(const Duration(seconds: 4), () {
      // Get.toNamed(Routes.tabBarScreen);
      if (showIntro.value) {
        log("show intro ??? >>>>>> ${showIntro.value}");
        log("intro1");
        Get.offAllNamed(Routes.intro1Screen);
      } else {
        log("show intro ??? >>>>>> ${showIntro.value}");
        log("home");
        Get.offAllNamed(Routes.tabBarScreen);
      }
    });
  }

  Future<void> internetChecker() async {
    isInternet.value = await InternetConnectionChecker().hasConnection;
    if (isInternet.value) {
      getAppData();
    }
  }
}
