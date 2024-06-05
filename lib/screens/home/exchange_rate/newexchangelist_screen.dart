
import 'dart:convert';
import 'dart:io';
import 'package:currency_converter/custom/custom_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../../ads/constant/constant.dart';
import '../../../ads/google_native_small_ad.dart';
import '../../../constant/color_const.dart';
import '../../../custom/custom_size.dart';
import '../../../custom/custom_text.dart';
import '../../../model/api3_model.dart';
import '../currency_controller/converttoany_controller.dart';
import '../theme_controller/theme_controller.dart';
import 'exchangelist_cintroller/exchangeList_controller.dart';

class NewExchangeListScreen extends StatefulWidget {
  const NewExchangeListScreen({super.key});

  @override
  State<NewExchangeListScreen> createState() => _NewExchangeListScreenState();
}

class _NewExchangeListScreenState extends State<NewExchangeListScreen> {
  final ExchangeListController controller = Get.put(ExchangeListController());
  final AnyCurrencyConversionController controller1 =
  Get.put(AnyCurrencyConversionController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    super.initState();
    // Lock screen orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Unlock screen orientation when leaving the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: Scaffold(
        body: SafeArea(
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        buildDropdown(),
                        buildAmountField(),
                        buildSize(height: 12),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: Get.height * 0.62,
                    decoration: const BoxDecoration(
                      color: ColorConst.buttonColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16),
                      child: Column(
                        children: [

                          buildSize(height: 6),
                          Expanded(child: buildRatesList()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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

  Widget buildDropdown() {
    return Obx(() {
      if (controller.dataList1.isEmpty) {
        return CupertinoActivityIndicator(
          color: themeController.themeMode.value == ThemeMode.light
              ? ColorConst.blackColor
              : ColorConst.lightGrey,
        );
      }
      RatesModel ratesModel =
      ratesModelFromJson(json.encode(controller.dataList1.value));
      List<String> currencies = ratesModel.rates!.keys.toList();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: Get.width * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButtonFormField<String>(
                value: controller.selectedCountry.value,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: currencies.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                style: TextStyle(
                  color: themeController.themeMode.value == ThemeMode.light
                      ? ColorConst.blackColor
                      : ColorConst.lightGrey,
                ),
                onChanged: (newValue) {
                  controller.setSelectedCountry(newValue!);
                },
                decoration: InputDecoration(
                  filled: true, // Set filled to true
                  fillColor: ColorConst.transparent,
                  hintStyle: TextStyle(
                    color: themeController.themeMode.value == ThemeMode.light
                        ? ColorConst.blackColor
                        : ColorConst.lightGrey,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 60.0 / 2 - 20), // Adjusting height
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorConst.transparent),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorConst.transparent),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildAmountField() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomTextFormField(
          hintText: "1.0",
          suffixIcon: Icon(Icons.calculate),
          initialValue: controller.enteredAmount.value.toString(),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            double amount = double.tryParse(value) ?? 1.0;
            controller.setEnteredAmount(amount);
          },
        ),
      );
    });
  }

  Widget buildRatesList() {
    return Obx(() {
      if (controller.updatedRates.isEmpty) {
        return Center(
          child: CupertinoActivityIndicator(
            color: themeController.themeMode.value == ThemeMode.light
                ? ColorConst.blackColor
                : ColorConst.lightGrey,
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.updatedRates.length,
        itemBuilder: (context, index) {
          String currency = controller.updatedRates.keys.elementAt(index);
          double rate = controller.updatedRates[currency] ?? 0.0;

          if (index % 20 == 0 &&
              index != 0 &&
              googleNativeVisible.value == true) {
            return const GoogleNativeSmallAd();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConst.lightGreyBorder ,
                  border: Border.all(color: ColorConst.transparent),
                ),
                child: Row(
                  children: [
                    Text(currency,style: const TextStyle(fontFamily: "Poppins",color: ColorConst.buttonColor),),

                    const Spacer(),
                    Text(rate.toStringAsFixed(controller1.precision.value),style: const TextStyle(fontFamily: "Poppins",color: ColorConst.buttonColor),),

                  ],
                ),
              ),
            );
          }
        },
      );
    });
  }
}
