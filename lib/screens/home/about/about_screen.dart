import 'package:currency_converter/ads/google_native_medium_ad.dart';
import 'package:currency_converter/custom/custom_appbar.dart';
import 'package:currency_converter/custom/custom_size.dart';
import 'package:currency_converter/custom/custom_text.dart';
import 'package:flutter/material.dart';
import '../../../ads/constant/constant.dart';
import '../../../constant/string_const.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
        appBar: buildAppbar(title: "About"),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GoogleNativeMediumAd(),
            SizedBox(
                width: double.infinity,
                child: CustomText(
                  text: "Notice",
                  size: 20,
                  weight: true,
                  align: TextAlign.center,
                )),
            buildSize(),
            CustomText(
              text: StringConst.about1,
              align: TextAlign.start,
            ),
            buildSize(),
            CustomText(
              text: StringConst.about2,
              align: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
