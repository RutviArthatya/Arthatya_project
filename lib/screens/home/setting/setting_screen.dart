import 'dart:developer';
import 'package:currency_converter/constant/img_const.dart';
import 'package:currency_converter/custom/custom_appbar.dart';
import 'package:currency_converter/custom/custom_size.dart';
import 'package:currency_converter/custom/subtitle_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../ads/constant/constant.dart';
import '../../../constant/color_const.dart';
import '../../../custom/custom_text.dart';
import '../../../routing/routes.dart';
import '../currency_controller/converttoany_controller.dart';
import '../theme_controller/theme_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    getPreLoadAds();
    // TODO: implement initState
    super.initState();
  }

  ThemeMode _selectedTheme = Get.find<ThemeController>()
      .themeMode
      .value; // Initialize with current theme mode
  final AnyCurrencyConversionController controller =
      Get.put(AnyCurrencyConversionController());
  final ThemeController themeController = Get.put(ThemeController());

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Row(
            children: [
              Image.asset(
                ImgConst.splash,
                width: 30,
                height: 30,
              ),
              buildSize(width: 10),
              CustomText(text: 'Select Theme'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Radio(
                      value: ThemeMode.light,
                      groupValue: _selectedTheme,
                      onChanged: (ThemeMode? value) {
                        setState(() {
                          _selectedTheme = value!;
                          themeController.setThemeMode(_selectedTheme);
                          Navigator.of(context).pop();
                        });
                      }),
                  CustomText(text: 'Light'),
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: ThemeMode.dark,
                      groupValue: _selectedTheme,
                      onChanged: (ThemeMode? value) {
                        setState(() {
                          _selectedTheme = value!;
                          themeController.setThemeMode(_selectedTheme);
                          Navigator.of(context).pop();
                        });
                      }),
                  CustomText(text: "Dark"),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void showPrecisionDialog(
      BuildContext context, AnyCurrencyConversionController controller) {
    int selectedPrecision = controller.precision.value;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Row(
            children: [
              Image.asset(
                ImgConst.splash,
                width: 30,
                height: 30,
              ),
              buildSize(width: 10),
              CustomText(text: 'Select Theme'),
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(5, (int index) {
                  int precisionValue = index + 1;

                  return Row(
                    children: [
                      Radio(
                        value: precisionValue,
                        groupValue: selectedPrecision,
                        onChanged: (int? value) {
                          setState(() {
                            selectedPrecision = value!;
                          });
                          controller.setPrecision(selectedPrecision);
                          Navigator.of(context).pop();
                        },
                      ),
                      CustomText(text: '$precisionValue digits'),
                    ],
                  );
                }),
              );
            },
          ),
        );
      },
    );
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
        appBar: buildAppbar(title: "Setting"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Center(
                //   child: CircleAvatar(
                //     radius: 40,
                //     backgroundImage: AssetImage(ImgConst.splash),
                //   ),
                // ),
                // buildSize(height: 20),
                getTitle(title: "Useful Service"),
                buildSize(),
                getOptions(
                    onTap: _showThemeDialog,
                    icon: Icons.contrast,
                    title: "Theme",
                    subTitle: "Set your currencies"),
                const Divider(
                  height: 25,
                  thickness: 0.5,
                ),
                getOptions(
                    onTap: () {
                      showPrecisionDialog(context, controller);
                    },
                    icon: Icons.calculate,
                    title: "Precision",
                    subTitle: "Max decimal digits"),
                const Divider(
                  height: 25,
                  thickness: 0.5,
                ),
                getOptions(
                    onTap: () {
                      Get.toNamed(Routes.favoritesScreen);
                    },
                    icon: Icons.favorite,
                    title: "Favorite Screen",
                    subTitle: "Favorite"),

                const Divider(
                  height: 25,
                  thickness: 0.5,
                ),
                getTitle(title: "Info"),
                buildSize(),
                getOptions(
                    onTap: () {
                      Get.toNamed(Routes.aboutScreen);
                    },
                    icon: Icons.info,
                    title: "About",
                    subTitle: "Notice"),
                const Divider(
                  height: 25,
                  thickness: 0.5,
                ),

                getTitle(title: "Other"),
                buildSize(),
                getOptions(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        // set to false if you want to force a rating
                        builder: (context) => _dialog,
                      );
                    },
                    icon: Icons.star_rate_rounded,
                    title: "Rate",
                    subTitle: "Rate the app"),
                const Divider(
                  height: 25,
                  thickness: 0.5,
                ),
                getOptions(
                    onTap: shareApp,
                    icon: Icons.share,
                    title: "Share",
                    subTitle: "Suggest us to your friends"),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTitle({required String title}){
    return Text(
      title,
      style: TextStyle(
          color: ColorConst.subColor,
          fontFamily: "Poppins",
          fontSize: 12,
          letterSpacing: 0.5,
          fontWeight: FontWeight.bold),
    );
  }

  final _dialog = RatingDialog(
    initialRating: 1.0,

    title: Text(
      'Rating Our App',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        color: ColorConst.subColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    // encourage your user to leave a high rating?
    message: Text(
      'Tap a star to set your rating.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: ColorConst.subColor),
    ),
    // your app's logo?
    image: Image.asset(
      ImgConst.splash,
      height: 100,
      width: 100,
    ),
    submitButtonText: 'Submit',
    submitButtonTextStyle: TextStyle(
      color: ColorConst.subColor,
    ),

    commentHint: 'Tell others what you think',
    enableComment: false,
    showCloseButton: true,
    starSize: 30,
    onCancelled: () => log('cancelled'),
    onSubmitted: (response) async {
      log('rating: ${response.rating}, comment: ${response.comment}');
/*      if (response.rating < 4.0) {
        Get.back();
        // send their comments to your email or anywhere you wish
        // ask the user to contact you instead of leaving a bad review
      } else {
        const androidUrl =
            'https://play.google.com/store/apps/details?id=com.app.r.currency.s.converter.currency_converter';
        const iOSUrl =
            'https://apps.apple.com/app/com.app.r.currency.s.converter.currencyConverter';

        if (defaultTargetPlatform == TargetPlatform.android) {
          await launchUrl(Uri.parse(androidUrl));
        }
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          await launchUrl(Uri.parse(iOSUrl));
        }
      }*/
      const androidUrl =
          'https://play.google.com/store/apps/details?id=com.app.r.currency.s.converter.currency_converter';
      const iOSUrl =
          'https://apps.apple.com/app/com.app.r.currency.s.converter.currencyConverter';

      if (defaultTargetPlatform == TargetPlatform.android) {
        await launchUrl(Uri.parse(androidUrl));
      }
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        await launchUrl(Uri.parse(iOSUrl));
      }
    },
  );

  void shareApp() async {
    const String message = 'Check out my app:';
    const String appLinkAndroid =
        'https://play.google.com/store/apps/details?id=com.app.r.currency.s.converter.currency_converter';
    const String appLinkiOS =
        'https://apps.apple.com/app/com.app.r.currency.s.converter.currencyConverter';

    String appLink;
    if (defaultTargetPlatform == TargetPlatform.android) {
      appLink = appLinkAndroid;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      appLink = appLinkiOS;
    } else {
      throw 'Unsupported platform';
    }

    String shareText = '$message\n$appLink';
    Share.share(shareText);
  }

  Widget getOptions(
      {required void Function()? onTap,
      required IconData icon,
      required String title,
      required String subTitle}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: ColorConst.transparent,

        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
            ),
            buildSize(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  weight: true,
                ),
                buildSize(height: 2),
                SizedBox(
                    width: Get.width * 0.7,
                    child: SubTitleText(
                      text: subTitle,
                      align: TextAlign.start,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
