
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../constant/string_const.dart';

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../constant/string_const.dart';
import '../../../../model/api3_model.dart';

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../constant/string_const.dart';

class ExchangeListController extends GetxController {
  var dataList1 = {}.obs;
  var isLoading = true.obs;
  var selectedCountry = 'USD'.obs;  // Default to USD
  var enteredAmount = 1.0.obs;      // Default amount 1
  var updatedRates = <String, double>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getData();  // Fetch data when the controller is initialized
  }

  void getData() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(StringConst.url));
      if (response.statusCode == 200) {
        dataList1.value = json.decode(response.body);
        log("dataList1 = $dataList1");
        calculateUpdatedRates();
      } else {
        throw Exception('Failed to load data');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void setSelectedCountry(String country) {
    selectedCountry.value = country;
    calculateUpdatedRates();
  }

  void setEnteredAmount(double amount) {
    enteredAmount.value = amount;
    calculateUpdatedRates();
  }

  void calculateUpdatedRates() {
    if (selectedCountry.value.isEmpty || dataList1.isEmpty) return;
    RatesModel ratesModel = ratesModelFromJson(json.encode(dataList1.value));
    double selectedRate = ratesModel.rates![selectedCountry.value] ?? 1.0;

    updatedRates.clear();
    ratesModel.rates!.forEach((currency, rate) {
      updatedRates[currency] = (rate / selectedRate) * enteredAmount.value;
    });
  }
}

