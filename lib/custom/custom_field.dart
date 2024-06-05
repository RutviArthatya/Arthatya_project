import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/color_const.dart';
import '../screens/home/theme_controller/theme_controller.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    required this.hintText,
    this.length,
    this.keyboardType,
    this.fontSize,
    this.vertical,
    this.fillColor,
    this.color,
    this.onChanged,
    this.inputFormatters,
    this.initialValue,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final int? length;
  final TextInputType? keyboardType;
  final double? fontSize;
  final double? vertical;
  final Color? fillColor;
  final Color? color;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: ColorConst.buttonColor),
      controller: controller,
      cursorColor: ColorConst.grey,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      initialValue: initialValue,


      decoration: InputDecoration(
        suffixIcon: suffixIcon,

        filled: true, // Set filled to true
        fillColor: fillColor ?? ColorConst.white,
        hintText: hintText,
        hintStyle: TextStyle(color: ColorConst.buttonColor,fontSize: fontSize),
        contentPadding: EdgeInsets.symmetric(vertical: vertical ?? 12.0 ,horizontal: 12), // Adjust the vertical padding
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: color ?? ColorConst.subColor),
        ),
        focusedBorder: OutlineInputBorder(
          // Customize border color when focused
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: color ?? ColorConst.subColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color ?? ColorConst.subColor),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: color ?? ColorConst.subColor),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter valid input";
        }
        return null;
      },
    );
  }
}


//-----------2-------------

class CustomTextFormField1 extends StatelessWidget {
  CustomTextFormField1({
    Key? key,
    this.controller,
    required this.hintText,
    this.length,
    this.keyboardType,
    this.fontSize,
    this.vertical,
    this.fillColor,
    this.color,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final int? length;
  final TextInputType? keyboardType;
  final double? fontSize;
  final double? vertical;
  final Color? fillColor;
  final Color? color;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {

    return Obx(() => Center(
      child: SizedBox(
        width: Get.width * 0.3,
        child: TextFormField(
          style: TextStyle(color: themeController.themeMode.value == ThemeMode.light ? ColorConst.blackColor : ColorConst.lightGrey,),
          controller: controller,
          cursorColor: ColorConst.grey,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(

            filled: true, // Set filled to true
            fillColor: fillColor ?? ColorConst.transparent,
            hintText: hintText,
            hintStyle: TextStyle(color: themeController.themeMode.value == ThemeMode.light ? ColorConst.blackColor : ColorConst.lightGrey,fontSize: fontSize),
            contentPadding: EdgeInsets.symmetric(vertical: vertical ?? 5.0 ,horizontal: 12), // Adjust the vertical padding
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: color ?? ColorConst.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              // Customize border color when focused
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: color ?? ColorConst.transparent),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color ?? ColorConst.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: color ?? ColorConst.transparent),
            ),
          ),
          onChanged: onChanged,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter valid input";
            }
            return null;
          },
        ),
      ),
    ));
  }
}
