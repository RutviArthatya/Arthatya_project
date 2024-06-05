// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../constant/color_const.dart';
// import 'custom_text.dart';
//
// PreferredSizeWidget buildAppbar({required String title}) {
//   return AppBar(
//     elevation: 2,
//     shadowColor: Colors.grey.shade50,
//     title: CustomText(
//       text: title,
//       color: ColorConst.white,
//       size: 16,
//       weight: true,
//     ),
//
//     backgroundColor: ColorConst.buttonColor,
//     iconTheme: IconThemeData(color: ColorConst.white),
// /*    leading: IconButton(
//       icon: const Icon(Icons.arrow_back_ios_new_outlined,size: 18,),
//       color: ColorConst.white,
//       onPressed: () {
//         Get.back();
//       },
//     ),*/
//   );
// }

import 'package:currency_converter/custom/subtitle_text.dart';
import 'package:flutter/material.dart';
import '../constant/color_const.dart';
import 'custom_text.dart';

PreferredSizeWidget buildAppbar({required String title,List<Widget>? actions}) {
  return AppBar(
    // elevation: 2,
    shadowColor: Colors.grey.shade50,
    title: SubTitleText(
      text: title,
      color: ColorConst.white,
      size: 16,
      weight: true,
    ),
    backgroundColor: ColorConst.buttonColor,
    iconTheme: const IconThemeData(color: ColorConst.white),
    actions: actions,
  );
}
