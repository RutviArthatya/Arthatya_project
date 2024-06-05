


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color_const.dart';
import '../screens/home/theme_controller/theme_controller.dart';

class CustomText extends StatelessWidget {
  CustomText({Key? key, this.color, this.align, this.size, required this.text, this.weight, this.overflow, this.ls}) : super(key: key);

  final String text;
  final bool? weight;
  final double? ls;
  final double? size;
  final Color? color;
  final TextAlign? align;
  final TextOverflow? overflow;

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Text(
      text,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        fontSize: size ?? 14,
        letterSpacing: ls,
        color: themeController.themeMode.value == ThemeMode.light ? ColorConst.blackColor : ColorConst.lightGrey,
        fontWeight: weight == true ? FontWeight.bold : FontWeight.normal,
        overflow: overflow ?? TextOverflow.fade,
        fontFamily: 'Poppins',
      ),
    ));
  }
}
