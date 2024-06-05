
import 'package:currency_converter/routing/page_routing.dart';
import 'package:currency_converter/routing/routes.dart';
import 'package:currency_converter/screens/home/theme_controller/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant/color_const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  // SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: PageRouting().pageRouting,
          initialRoute: Routes.splash,
          title: 'Flutter Demo',
          theme: ThemeData.light().copyWith(
            colorScheme:
                ColorScheme.fromSeed(seedColor: ColorConst.buttonColor),
          ),
          darkTheme: ThemeData.dark().copyWith(
            colorScheme:
                ColorScheme.fromSeed(seedColor: ColorConst.buttonColor),
          ),
          themeMode: themeController.themeMode.value,
        ));
  }
}
