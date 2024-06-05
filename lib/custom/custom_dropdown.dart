

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color_const.dart';
import '../screens/home/theme_controller/theme_controller.dart'; // Import GetX package

Widget buildDropDown({
  required RxString value, // RxString variable
  required List<DropdownMenuItem<String>> items,
  required void Function(String?) onChanged,
  Color? fillColor,
}) {
  return DropdownButtonFormField<String>( // Specify the generic type of DropdownButtonFormField
    value: value.value, // Access the value property of RxString
    isExpanded: true,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),

      filled: true, // Set filled to true
      fillColor: fillColor ?? ColorConst.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorConst.subColor),
      ),
      focusedBorder: OutlineInputBorder(
        // Customize border color when focused
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorConst.subColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorConst.subColor),
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorConst.subColor),
      ),
    ),
    items: items,
    onChanged: onChanged,
  );
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../constant/color_const.dart'; // Import GetX package
//
// Widget buildDropDown({
//   required RxString value, // RxString variable
//   required List<DropdownMenuItem<String>> items,
//   required void Function(String?) onChanged,
//   Color? fillColor,
// }) {
//   return DropdownButtonFormField<String>(
//     // Specify the generic type of DropdownButtonFormField
//     value: value.value, // Access the value property of RxString
//
//     items: items,
//     onChanged: onChanged,
//   );
// }

// Widget dropDown1({
//   required void Function(String?) onChanged,
//   required List<DropdownMenuItem<String>> items,
//   required RxString value,
// }) {
//   return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         DropdownButton(
//
//           value: value.value,
//           icon: const Icon(Icons.keyboard_arrow_down),
//           items: items,
//
//           onChanged: onChanged,
//
//         ),
//       ],
//     ),
//   );
// }


Widget dropDown1({
  required void Function(String?) onChanged,
  required List<DropdownMenuItem<String>> items,
  required RxString value,
  Color borderColor = ColorConst.transparent,
  double borderRadiusHeight = 5.0,
  double dropdownHeight = 60.0,
  Color? fillColor,
}) {
  ThemeController themeController = Get.put(ThemeController());
  return Center(
    child: SizedBox(
      width: Get.width * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => DropdownButtonFormField<String>(
            value: value.value,

            icon: const Icon(Icons.keyboard_arrow_down),
            items: items,
            style: TextStyle(
              color: themeController.themeMode.value == ThemeMode.light
                  ? ColorConst.blackColor
                  : ColorConst.lightGrey,
            ),
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true, // Set filled to true
              fillColor: fillColor ?? ColorConst.transparent,
              hintStyle: TextStyle(color: themeController.themeMode.value == ThemeMode.light
                  ? ColorConst.blackColor
                  : ColorConst.lightGrey,),
              contentPadding: EdgeInsets.symmetric(
                  vertical: dropdownHeight / 2 - 20), // Adjusting height
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(borderRadiusHeight),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(borderRadiusHeight),
              ),
            ),
          )),
        ],
      ),
    ),
  );
}
