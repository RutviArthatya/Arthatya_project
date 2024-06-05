import 'dart:convert';
import 'dart:io';

import 'package:currency_converter/custom/custom_appbar.dart';
import 'package:currency_converter/custom/custom_text.dart';
import 'package:currency_converter/screens/home/theme_controller/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_searchable_dropdown/flutter_searchable_dropdown.dart';
import 'package:get/get.dart';

import '../../ads/constant/constant.dart';
import '../../ads/google_native_medium_ad.dart';
import '../../constant/color_const.dart';
import '../../custom/custom_button.dart';
import '../../custom/custom_decoration.dart';
import '../../custom/custom_dropdown.dart';
import '../../custom/custom_field.dart';
import '../../custom/custom_size.dart';
import '../../model/api3_model.dart';
import '../../routing/routes.dart';
import 'currency_controller/converttoany_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AnyCurrencyConversionController controller =
      Get.put(AnyCurrencyConversionController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    // if (showIntro.value) {
    //   getPreLoadAds();
    // }
    // TODO: implement initState
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: Scaffold(
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          // child: CircularProgressIndicator(),
          child: CupertinoActivityIndicator(
            color: themeController.themeMode.value == ThemeMode.light
                ? ColorConst.blackColor
                : ColorConst.lightGrey,
          ),
        );
      } else {
        RatesModel ratesModel =
            ratesModelFromJson(json.encode(controller.dataList1.value));
        List<String> currencies = ratesModel.rates!.keys.toList();
        Map<String, double> rates = ratesModel.rates!;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GoogleNativeMediumAd(),

                // buildSize(height: 5),
                CustomText(
                  text: "Enter Amount",
                  align: TextAlign.start,
                ),
                buildSize(height: 5),
                getField(rates),
                buildSize(),

                getDropDownButtons1(currencies),
                buildSize(),
                getResetButton(),
                buildSize(),
                buildAns(),

              ],
            ),
          ),
        );
      }
    });
  }

  Widget buildAns(){
    return buildCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.topRight,
              child: GestureDetector(
                  onTap: () {
                    final data =
                    ClipboardData(text: controller.answer.value);
                    Clipboard.setData(data);
                    // Optional: show a snackbar or toast to indicate that the text has been copied
                    Get.snackbar(
                        'Copied', 'Text has been copied to clipboard',
                        backgroundColor: ColorConst.white);
                  },
                  child: Icon(Icons.copy)),
            ),
            buildSize(),
            Obx(() => CustomText(
              text: controller.answer.value,
              weight: true,
            )),
          ],
        ));
  }

  Future<bool> _onBackButtonPressed() async {
    return await showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Set border radius
              ),
              title: CustomText(
                text: "Exit App",
                weight: true,
                align: TextAlign.start,
              ),
              content: CustomText(
                text: "Do you want to exit the app?",
                align: TextAlign.start,
              ),
              actionsPadding:
                  const EdgeInsets.only(right: 10, bottom: 15, top: 10),
              actions: [
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConst.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Set border radius
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      "No",
                      style: TextStyle(
                        color: ColorConst.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConst.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Set border radius
                      ),
                    ),
                    onPressed: () {
                      exit(0);
                      // Navigator.of(context).pop(true);
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: ColorConst.white,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    /*     child: CustomText(
                  text: "Yes",
                  color: ColorConst.white,
                ),*/
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Widget getField(Map<String, double> rates) {
    return CustomTextFormField(
      hintText: "Enter Amount",
      length: 10,
      controller: controller.amountController,
      keyboardType: TextInputType.number,
      onChanged: (rate) {
        controller.calculate(
          controller.amountController.text,
          controller.dropdownValue1.value,
          controller.dropdownValue2.value,
          rates,
        );
      },
    );
  }

  Widget getDropDownButtons1(List<String> currencies) {
    return Row(
      children: [
        Expanded(
          child: buildDropDown(
            value: controller.dropdownValue1, // Pass the RxString variable
            items: currencies.map<DropdownMenuItem<String>>((String currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child: Text(
                  currency,
                  style: TextStyle(color: ColorConst.buttonColor),
                ),
                // child: CustomText(text: currency,),
              );
            }).toList(),
            onChanged: (String? newValue) {
              controller.updateDropdownValue1(newValue ?? '');
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundColor: ColorConst.buttonColor,
            child: GestureDetector(
                onTap: () {
                  String temp = controller.dropdownValue1.value;
                  controller
                      .updateDropdownValue1(controller.dropdownValue2.value);
                  controller.updateDropdownValue2(temp);
                },
                child: Icon(Icons.swap_horiz,color: ColorConst.white,)),
          ),
        ),
        Expanded(
          child: buildDropDown(
            value: controller.dropdownValue2, // Pass the RxString variable
            items: currencies.map<DropdownMenuItem<String>>((String currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child: Text(currency,
                    style: TextStyle(color: ColorConst.buttonColor)),
                // child: CustomText(text: currency,),
              );
            }).toList(),
            onChanged: (String? newValue) {
              controller.updateDropdownValue2(newValue ?? '');
            },
          ),
        )
      ],
    );
  }

  Widget getResetButton() {
    // return CustomButton(onPressed: () {
    //   controller.reset();
    // }, buttonText: "Reset", weight: true,);
    return Row(
      children: [
        Expanded(
          child: CustomButton(
              onPressed: () {
                controller.reset();
              },
              buttonText: "Reset",
              weight: true),
        ),
        Obx(() => IconButton(
              onPressed: () async {
                await controller.toggleFavorite();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(controller.isFavorited.value
                          ? 'Added to Favorites'
                          : 'Removed from Favorites')),
                );
              },
              icon: Icon(Icons.favorite,
                  color:
                      controller.isFavorited.value ? Colors.red : Colors.grey),
            ))
      ],
    );
  }
}
