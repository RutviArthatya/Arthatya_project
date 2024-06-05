import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ads/constant/constant.dart';
import '../../ads/google_native_small_ad.dart';
import '../../constant/color_const.dart';
import '../../constant/img_const.dart';
import '../../constant/string_const.dart';
import '../../custom/custom_size.dart';
import '../../custom/custom_text.dart';
import '../../routing/routes.dart';

class Intro3Screen extends StatefulWidget {
  const Intro3Screen({super.key});

  @override
  State<Intro3Screen> createState() => _Intro3ScreenState();
}

class _Intro3ScreenState extends State<Intro3Screen> {
  @override
  void initState() {
    getPreLoadAds();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isBackAdd) {
          backAds();
        }
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: const GoogleNativeSmallAd(),
        body: SafeArea(child: buildBody()),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: "How it Works",
              color: ColorConst.buttonColor,
              size: 20,
              weight: true,
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Image.asset(
              ImgConst.intro3,
              height: Get.height * 0.45,
            ),
            // SizedBox(height: Get.height * 0.07,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: StringConst.intro3,
                size: 14,
              ),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    buildCircle(),
                    buildSize(),
                    buildCircle(),
                    buildSize(),
                    buildCircle(isSelect: true),
                  ]),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.tabBarScreen);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConst.buttonColor),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: ColorConst.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCircle({bool isSelect = false}) {
    return Icon(
      Icons.circle,
      size: 10,
      color: isSelect ? ColorConst.buttonColor : const Color(0xFFe7e8ea),
    );
  }
}
