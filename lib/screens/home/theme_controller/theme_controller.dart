import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var themeMode = ThemeMode.light.obs;

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    print("themeMode.value ??? ${themeMode.value}");
  }

}

