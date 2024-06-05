import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constant/color_const.dart';
import '../screens/home/theme_controller/theme_controller.dart';
import 'custom_text.dart';

// BoxDecoration buildDecoration(){
//   return BoxDecoration(
//     borderRadius: BorderRadius.circular(10),
//     color: ColorConst.white,
//     border: Border.all(color: ColorConst.transparent),
//
//   );
// }

Widget buildCard({required Widget? child}) {
  final ThemeController themeController = Get.put(ThemeController());
  return Obx(() => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: themeController.themeMode.value == ThemeMode.light ? ColorConst.lightGreyBorder : ColorConst.buttonColor,
      border: Border.all(color: ColorConst.transparent),
    ),
    child: child,
  ));
}
